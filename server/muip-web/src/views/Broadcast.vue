<script setup>
import { onMounted, ref } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { api } from '../api'
import RewardEditor from '../components/RewardEditor.vue'

const content = ref('')
const attachments = ref([])
const resourceTypes = ref({})
const sending = ref(false)
const mode = ref('all')
const userIdsText = ref('')
onMounted(async () => (resourceTypes.value = (await api.status()).resourceTypes))

function parseIds() {
  return userIdsText.value.split(/[\s,，;；]+/).map((s) => s.trim()).filter(Boolean).map((s) => Number(s)).filter((n) => Number.isInteger(n) && n > 0)
}

async function send() {
  if (!content.value.trim()) return ElMessage.warning('请填写邮件内容')
  if (mode.value === 'all') {
    await ElMessageBox.confirm(`确定向全服所有玩家发送邮件${attachments.value.length ? `（含 ${attachments.value.length} 项附件）` : ''}？`, '全服邮件', { type: 'warning' })
    sending.value = true
    try {
      const res = await api.broadcast(content.value, attachments.value)
      ElMessage.success(`已发送给 ${res.sent} 名玩家`)
      content.value = ''
      attachments.value = []
    } finally {
      sending.value = false
    }
    return
  }
  const ids = parseIds()
  if (!ids.length) return ElMessage.warning('请填写至少一个玩家 ID')
  await ElMessageBox.confirm(`向 ${ids.length} 名指定玩家发送邮件？`, '指定邮件', { type: 'warning' })
  sending.value = true
  try {
    const res = await api.mailMany(ids, content.value, attachments.value)
    ElMessage.success(`已发送 ${res.sent} 封${res.missing?.length ? `，未找到 ${res.missing.join(', ')}` : ''}`)
    content.value = ''
    attachments.value = []
  } finally {
    sending.value = false
  }
}
</script>

<template>
  <el-card shadow="never">
    <template #header>运营邮件</template>
    <el-form label-width="90px">
      <el-form-item label="发送范围">
        <el-radio-group v-model="mode">
          <el-radio-button value="all">全服</el-radio-button>
          <el-radio-button value="ids">指定玩家</el-radio-button>
        </el-radio-group>
      </el-form-item>
      <el-form-item v-if="mode === 'ids'" label="玩家 ID">
        <el-input v-model="userIdsText" type="textarea" :rows="3" placeholder="多个 ID 用逗号、空格或换行分隔" />
      </el-form-item>
      <el-form-item label="邮件内容">
        <el-input v-model="content" type="textarea" :rows="5" maxlength="500" show-word-limit placeholder="发件人显示为系统邮件，支持换行" />
      </el-form-item>
      <el-form-item label="附件">
        <RewardEditor v-model="attachments" :resource-types="resourceTypes" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" :loading="sending" @click="send">{{ mode === 'all' ? '发送给全服玩家' : '发送给指定玩家' }}</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</template>
