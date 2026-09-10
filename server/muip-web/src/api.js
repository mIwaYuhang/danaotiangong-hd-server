import axios from 'axios'
import { ElMessage } from 'element-plus'

const TOKEN_KEY = 'muip_token'
export const getToken = () => localStorage.getItem(TOKEN_KEY) || ''
export const setToken = (token) => (token ? localStorage.setItem(TOKEN_KEY, token) : localStorage.removeItem(TOKEN_KEY))

const http = axios.create({ baseURL: '/api', timeout: 30000 })
http.interceptors.request.use((cfg) => {
  const token = getToken()
  if (token) cfg.headers.Authorization = `Bearer ${token}`
  return cfg
})
http.interceptors.response.use(
  (res) => res.data,
  (err) => {
    const status = err.response?.status
    const message = err.response?.data?.error || err.message
    if (status === 401) {
      setToken('')
      window.dispatchEvent(new CustomEvent('muip:logout'))
    }
    ElMessage.error(message)
    return Promise.reject(err)
  },
)

export const api = {
  login: (token) => axios.post('/api/login', { token }).then((r) => r.data),
  status: () => http.get('/status'),
  players: (q) => http.get('/players', { params: { q } }),
  player: (id) => http.get(`/players/${id}`),
  updatePlayer: (id, fields) => http.post(`/players/${id}/update`, { fields }),
  grant: (id, rewards) => http.post(`/players/${id}/grant`, { rewards }),
  mail: (id, content, attachments) => http.post(`/players/${id}/mail`, { content, attachments }),
  resetDaily: (id) => http.post(`/players/${id}/reset-daily`),
  maxOut: (id) => http.post(`/players/${id}/max-out`, {}, { timeout: 120000 }),
  grantHero: (id, heroId) => http.post(`/players/${id}/hero`, { heroId }),
  updateHero: (id, body) => http.post(`/players/${id}/hero-update`, body),
  setProgress: (id, fields) => http.post(`/players/${id}/progress`, { fields }),
  skipGuide: (id) => http.post(`/players/${id}/skip-guide`),
  clearMails: (id) => http.post(`/players/${id}/clear-mails`),
  deleteMail: (id, mailId) => http.post(`/players/${id}/delete-mail`, { mailId }),
  bagRemove: (id, item) => http.post(`/players/${id}/bag-remove`, item),
  recharge: (id, ingot) => http.post(`/players/${id}/recharge`, { ingot }),
  monthCard: (id, days) => http.post(`/players/${id}/month-card`, { days }),
  growup: (id) => http.post(`/players/${id}/growup`),
  leaveUnion: (id) => http.post(`/players/${id}/leave-union`),
  broadcast: (content, attachments) => http.post('/mail/broadcast', { content, attachments }),
  mailMany: (userIds, content, attachments) => http.post('/mail/many', { userIds, content, attachments }),
  items: (type, q) => http.get('/items', { params: { type, q } }),
  ranks: (limit = 30) => http.get('/ranks', { params: { limit } }),
  unions: () => http.get('/unions'),
  union: (id) => http.get(`/unions/${id}`),
  updateUnion: (id, fields) => http.post(`/unions/${id}/update`, { fields }),
  kickUnionMember: (id, userId) => http.post(`/unions/${id}/kick`, { userId }),
  dissolveUnion: (id) => http.post(`/unions/${id}/dissolve`),
  announcement: () => http.get('/announcement'),
  saveAnnouncement: (html) => http.put('/announcement', { html }),
}

// ---- 玩家自助门户（/player）：独立令牌，与 GM 令牌互不相通 ----
const PORTAL_TOKEN_KEY = 'muip_portal_token'
export const getPortalToken = () => localStorage.getItem(PORTAL_TOKEN_KEY) || ''
export const setPortalToken = (token) => (token ? localStorage.setItem(PORTAL_TOKEN_KEY, token) : localStorage.removeItem(PORTAL_TOKEN_KEY))

const portalHttp = axios.create({ baseURL: '/api/portal', timeout: 30000 })
portalHttp.interceptors.request.use((cfg) => {
  const token = getPortalToken()
  if (token) cfg.headers.Authorization = `Bearer ${token}`
  return cfg
})
portalHttp.interceptors.response.use(
  (res) => res.data,
  (err) => {
    const status = err.response?.status
    const message = err.response?.data?.error || err.message
    if (status === 401) {
      setPortalToken('')
      window.dispatchEvent(new CustomEvent('portal:logout'))
    }
    ElMessage.error(message)
    return Promise.reject(err)
  },
)

export const portalApi = {
  login: (payload) => portalHttp.post('/login', payload),
  me: () => portalHttp.get('/me'),
  items: (type, q) => portalHttp.get('/items', { params: { type, q } }),
  send: (rewards) => portalHttp.post('/send', { rewards }),
  maxout: () => portalHttp.post('/maxout', {}, { timeout: 120000 }),
}

export const formatTime = (ts) => (ts ? new Date(ts * 1000).toLocaleString('zh-CN', { hour12: false }) : '-')
