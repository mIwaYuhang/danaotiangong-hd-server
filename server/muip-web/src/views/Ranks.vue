<script setup>
import { onMounted, ref } from 'vue'
import { api } from '../api'

const ranks = ref([])
const loading = ref(false)
async function load() {
  loading.value = true
  try {
    ranks.value = (await api.ranks(50)).ranks
  } finally {
    loading.value = false
  }
}
onMounted(load)
</script>

<template>
  <el-card shadow="never">
    <template #header>
      争霸排名（前 50）
      <el-button link type="primary" style="float: right" @click="load">刷新</el-button>
    </template>
    <el-table :data="ranks" v-loading="loading" stripe>
      <el-table-column prop="rank" label="名次" width="80" />
      <el-table-column prop="name" label="名称" width="180" />
      <el-table-column prop="userId" label="玩家 ID" width="140" />
      <el-table-column prop="level" label="等级" width="80" />
      <el-table-column prop="battlePower" label="战力" width="120" />
      <el-table-column label="类型" width="90">
        <template #default="{ row }"><el-tag :type="row.robot ? 'info' : 'success'" size="small">{{ row.robot ? '机器人' : '玩家' }}</el-tag></template>
      </el-table-column>
    </el-table>
  </el-card>
</template>
