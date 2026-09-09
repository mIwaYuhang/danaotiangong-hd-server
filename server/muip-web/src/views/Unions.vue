<script setup>
import { onMounted, ref } from 'vue'
import { api, formatTime } from '../api'

const unions = ref([])
const loading = ref(false)
async function load() {
  loading.value = true
  try {
    unions.value = (await api.unions()).unions
  } finally {
    loading.value = false
  }
}
onMounted(load)
</script>

<template>
  <el-card shadow="never">
    <template #header>仙盟列表 <el-button link type="primary" style="float: right" @click="load">刷新</el-button></template>
    <el-table :data="unions" v-loading="loading" stripe>
      <el-table-column prop="id" label="ID" width="70" />
      <el-table-column prop="name" label="名称" width="160" />
      <el-table-column prop="level" label="等级" width="80" />
      <el-table-column prop="leader" label="盟主" width="140" />
      <el-table-column prop="members" label="成员数" width="90" />
      <el-table-column prop="coin" label="仙盟贡献" width="110" />
      <el-table-column prop="notice" label="公告" show-overflow-tooltip />
      <el-table-column label="创建时间" width="180" :formatter="(r) => formatTime(r.created)" />
    </el-table>
  </el-card>
</template>
