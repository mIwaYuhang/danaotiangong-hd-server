<script setup>
import { onMounted, ref } from 'vue'
import { ElMessage } from 'element-plus'
import { api } from '../api'

const html = ref('')
const saving = ref(false)
const preview = ref(false)
onMounted(async () => (html.value = (await api.announcement()).html))

async function save() {
  saving.value = true
  try {
    await api.saveAnnouncement(html.value)
    ElMessage.success('公告已保存，客户端下次打开即生效')
  } finally {
    saving.value = false
  }
}
</script>

<template>
  <el-card shadow="never">
    <template #header>
      服务器公告（客户端以内嵌网页方式展示，内容为 HTML）
      <span style="float: right">
        <el-switch v-model="preview" active-text="预览" style="margin-right: 12px" />
        <el-button type="primary" :loading="saving" @click="save">保存</el-button>
      </span>
    </template>
    <el-row :gutter="16">
      <el-col :span="preview ? 12 : 24">
        <el-input v-model="html" type="textarea" :rows="24" spellcheck="false" style="font-family: Consolas, monospace" />
      </el-col>
      <el-col v-if="preview" :span="12">
        <iframe :srcdoc="html" style="width: 100%; height: 520px; border: 1px solid #dcdfe6; background: #fff" />
      </el-col>
    </el-row>
  </el-card>
</template>
