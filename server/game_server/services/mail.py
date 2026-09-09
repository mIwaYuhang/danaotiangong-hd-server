"""邮件：列表、详情、领取附件、删除、清理、发送。

邮件对象（客户端 MailScene）：``PKID, MailType(1 系统 / 2 战斗 / 3 好友 / 4 包裹), MessageContent, SendTime,
ReadingState(0 未读 / 1 已读), HaveAccessory(0/1), IsDealWith(0 未领 / 1 已领), PlayerID, NickName, MailAccessory[]``。
没有独立标题字段，列表与正文都显示 ``MessageContent``。
"""
from copy import deepcopy

from ..errors import BusinessError
from .base import Reply, RoleContext
from .clock import Clock
from .inventory import Ledger

MAIL_SYSTEM, MAIL_BATTLE, MAIL_FRIEND, MAIL_PACKAGE = 1, 2, 3, 4
PAGE_SIZE = 10
STATE_MAIL_NOT_FOUND = -1109000
STATE_MAIL_NO_ATTACHMENT = -1109001
STATE_MAIL_DEALT = -1109002


class MailService:
    def __init__(self, ledger: Ledger, clock: Clock, system_name: str, events=None):
        self.ledger = ledger
        self.clock = clock
        self.system_name = system_name
        self.events = events

    # ---- 供其他系统调用 ---------------------------------------------------------

    def send_system(self, state: dict, content: str, attachments=(), mail_type: int = MAIL_SYSTEM) -> dict:
        box = state['Mail']
        mail = dict(PKID=box['next_id'], MailType=mail_type, MessageContent=content, SendTime=self.clock.now(),
                    ReadingState=0, HaveAccessory=1 if attachments else 0, IsDealWith=0 if attachments else 1,
                    PlayerID=0, NickName=self.system_name, MailAccessory=[dict(x) for x in attachments])
        box['next_id'] += 1
        box['items'].insert(0, mail)
        return mail

    @staticmethod
    def unread_count(state: dict) -> int:
        return sum(1 for m in state['Mail']['items'] if not m['ReadingState'])

    def _find(self, state: dict, mail_id: int) -> dict:
        mail = next((m for m in state['Mail']['items'] if m['PKID'] == mail_id), None)
        if mail is None:
            raise BusinessError('邮件不存在', STATE_MAIL_NOT_FOUND)
        return mail

    # ---- 接口 -------------------------------------------------------------

    def list_mails(self, ctx: RoleContext, params) -> dict:
        """``/Mailinfo/GetMailinfoList?index&type``。"""
        page, mail_type = max(1, params['index']), params['type']
        items = [m for m in ctx.state['Mail']['items'] if mail_type == 0 or m['MailType'] == mail_type]
        start = (page - 1) * PAGE_SIZE
        chunk = items[start:start + PAGE_SIZE]
        fields = ('PKID', 'MessageContent', 'SendTime', 'ReadingState', 'HaveAccessory', 'IsDealWith', 'MailType')
        return {'MailList': [{k: m[k] for k in fields} for m in chunk], 'isnext': 1 if len(items) > start + PAGE_SIZE else 0}

    def detail(self, ctx: RoleContext, params) -> dict:
        """``/Mailinfo/GetMailinfo?mailId``：读取即标记已读。"""
        mail = self._find(ctx.state, params['mailId'])
        if not mail['ReadingState']:
            mail['ReadingState'] = 1
            ctx.state['Counters']['mail_read'] = ctx.state['Counters'].get('mail_read', 0) + 1
            self._emit(ctx.state, 'mail_read', 1)
        return deepcopy(mail)

    def take_attachment(self, ctx: RoleContext, params) -> Reply:
        """``/Mailinfo/GetPlayerAccessory?mailId``。"""
        state = ctx.state
        mail = self._find(state, params['mailId'])
        if not mail['HaveAccessory']:
            raise BusinessError('该邮件没有附件', STATE_MAIL_NO_ATTACHMENT)
        if mail['IsDealWith']:
            raise BusinessError('附件已领取', STATE_MAIL_DEALT)
        outcome = self.ledger.apply(state, rewards=mail['MailAccessory'])
        mail = self._find(state, params['mailId'])
        mail['IsDealWith'], mail['ReadingState'] = 1, 1
        return Reply({'Reward': deepcopy(outcome.rewards)}, self.ledger.global_for(state, outcome))

    def unread(self, ctx: RoleContext, params) -> dict:
        """``/Mailinfo/SeeUnreadMailNumber``。"""
        return {'Count': self.unread_count(ctx.state)}

    def delete(self, ctx: RoleContext, params) -> dict:
        """``/Mailinfo/DeletePlayerMailId?mailid``。"""
        mail = self._find(ctx.state, params['mailid'])
        if mail['HaveAccessory'] and not mail['IsDealWith']:
            raise BusinessError('请先领取附件')
        ctx.state['Mail']['items'].remove(mail)
        return {}

    def clear(self, ctx: RoleContext, params) -> dict:
        """``/Mailinfo/ClickPlayerMail?mailType``：删除该分类下已处理的邮件（未领附件的保留）。"""
        return self._remove(ctx.state, params['mailType'], only_read=False)

    def clear_read(self, ctx: RoleContext, params) -> dict:
        """``/Mailinfo/ClickPlayerMailRead?mailType``：只删除已读且已处理的邮件。"""
        return self._remove(ctx.state, params['mailType'], only_read=True)

    def _remove(self, state: dict, mail_type: int, only_read: bool) -> dict:
        keep = []
        for mail in state['Mail']['items']:
            in_scope = mail_type == 0 or mail['MailType'] == mail_type
            deletable = in_scope and (mail['IsDealWith'] or not mail['HaveAccessory']) and (mail['ReadingState'] or not only_read)
            if not deletable:
                keep.append(mail)
        state['Mail']['items'] = keep
        return {}

    def send(self, ctx: RoleContext, params) -> dict:
        """``/Mailinfo/SendMail?toplayerid``：本地服只有一个玩家，暂不支持互发。"""
        raise BusinessError('本地服暂不支持给其他玩家发送邮件')

    def _emit(self, state: dict, kind: str, amount: int):
        if self.events is not None:
            self.events.on(state, kind, amount)
