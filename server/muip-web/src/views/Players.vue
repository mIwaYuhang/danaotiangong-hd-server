<script setup>
import { onMounted, reactive, ref } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { api, formatTime } from '../api'
import RewardEditor from '../components/RewardEditor.vue'

const query = ref('')
const players = ref([])
const loading = ref(false)
const meta = ref({ editableFields: {}, resourceTypes: {} })

const drawer = ref(false)
const detail = ref(null)
const tab = ref('info')
const form = reactive({ Name: '', Banned: false, fields: {} })
const grants = ref([])
const mail = reactive({ content: '', attachments: [] })
const progress = reactive({ maxStage: 0, towerFloor: 0, tiroMaxStep: 0 })
const heroGrant = ref(null)
const heroOptions = ref([])
const rechargeIngot = ref(1000)
const monthDays = ref(30)
const busy = ref(false)

async function search() {
  loading.value = true
  try {
    players.value = (await api.players(query.value)).players
  } finally {
    loading.value = false
  }
}
onMounted(async () => {
  meta.value = await api.status()
  search()
})

async function open(row) {
  detail.value = await api.player(row.userId)
  form.Name = detail.value.summary.name
  form.Banned = detail.value.banned
  form.fields = { ...detail.value.resources }
  grants.value = []
  mail.content = ''
  mail.attachments = []
  Object.assign(progress, detail.value.progress)
  heroGrant.value = null
  tab.value = 'info'
  drawer.value = true
}
async function refresh() {
  detail.value = await api.player(detail.value.summary.userId)
  form.fields = { ...detail.value.resources }
  form.Banned = detail.value.banned
  form.Name = detail.value.summary.name
  Object.assign(progress, detail.value.progress)
  await search()
}

async function saveFields() {
  const changed = {}
  for (const [k, v] of Object.entries(form.fields)) if (v !== detail.value.resources[k]) changed[k] = v
  if (form.Name !== detail.value.summary.name) changed.Name = form.Name
  if (form.Banned !== detail.value.banned) changed.Banned = form.Banned
  if (!Object.keys(changed).length) return ElMessage.info('没有改动')
  busy.value = true
  try {
    await api.updatePlayer(detail.value.summary.userId, changed)
    ElMessage.success('已保存')
    await refresh()
  } finally {
    busy.value = false
  }
}
async function doGrant() {
  if (!grants.value.length) return ElMessage.warning('请先添加物品')
  busy.value = true
  try {
    const res = await api.grant(detail.value.summary.userId, grants.value)
    ElMessage.success(`已发放 ${res.granted.length} 项`)
    grants.value = []
    await refresh()
  } finally {
    busy.value = false
  }
}
async function doMail() {
  if (!mail.content.trim()) return ElMessage.warning('请填写邮件内容')
  busy.value = true
  try {
    await api.mail(detail.value.summary.userId, mail.content, mail.attachments)
    ElMessage.success('邮件已发送')
    mail.content = ''
    mail.attachments = []
    await refresh()
  } finally {
    busy.value = false
  }
}
async function doResetDaily() {
  await ElMessageBox.confirm('将清空该玩家今日的各类次数与计数（相当于跨天），确定？', '重置每日', { type: 'warning' })
  await api.resetDaily(detail.value.summary.userId)
  ElMessage.success('已重置')
  await refresh()
}
async function doMaxOut() {
  await ElMessageBox.confirm(
    '将解锁全部主将，账户升至满级，培养拉满，并为每名主将穿戴缘分或专属法宝。此操作直接改写存档，确定？',
    '一键全满',
    { type: 'warning', confirmButtonText: '执行' },
  )
  busy.value = true
  try {
    const res = await api.maxOut(detail.value.summary.userId)
    ElMessage.success(`已全满：${res.heroes} 名主将、穿戴 ${res.talismansEquipped} 件法宝`)
    await refresh()
  } finally {
    busy.value = false
  }
}
async function saveProgress() {
  const fields = {}
  if (progress.maxStage !== detail.value.progress.maxStage) fields.maxStage = progress.maxStage
  if (progress.towerFloor !== detail.value.progress.towerFloor) fields.towerFloor = progress.towerFloor
  if (progress.tiroMaxStep !== detail.value.progress.tiroMaxStep) fields.tiroMaxStep = progress.tiroMaxStep
  if (!Object.keys(fields).length) return ElMessage.info('没有改动')
  busy.value = true
  try {
    await api.setProgress(detail.value.summary.userId, fields)
    ElMessage.success('进度已更新')
    await refresh()
  } finally {
    busy.value = false
  }
}
async function doSkipGuide() {
  await api.skipGuide(detail.value.summary.userId)
  ElMessage.success('已跳过引导')
  await refresh()
}
async function searchHeroes(q) {
  heroOptions.value = (await api.items(7, q || '')).items
}
async function doGrantHero() {
  if (!heroGrant.value) return ElMessage.warning('请选择要发放的主将')
  busy.value = true
  try {
    const res = await api.grantHero(detail.value.summary.userId, heroGrant.value)
    ElMessage.success(`已发放 ${res.name}`)
    heroGrant.value = null
    await refresh()
  } finally {
    busy.value = false
  }
}
async function saveHero(row) {
  busy.value = true
  try {
    await api.updateHero(detail.value.summary.userId, {
      heroId: row.heroId, level: row.level, rebirthCount: row.rebirthCount, rageTrained: row.rageTrained,
    })
    ElMessage.success(`${row.name} 已保存`)
    await refresh()
  } finally {
    busy.value = false
  }
}
async function doClearMails() {
  await ElMessageBox.confirm('将删除该玩家全部邮件（含未领附件），确定？', '清空邮箱', { type: 'warning' })
  const res = await api.clearMails(detail.value.summary.userId)
  ElMessage.success(`已删除 ${res.removed} 封`)
  await refresh()
}
async function doDeleteMail(id) {
  await api.deleteMail(detail.value.summary.userId, id)
  ElMessage.success('已删除')
  await refresh()
}
async function doBagRemove(row) {
  await api.bagRemove(detail.value.summary.userId, { Type: row.Type, ID: row.ID, Count: row.Count })
  ElMessage.success(`已扣除 ${row.name || row.ID}`)
  await refresh()
}
async function doRecharge() {
  const res = await api.recharge(detail.value.summary.userId, rechargeIngot.value)
  ElMessage.success(`累计充值 ${res.rechargeTotal}，当前 VIP ${res.vip}`)
  await refresh()
}
async function doMonthCard() {
  const res = await api.monthCard(detail.value.summary.userId, monthDays.value)
  ElMessage.success(`月卡剩余 ${Math.ceil(res.monthCardLeft / 86400)} 天`)
  await refresh()
}
async function doGrowup() {
  await api.growup(detail.value.summary.userId)
  ElMessage.success('已开通成长计划')
  await refresh()
}
async function doLeaveUnion() {
  await ElMessageBox.confirm('将该玩家移出当前仙盟？盟主且仙盟内还有其他人时会被拒绝。', '退出仙盟', { type: 'warning' })
  await api.leaveUnion(detail.value.summary.userId)
  ElMessage.success('已退出仙盟')
  await refresh()
}
const fmtLeft = (sec) => (sec > 0 ? `${Math.ceil(sec / 86400)} 天` : '未开通')
</script>

<template>
  <el-card shadow="never">
    <template #header>
      <el-space>
        <el-input v-model="query" placeholder="玩家 ID 或昵称（留空显示最新）" clearable style="width: 320px" @keyup.enter="search" @clear="search" />
        <el-button type="primary" :loading="loading" @click="search">搜索</el-button>
      </el-space>
    </template>
    <el-table :data="players" v-loading="loading" stripe highlight-current-row @row-click="open" style="cursor: pointer">
      <el-table-column prop="userId" label="ID" width="80" />
      <el-table-column prop="name" label="昵称" width="150" />
      <el-table-column prop="level" label="等级" width="70" />
      <el-table-column prop="vip" label="VIP" width="60" />
      <el-table-column prop="battlePower" label="战力" width="100" />
      <el-table-column prop="gold" label="银币" width="110" />
      <el-table-column prop="ingot" label="元宝" width="90" />
      <el-table-column prop="union" label="仙盟" width="120" />
      <el-table-column label="最近活跃" width="170" :formatter="(r) => formatTime(r.lastSeenAt)" />
      <el-table-column label="状态" width="90">
        <template #default="{ row }"><el-tag :type="row.banned ? 'danger' : 'success'" size="small">{{ row.banned ? '已封禁' : '正常' }}</el-tag></template>
      </el-table-column>
    </el-table>
  </el-card>

  <el-drawer v-model="drawer" size="860px" :title="detail ? `${detail.summary.name}（ID ${detail.summary.userId}）` : ''" destroy-on-close>
    <el-tabs v-if="detail" v-model="tab">
      <el-tab-pane label="基本信息" name="info">
        <el-descriptions :column="3" border size="small" style="margin-bottom: 14px">
          <el-descriptions-item label="战力">{{ detail.summary.battlePower }}</el-descriptions-item>
          <el-descriptions-item label="英雄数">{{ detail.heroes.length }}</el-descriptions-item>
          <el-descriptions-item label="法宝数">{{ detail.talismans }}</el-descriptions-item>
          <el-descriptions-item label="邮件数">{{ detail.mailCount }}</el-descriptions-item>
          <el-descriptions-item label="引导进度">{{ detail.progress.tiroMaxStep }}</el-descriptions-item>
          <el-descriptions-item label="仙盟">{{ detail.summary.union || '-' }}</el-descriptions-item>
          <el-descriptions-item label="创建时间">{{ formatTime(detail.summary.createdAt) }}</el-descriptions-item>
          <el-descriptions-item label="最近活跃" :span="2">{{ formatTime(detail.summary.lastSeenAt) }}</el-descriptions-item>
        </el-descriptions>
        <el-form label-width="110px" size="small">
          <el-row :gutter="8">
            <el-col :span="12"><el-form-item label="昵称"><el-input v-model="form.Name" maxlength="12" /></el-form-item></el-col>
            <el-col :span="12"><el-form-item label="封禁"><el-switch v-model="form.Banned" active-text="封禁中" inactive-text="正常" /></el-form-item></el-col>
            <el-col :span="12" v-for="(label, key) in meta.editableFields" :key="key">
              <el-form-item :label="label"><el-input-number v-model="form.fields[key]" :min="0" :max="2000000000" controls-position="right" style="width: 100%" /></el-form-item>
            </el-col>
          </el-row>
          <el-form-item>
            <el-button type="primary" :loading="busy" @click="saveFields">保存修改</el-button>
            <el-button type="warning" plain @click="doResetDaily">重置每日次数</el-button>
            <el-button type="danger" plain :loading="busy" @click="doMaxOut">一键全满</el-button>
            <el-button plain @click="doSkipGuide">跳过引导</el-button>
            <el-button v-if="detail.progress.unionId" plain @click="doLeaveUnion">踢出仙盟</el-button>
          </el-form-item>
        </el-form>
      </el-tab-pane>

      <el-tab-pane label="进度" name="progress">
        <el-form label-width="120px" size="small">
          <el-form-item :label="`关卡 MaxPID（${detail.limits.firstStage}–${detail.limits.lastStage}）`">
            <el-input-number v-model="progress.maxStage" :min="detail.limits.firstStage" :max="detail.limits.lastStage" />
          </el-form-item>
          <el-form-item :label="`通天塔层数（0–${detail.limits.towerMax}）`">
            <el-input-number v-model="progress.towerFloor" :min="0" :max="detail.limits.towerMax" />
          </el-form-item>
          <el-form-item label="引导步数">
            <el-input-number v-model="progress.tiroMaxStep" :min="0" />
            <span class="hint">完成引导建议 ≥ {{ detail.limits.guideStep }}</span>
          </el-form-item>
          <el-form-item label="争霸名次">{{ detail.progress.arenaRank || '未上榜' }}</el-form-item>
          <el-form-item>
            <el-button type="primary" :loading="busy" @click="saveProgress">保存进度</el-button>
          </el-form-item>
        </el-form>
      </el-tab-pane>

      <el-tab-pane label="活动 / VIP" name="vip">
        <el-descriptions :column="2" border size="small" style="margin-bottom: 14px">
          <el-descriptions-item label="VIP">{{ detail.summary.vip }}</el-descriptions-item>
          <el-descriptions-item label="累计充值元宝">{{ detail.rechargeTotal }}</el-descriptions-item>
          <el-descriptions-item label="月卡剩余">{{ fmtLeft(detail.monthCardLeft) }}</el-descriptions-item>
          <el-descriptions-item label="成长计划">{{ detail.growupBought ? '已开通' : '未开通' }}</el-descriptions-item>
        </el-descriptions>
        <el-form label-width="110px" size="small">
          <el-form-item label="补累计充值">
            <el-input-number v-model="rechargeIngot" :min="1" :max="2000000000" />
            <el-button type="primary" style="margin-left: 8px" :loading="busy" @click="doRecharge">到账并刷新 VIP</el-button>
          </el-form-item>
          <el-form-item label="开通月卡">
            <el-input-number v-model="monthDays" :min="1" :max="3650" />
            <el-button type="primary" style="margin-left: 8px" :loading="busy" @click="doMonthCard">延长天数</el-button>
          </el-form-item>
          <el-form-item>
            <el-button :disabled="detail.growupBought" :loading="busy" @click="doGrowup">开通成长计划</el-button>
          </el-form-item>
        </el-form>
      </el-tab-pane>

      <el-tab-pane label="发放物品" name="grant">
        <RewardEditor v-model="grants" :resource-types="meta.resourceTypes" />
        <el-button type="primary" :loading="busy" style="margin-top: 12px" @click="doGrant">直接发放到背包</el-button>
      </el-tab-pane>

      <el-tab-pane label="发送邮件" name="mail">
        <el-input v-model="mail.content" type="textarea" :rows="4" maxlength="500" show-word-limit placeholder="邮件正文" style="margin-bottom: 12px" />
        <RewardEditor v-model="mail.attachments" :resource-types="meta.resourceTypes" />
        <el-button type="primary" :loading="busy" style="margin-top: 12px" @click="doMail">发送邮件</el-button>
      </el-tab-pane>

      <el-tab-pane label="英雄" name="heroes">
        <el-space style="margin-bottom: 12px">
          <el-select v-model="heroGrant" filterable remote :remote-method="searchHeroes" placeholder="检索要发放的主将" style="width: 280px">
            <el-option v-for="it in heroOptions" :key="it.id" :label="`${it.name} (#${it.id})`" :value="it.id" />
          </el-select>
          <el-button type="primary" :loading="busy" @click="doGrantHero">发放主将</el-button>
        </el-space>
        <el-table :data="detail.heroes" size="small" stripe max-height="480">
          <el-table-column prop="heroId" label="ID" width="70" />
          <el-table-column prop="name" label="名称" width="120" />
          <el-table-column label="等级" width="130">
            <template #default="{ row }"><el-input-number v-model="row.level" :min="1" :max="detail.summary.level" size="small" /></template>
          </el-table-column>
          <el-table-column label="进阶" width="120">
            <template #default="{ row }"><el-input-number v-model="row.rebirthCount" :min="0" :max="30" size="small" /></template>
          </el-table-column>
          <el-table-column label="技能训练" width="120">
            <template #default="{ row }"><el-input-number v-model="row.rageTrained" :min="1" :max="row.level" size="small" /></template>
          </el-table-column>
          <el-table-column prop="battlePower" label="战力" width="90" />
          <el-table-column label="阵位" width="90" :formatter="(r) => (r.battleIx ? `${r.battleIx} 号位` : '未上阵')" />
          <el-table-column label="操作" width="80">
            <template #default="{ row }"><el-button link type="primary" @click="saveHero(row)">保存</el-button></template>
          </el-table-column>
        </el-table>
      </el-tab-pane>

      <el-tab-pane label="邮箱" name="inbox">
        <el-button type="danger" plain size="small" style="margin-bottom: 8px" @click="doClearMails">清空全部邮件</el-button>
        <el-table :data="detail.mails" size="small" stripe max-height="480">
          <el-table-column prop="id" label="ID" width="70" />
          <el-table-column prop="from" label="发件人" width="100" />
          <el-table-column prop="content" label="内容" show-overflow-tooltip />
          <el-table-column label="时间" width="160" :formatter="(r) => formatTime(r.time)" />
          <el-table-column label="附件" width="70">
            <template #default="{ row }">{{ row.hasAttachment ? (row.claimed ? '已领' : '未领') : '-' }}</template>
          </el-table-column>
          <el-table-column label="操作" width="70">
            <template #default="{ row }"><el-button link type="danger" @click="doDeleteMail(row.id)">删除</el-button></template>
          </el-table-column>
        </el-table>
      </el-tab-pane>

      <el-tab-pane label="背包" name="bag">
        <el-table :data="detail.others" size="small" stripe max-height="320">
          <el-table-column prop="name" label="名称" />
          <el-table-column prop="Type" label="类型" width="70" />
          <el-table-column prop="ID" label="物品 ID" width="100" />
          <el-table-column prop="Count" label="数量" width="80" />
          <el-table-column label="操作" width="80">
            <template #default="{ row }"><el-button link type="danger" @click="doBagRemove(row)">全部扣除</el-button></template>
          </el-table-column>
        </el-table>
        <div class="hint" style="margin: 12px 0 6px">碎片</div>
        <el-table :data="detail.fragments" size="small" stripe max-height="200">
          <el-table-column prop="name" label="名称" />
          <el-table-column prop="ID" label="碎片 ID" width="100" />
          <el-table-column prop="Count" label="数量" width="80" />
        </el-table>
      </el-tab-pane>
    </el-tabs>
  </el-drawer>
</template>

<style scoped>
.hint { color: #909399; font-size: 12px; margin-left: 8px; }
</style>
