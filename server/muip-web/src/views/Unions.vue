<script setup>
import { onMounted, reactive, ref } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { api, formatTime } from '../api'

const unions = ref([])
const loading = ref(false)
const drawer = ref(false)
const detail = ref(null)
const form = reactive({ notice: '', outNotice: '', coin: 0 })
const busy = ref(false)

const positions = { 1: '盟主', 2: '长老', 3: '长老', 4: '青龙', 5: '白虎', 6: '朱雀', 7: '玄武', 8: '成员' }

async function load() {
  loading.value = true
  try {
    unions.value = (await api.unions()).unions
  } finally {
    loading.value = false
  }
}
onMounted(load)

async function open(row) {
  detail.value = await api.union(row.id)
  form.notice = detail.value.notice
  form.outNotice = detail.value.outNotice
  form.coin = detail.value.coin
  drawer.value = true
}
async function save() {
  busy.value = true
  try {
    await api.updateUnion(detail.value.id, { notice: form.notice, outNotice: form.outNotice, coin: form.coin })
    ElMessage.success('已保存')
    detail.value = await api.union(detail.value.id)
    await load()
  } finally {
    busy.value = false
  }
}
async function kick(userId) {
  await ElMessageBox.confirm('将该成员移出仙盟？', '踢出成员', { type: 'warning' })
  await api.kickUnionMember(detail.value.id, userId)
  ElMessage.success('已踢出')
  try {
    detail.value = await api.union(detail.value.id)
  } catch {
    drawer.value = false
  }
  await load()
}
async function dissolve() {
  await ElMessageBox.confirm('将解散该仙盟并清空全部成员，确定？', '解散仙盟', { type: 'warning' })
  await api.dissolveUnion(detail.value.id)
  ElMessage.success('已解散')
  drawer.value = false
  await load()
}
</script>

<template>
  <el-card shadow="never">
    <template #header>仙盟列表 <el-button link type="primary" style="float: right" @click="load">刷新</el-button></template>
    <el-table :data="unions" v-loading="loading" stripe highlight-current-row style="cursor: pointer" @row-click="open">
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

  <el-drawer v-model="drawer" size="640px" :title="detail ? `${detail.name}（ID ${detail.id}）` : ''" destroy-on-close>
    <div v-if="detail">
      <el-form label-width="90px" size="small">
        <el-form-item label="对内公告"><el-input v-model="form.notice" type="textarea" :rows="2" /></el-form-item>
        <el-form-item label="对外公告"><el-input v-model="form.outNotice" type="textarea" :rows="2" /></el-form-item>
        <el-form-item label="仙盟贡献"><el-input-number v-model="form.coin" :min="0" :max="2000000000" /></el-form-item>
        <el-form-item>
          <el-button type="primary" :loading="busy" @click="save">保存</el-button>
          <el-button type="danger" plain @click="dissolve">解散仙盟</el-button>
        </el-form-item>
      </el-form>
      <el-table :data="detail.members" size="small" stripe>
        <el-table-column prop="userId" label="ID" width="80" />
        <el-table-column prop="name" label="昵称" width="120" />
        <el-table-column prop="level" label="等级" width="70" />
        <el-table-column prop="battlePower" label="战力" width="90" />
        <el-table-column label="职位" width="90" :formatter="(r) => positions[r.position] || r.position" />
        <el-table-column label="操作" width="80">
          <template #default="{ row }"><el-button link type="danger" @click="kick(row.userId)">踢出</el-button></template>
        </el-table-column>
      </el-table>
    </div>
  </el-drawer>
</template>
