<script setup>
// 奖励 / 附件编辑器：选择物品类型 → 检索静态表 → 数量，产出 [{Type, ID, Count}]。
import { ref, watch } from 'vue'
import { api } from '../api'

const props = defineProps({
  modelValue: { type: Array, default: () => [] },
  resourceTypes: { type: Object, default: () => ({}) },
  // 可替换的检索接口（玩家门户传 portalApi.items），默认走 GM 接口
  itemsApi: { type: Function, default: null },
})
const emit = defineEmits(['update:modelValue'])

const catalogTypes = { 4: '将魂', 5: '道具', 6: '材料', 7: '英雄', 10: '装备' }
const typeOptions = [
  ...Object.entries(props.resourceTypes).map(([v, l]) => ({ value: Number(v), label: `${l} (${v})` })),
  ...Object.entries(catalogTypes).map(([v, l]) => ({ value: Number(v), label: `${l} (${v})` })),
]

const type = ref(1)
const item = ref(null)
const count = ref(1)
const items = ref([])
const loading = ref(false)
const names = ref({})

async function search(q) {
  loading.value = true
  try {
    const res = await (props.itemsApi || api.items)(type.value, q)
    items.value = res.items
    for (const it of res.items) names.value[`${type.value}:${it.id}`] = it.name
  } finally {
    loading.value = false
  }
}
watch(type, () => { item.value = null; search('') }, { immediate: true })

function add() {
  const id = props.resourceTypes[type.value] ? 0 : item.value
  if (id === null || id === undefined) return
  if (!(count.value > 0)) return
  emit('update:modelValue', [...props.modelValue, { Type: type.value, ID: id, Count: Math.floor(count.value) }])
}
function remove(index) {
  emit('update:modelValue', props.modelValue.filter((_, i) => i !== index))
}
const label = (r) => `${typeOptions.find((t) => t.value === r.Type)?.label || r.Type} · ${names.value[`${r.Type}:${r.ID}`] || (r.ID || '-')}`
</script>

<template>
  <div>
    <el-space wrap>
      <el-select v-model="type" style="width: 170px">
        <el-option v-for="t in typeOptions" :key="t.value" :label="t.label" :value="t.value" />
      </el-select>
      <el-select v-if="!resourceTypes[type]" v-model="item" filterable remote :remote-method="search" :loading="loading" placeholder="搜索名称或 ID" style="width: 260px">
        <el-option v-for="it in items" :key="it.id" :label="`${it.name} (#${it.id})`" :value="it.id" />
      </el-select>
      <el-input-number v-model="count" :min="1" :max="99999999" controls-position="right" style="width: 150px" />
      <el-button type="primary" plain @click="add">添加</el-button>
    </el-space>
    <el-table v-if="modelValue.length" :data="modelValue" size="small" style="margin-top: 10px">
      <el-table-column label="物品" :formatter="(r) => label(r)" />
      <el-table-column prop="ID" label="ID" width="90" />
      <el-table-column prop="Count" label="数量" width="110" />
      <el-table-column width="80">
        <template #default="{ $index }"><el-button link type="danger" @click="remove($index)">移除</el-button></template>
      </el-table-column>
    </el-table>
  </div>
</template>
