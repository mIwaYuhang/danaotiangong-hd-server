import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'

// 开发时 `npm run dev` 把 /api 转发到本机的 GM 服务（python -m game_server.muip）。
export default defineConfig({
  plugins: [vue()],
  server: {
    port: 5173,
    proxy: { '/api': { target: 'http://127.0.0.1:8090', changeOrigin: true } },
  },
  build: { outDir: 'dist', emptyOutDir: true },
})
