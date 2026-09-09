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
  tab.value = 'info'
  drawer.value = true
}
async function refresh() {
  detail.value = await api.player(detail.value.summary.userId)
  form.fields = { ...detail.value.resources }
  form.Banned = detail.value.banned
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

  <el-drawer v-model="drawer" size="720px" :title="detail ? `${detail.summary.name}（ID ${detail.summary.userId}）` : ''" destroy-on-close>
    <el-tabs v-if="detail" v-model="tab">
      <el-tab-pane label="基本信息" name="info">
        <el-descriptions :column="3" border size="small" style="margin-bottom: 14px">
          <el-descriptions-item label="战力">{{ detail.summary.battlePower }}</el-descriptions-item>
          <el-descriptions-item label="英雄数">{{ detail.heroes.length }}</el-descriptions-item>
          <el-descriptions-item label="法宝数">{{ detail.talismans }}</el-descriptions-item>
          <el-descriptions-item label="邮件数">{{ detail.mails }}</el-descriptions-item>
          <el-descriptions-item label="引导进度">{{ detail.tiroMaxStep }}</el-descriptions-item>
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
        <el-table :data="detail.heroes" size="small" stripe>
          <el-table-column prop="heroId" label="英雄 ID" width="100" />
          <el-table-column prop="level" label="等级" width="80" />
          <el-table-column prop="rebirthCount" label="进阶" width="80" />
          <el-table-column prop="battlePower" label="战力" width="100" />
          <el-table-column label="阵位" :formatter="(r) => (r.battleIx ? `${r.battleIx} 号位` : '未上阵')" />
        </el-table>
      </el-tab-pane>

      <el-tab-pane label="背包" name="bag">
        <el-table :data="detail.others" size="small" stripe max-height="420">
          <el-table-column prop="Type" label="类型" width="80" />
          <el-table-column prop="ID" label="物品 ID" width="110" />
          <el-table-column prop="Count" label="数量" width="100" />
        </el-table>
      </el-tab-pane>
    </el-tabs>
  </el-drawer>
</template>
