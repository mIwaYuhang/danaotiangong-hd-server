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
  broadcast: (content, attachments) => http.post('/mail/broadcast', { content, attachments }),
  items: (type, q) => http.get('/items', { params: { type, q } }),
  unions: () => http.get('/unions'),
  announcement: () => http.get('/announcement'),
  saveAnnouncement: (html) => http.put('/announcement', { html }),
}

export const formatTime = (ts) => (ts ? new Date(ts * 1000).toLocaleString('zh-CN', { hour12: false }) : '-')
