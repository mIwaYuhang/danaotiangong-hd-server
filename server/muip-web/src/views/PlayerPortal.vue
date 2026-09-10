<script setup>
// 玩家自助门户（/player）：用游戏账号登录，在配额内给自己发物品（走系统邮件）。
import { onMounted, onUnmounted, ref } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { portalApi, getPortalToken, setPortalToken, formatTime } from '../api'
import RewardEditor from '../components/RewardEditor.vue'

const loggedIn = ref(false)
const loggingIn = ref(false)
const mode = ref('device')
const form = ref({ udid: '', email: '', password: '' })
const me = ref(null)
const resourceTypes = ref({})
const rewards = ref([])
const sending = ref(false)

async function refresh() {
  const res = await portalApi.me()
  me.value = res
  resourceTypes.value = res.resourceTypes || {}
}

async function login() {
  const payload = mode.value === 'device' ? { udid: form.value.udid } : { email: form.value.email, password: form.value.password }
  loggingIn.value = true
  try {
    const res = await portalApi.login(payload)
    setPortalToken(res.token)
    loggedIn.value = true
    await refresh()
  } catch {
    /* 错误提示由拦截器统一弹出 */
  } finally {
    loggingIn.value = false
  }
}

function logout() {
  setPortalToken('')
  loggedIn.value = false
  me.value = null
  rewards.value = []
}

async function send() {
  if (!rewards.value.length) return ElMessage.warning('请先添加要发送的物品')
  try {
    await ElMessageBox.confirm(`将通过游戏邮件发送 ${rewards.value.length} 种物品到「${me.value.player.name}」，确认？`, '确认发送')
  } catch {
    return
  }
  sending.value = true
  try {
    const res = await portalApi.send(rewards.value)
    me.value = { ...me.value, player: res.player, quota: res.quota }
    rewards.value = []
    ElMessage.success(`已发送！请进游戏在邮件里领取（今日剩余 ${res.quota.remaining} 次）`)
  } catch {
    /* 错误提示由拦截器统一弹出 */
  } finally {
    sending.value = false
  }
}

onMounted(async () => {
  window.addEventListener('portal:logout', logout)
  if (getPortalToken()) {
    try {
      await refresh()
      loggedIn.value = true
    } catch {
      logout()
    }
  }
})
onUnmounted(() => window.removeEventListener('portal:logout', logout))
</script>

<template>
  <div class="portal-page">
    <el-card v-if="!loggedIn" class="portal-card" shadow="always">
      <template #header><div class="portal-title">大闹天宫HD · 玩家自助补给</div></template>
      <el-tabs v-model="mode">
        <el-tab-pane label="游客（设备号）" name="device">
          <el-form @submit.prevent="login">
            <el-form-item label="设备号">
              <el-input v-model="form.udid" placeholder="游戏登录用的设备号 udid" @keyup.enter="login" />
            </el-form-item>
          </el-form>
          <div class="hint">游客账号：填写进游戏时使用的设备号即可登录。</div>
        </el-tab-pane>
        <el-tab-pane label="邮箱账号" name="email">
          <el-form label-width="60px" @submit.prevent="login">
            <el-form-item label="邮箱"><el-input v-model="form.email" /></el-form-item>
            <el-form-item label="密码">
              <el-input v-model="form.password" type="password" show-password @keyup.enter="login" />
            </el-form-item>
          </el-form>
        </el-tab-pane>
      </el-tabs>
      <el-button type="primary" :loading="loggingIn" style="width: 100%" @click="login">登录</el-button>
      <div class="hint" style="text-align: center"><a href="/">GM 后台入口</a></div>
    </el-card>

    <el-card v-else class="portal-main" shadow="always">
      <template #header>
        <div class="portal-header">
          <span class="portal-title">{{ me.player.name }} 的自助补给</span>
          <el-button link type="danger" @click="logout">退出登录</el-button>
        </div>
      </template>
      <el-descriptions :column="3" border size="small" style="margin-bottom: 14px">
        <el-descriptions-item label="角色 ID">{{ me.player.userId }}</el-descriptions-item>
        <el-descriptions-item label="等级">{{ me.player.level }}</el-descriptions-item>
        <el-descriptions-item label="VIP">{{ me.player.vip }}</el-descriptions-item>
        <el-descriptions-item label="银币">{{ me.player.gold }}</el-descriptions-item>
        <el-descriptions-item label="元宝">{{ me.player.ingot }}</el-descriptions-item>
        <el-descriptions-item label="战力">{{ me.player.battlePower }}</el-descriptions-item>
        <el-descriptions-item label="上次在线" :span="3">{{ formatTime(me.player.lastSeenAt) }}</el-descriptions-item>
      </el-descriptions>

      <el-alert type="info" :closable="false" style="margin-bottom: 14px"
        :title="`今日还可自助发送 ${me.quota.remaining}/${me.quota.daily} 封（单封最多 ${me.quota.maxLines} 种、每种不超过 ${me.quota.maxCount} 个），物品通过游戏内邮件送达`" />

      <RewardEditor v-model="rewards" :resource-types="resourceTypes" :items-api="portalApi.items" />

      <el-button type="primary" :loading="sending" :disabled="me.quota.remaining <= 0 || !rewards.length"
        style="margin-top: 14px; width: 100%" @click="send">
        发送到我的游戏邮箱
      </el-button>
    </el-card>
  </div>
</template>

<style scoped>
.portal-page { min-height: 100%; display: flex; align-items: flex-start; justify-content: center; padding: 40px 16px; box-sizing: border-box; }
.portal-card { width: 420px; }
.portal-main { width: 720px; max-width: 100%; }
.portal-title { font-size: 17px; font-weight: 600; }
.portal-header { display: flex; align-items: center; justify-content: space-between; }
.hint { color: #909399; font-size: 12px; margin-top: 8px; }
</style>
