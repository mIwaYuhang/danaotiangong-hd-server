"""服务器时间：统一的“现在”、游戏日与月份键、倒计时。

所有与时间相关的业务（体力恢复、每日重置、免费招募冷却、扫荡 CD、双倍经验）都通过 ``Clock``
取时间，测试时可用 ``Clock.freeze()`` 固定或推进时间。
"""
import datetime as _dt
import time


class Clock:
    def __init__(self, daily_reset_hour: int):
        self.daily_reset_hour = daily_reset_hour
        self._frozen = None

    # ---- 当前时间 -----------------------------------------------------------

    def now(self) -> int:
        """当前 Unix 秒。"""
        return int(time.time()) if self._frozen is None else self._frozen

    def freeze(self, timestamp: int):
        """固定当前时间（仅测试使用）；传 ``None`` 恢复真实时间。"""
        self._frozen = timestamp

    def advance(self, seconds: int):
        """在冻结状态下推进时间（仅测试使用）。"""
        self._frozen = self.now() + seconds

    # ---- 游戏日 -----------------------------------------------------------

    def _shifted(self, timestamp=None) -> _dt.datetime:
        ts = self.now() if timestamp is None else timestamp
        return _dt.datetime.fromtimestamp(ts) - _dt.timedelta(hours=self.daily_reset_hour)

    def day_key(self, timestamp=None) -> str:
        """游戏日键 ``YYYY-MM-DD``（按每日重置小时偏移）。"""
        return self._shifted(timestamp).strftime('%Y-%m-%d')

    def month_key(self, timestamp=None) -> str:
        return self._shifted(timestamp).strftime('%Y-%m')

    def day_of_month(self, timestamp=None) -> int:
        return self._shifted(timestamp).day

    def seconds_until_next_day(self, timestamp=None) -> int:
        """距下一次每日重置的秒数。"""
        shifted = self._shifted(timestamp)
        next_day = (shifted + _dt.timedelta(days=1)).replace(hour=0, minute=0, second=0, microsecond=0)
        return max(0, int((next_day - shifted).total_seconds()))

    @staticmethod
    def remaining(until: int, now: int) -> int:
        """倒计时剩余秒数（不为负）。"""
        return max(0, int(until) - now)
