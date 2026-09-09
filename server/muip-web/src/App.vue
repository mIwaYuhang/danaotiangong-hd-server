<script setup>
import { onMounted, ref } from 'vue'
import { ElMessage } from 'element-plus'
import { api, getToken, setToken } from './api'
import Dashboard from './views/Dashboard.vue'
import Players from './views/Players.vue'
import Broadcast from './views/Broadcast.vue'
import Announcement from './views/Announcement.vue'
import Unions from './views/Unions.vue'

const views = { dashboard: Dashboard, players: Players, broadcast: Broadcast, announcement: Announcement, unions: Unions }
const menu = [
  { key: 'dashboard', label: '概览', icon: 'DataBoard' },
  { key: 'players', label: '玩家管理', icon: 'User' },
  { key: 'broadcast', label: '全服邮件', icon: 'Message' },
  { key: 'announcement', label: '服务器公告', icon: 'Document' },
  { key: 'unions', label: '仙盟', icon: 'OfficeBuilding' },
]

const loggedIn = ref(false)
const active = ref('dashboard')
const tokenInput = ref('')
const loggingIn = ref(false)
const status = ref(null)

async function login() {
  if (!tokenInput.value) return
  loggingIn.value = true
  try {
    await api.login(tokenInput.value)
    setToken(tokenInput.value)
    loggedIn.value = true
    status.value = await api.status()
  } catch (e) {
    ElMessage.error(e.response?.data?.error || '登录失败')
  } finally {
    loggingIn.value = false
  }
}

function logout() {
  setToken('')
  loggedIn.value = false
  status.value = null
}

onMounted(async () => {
  window.addEventListener('muip:logout', logout)
  if (getToken()) {
    try {
      status.value = await api.status()
      loggedIn.value = true
    } catch {
      logout()
    }
  }
})
</script>

<template>
  <div v-if="!loggedIn" class="login-page">
    <el-card class="login-card" shadow="always">
      <template #header><div class="login-title">大闹天宫HD · GM 后台</div></template>
      <el-form @submit.prevent="login">
        <el-form-item label="访问令牌">
          <el-input v-model="tokenInput" type="password" show-password placeholder="data/config/muip.json 中的 token" @keyup.enter="login" />
        </el-form-item>
        <el-button type="primary" :loading="loggingIn" style="width: 100%" @click="login">登录</el-button>
      </el-form>
    </el-card>
  </div>

  <el-container v-else class="layout">
    <el-aside width="200px" class="aside">
      <div class="brand">GM 后台</div>
      <el-menu :default-active="active" background-color="#1f2d3d" text-color="#c0c4cc" active-text-color="#ffd04b" @select="(k) => (active = k)">
        <el-menu-item v-for="item in menu" :key="item.key" :index="item.key">
          <el-icon><component :is="item.icon" /></el-icon>
          <span>{{ item.label }}</span>
        </el-menu-item>
      </el-menu>
    </el-aside>
    <el-container>
      <el-header class="header">
        <span>{{ status?.realm?.name || '' }}</span>
        <el-button link type="danger" @click="logout">退出登录</el-button>
      </el-header>
      <el-main class="main">
        <component :is="views[active]" />
      </el-main>
    </el-container>
  </el-container>
</template>

<style>
html, body, #app { height: 100%; margin: 0; background: #f5f7fa; font-family: 'Microsoft YaHei', 'PingFang SC', sans-serif; }
.login-page { height: 100%; display: flex; align-items: center; justify-content: center; }
.login-card { width: 380px; }
.login-title { font-size: 18px; font-weight: 600; text-align: center; }
.layout { height: 100%; }
.aside { background: #1f2d3d; }
.brand { color: #fff; font-weight: 600; padding: 18px 20px; font-size: 16px; }
.aside .el-menu { border-right: none; }
.header { display: flex; align-items: center; justify-content: space-between; background: #fff; border-bottom: 1px solid #e4e7ed; }
.main { overflow: auto; }
</style>
