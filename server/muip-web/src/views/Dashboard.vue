<script setup>
import { onMounted, ref } from 'vue'
import { api } from '../api'

const status = ref(null)
const load = async () => (status.value = await api.status())
onMounted(load)
const fmtUptime = (s) => `${Math.floor(s / 3600)} 小时 ${Math.floor((s % 3600) / 60)} 分`
</script>

<template>
  <div v-if="status">
    <el-row :gutter="16">
      <el-col :span="6" v-for="card in [
        { title: '角色总数', value: status.players },
        { title: '账号总数', value: status.accounts },
        { title: '24 小时活跃', value: status.active24h },
        { title: '仙盟数量', value: status.unions },
      ]" :key="card.title">
        <el-card shadow="hover"><el-statistic :title="card.title" :value="card.value" /></el-card>
      </el-col>
    </el-row>
    <el-card style="margin-top: 16px" shadow="never">
      <template #header>服务器信息 <el-button link type="primary" style="float: right" @click="load">刷新</el-button></template>
      <el-descriptions :column="2" border>
        <el-descriptions-item label="区服">{{ status.realm.name }}（ID {{ status.realm.id }}）</el-descriptions-item>
        <el-descriptions-item label="游戏服地址">{{ status.gameUrl }}</el-descriptions-item>
        <el-descriptions-item label="存档文件">{{ status.database }}</el-descriptions-item>
        <el-descriptions-item label="GM 服务运行时长">{{ fmtUptime(status.uptime) }}</el-descriptions-item>
      </el-descriptions>
    </el-card>
  </div>
  <el-skeleton v-else :rows="6" animated />
</template>
