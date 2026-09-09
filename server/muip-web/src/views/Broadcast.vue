<script setup>
import { onMounted, ref } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { api } from '../api'
import RewardEditor from '../components/RewardEditor.vue'

const content = ref('')
const attachments = ref([])
const resourceTypes = ref({})
const sending = ref(false)
onMounted(async () => (resourceTypes.value = (await api.status()).resourceTypes))

async function send() {
  if (!content.value.trim()) return ElMessage.warning('请填写邮件内容')
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
}
</script>

<template>
  <el-card shadow="never">
    <template #header>全服邮件</template>
    <el-form label-width="90px">
      <el-form-item label="邮件内容">
        <el-input v-model="content" type="textarea" :rows="5" maxlength="500" show-word-limit placeholder="发件人显示为系统邮件，支持换行" />
      </el-form-item>
      <el-form-item label="附件">
        <RewardEditor v-model="attachments" :resource-types="resourceTypes" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" :loading="sending" @click="send">发送给全服玩家</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</template>
