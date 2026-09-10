<script setup>
import { onMounted, ref, watch } from 'vue'
import { api } from '../api'

const type = ref(7)
const query = ref('')
const items = ref([])
const loading = ref(false)
const types = [
  { value: 7, label: '英雄' },
  { value: 5, label: '道具' },
  { value: 6, label: '材料' },
  { value: 4, label: '将魂' },
  { value: 10, label: '法宝' },
  { value: 1, label: '资源' },
]

async function search() {
  loading.value = true
  try {
    items.value = (await api.items(type.value, query.value)).items
  } finally {
    loading.value = false
  }
}
watch(type, () => { query.value = ''; search() })
onMounted(search)
</script>

<template>
  <el-card shadow="never">
    <template #header>
      <el-space>
        <span>静态表检索</span>
        <el-select v-model="type" style="width: 140px">
          <el-option v-for="t in types" :key="t.value" :label="t.label" :value="t.value" />
        </el-select>
        <el-input v-model="query" placeholder="名称或 ID（留空列出前 100 条）" clearable style="width: 280px" @keyup.enter="search" @clear="search" />
        <el-button type="primary" :loading="loading" @click="search">检索</el-button>
      </el-space>
    </template>
    <el-table :data="items" v-loading="loading" stripe max-height="640">
      <el-table-column prop="id" label="ID" width="120" />
      <el-table-column prop="name" label="名称" />
      <el-table-column prop="quality" label="品质" width="90" />
    </el-table>
  </el-card>
</template>
