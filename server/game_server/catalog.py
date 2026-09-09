"""静态表：由客户端 Lua 数据表导出的只读 JSON。

目录布局（``data/static/``）::

    manifest.json     清单：版本、来源 Lua 的 SHA-256、各表所在文件、条目数、文件校验值
    hero.json ...     每个源文件对应一个 JSON，内容为 {表名: 表内容}
    npcs/npc1.json    NPC 表分为 15 个分片，运行时通过 NPCView 合并为一张 BaseNPCs 表

``Catalog`` 按文件懒加载，加载时校验字节数与 SHA-256、表名集合与条目数量；
任何不一致都抛出 ``StaticDataError``，不会退化为空表。

用法::

    catalog = Catalog(static_dir)
    catalog['BaseHeros']['101']   # 表内键统一为字符串（JSON 键）
    catalog['BaseNPCs']           # 合并后的 NPC 视图
"""
from collections.abc import Mapping
import hashlib
import json
from pathlib import Path
import re

from .errors import StaticDataError

#: 源文件名（不含扩展名），与 ``tools/lua_import.py`` 共用。
SOURCE_NAMES = ['taskType', 'hero', 'equip', 'item', 'map', 'task', 'fuben', 'ShenQi'] + [f'npcs/npc{i}' for i in range(1, 16)]
#: NPC 分片表名。
NPC_SHARDS = [f'BaseNPCs{i}' for i in range(1, 16)]
MANIFEST_VERSION = 1
SHA256_PATTERN = re.compile(r'[0-9a-f]{64}')


def _read_json(path: Path):
    try:
        return json.loads(path.read_bytes())
    except (OSError, ValueError) as exc:
        raise StaticDataError(f'静态表 {path} 读取失败: {exc}') from exc


class NPCView(Mapping):
    """把 15 个 NPC 分片合并为一张虚拟表；只有分片本身会被缓存。"""

    def __init__(self, catalog):
        self._catalog = catalog

    def __getitem__(self, key):
        for shard in NPC_SHARDS:
            table = self._catalog[shard]
            if key in table:
                return table[key]
        raise KeyError(key)

    def __iter__(self):
        seen = set()
        for shard in NPC_SHARDS:
            for key in self._catalog[shard]:
                if key in seen:
                    raise StaticDataError(f'NPC {key} 在多个分片中重复')
                seen.add(key)
                yield key
        if len(seen) != len(self):
            raise StaticDataError('BaseNPCs 条目数与清单不一致')

    def __len__(self):
        return self._catalog.manifest['counts']['BaseNPCs']


class Catalog(Mapping):
    """带完整性校验的静态表懒加载映射。"""

    def __init__(self, directory):
        self.directory = Path(directory)
        manifest_path = self.directory / 'manifest.json'
        self.manifest = _read_json(manifest_path)
        self._files = {}
        try:
            self._validate_manifest()
        except (AssertionError, KeyError, TypeError, AttributeError) as exc:
            raise StaticDataError(f'静态表清单无效: {manifest_path}') from exc
        self._npcs = NPCView(self)

    def _validate_manifest(self):
        m = self.manifest
        assert m['version'] == MANIFEST_VERSION
        assert isinstance(m['unsupported'], list)
        assert set(m['sources']) == set(SOURCE_NAMES)
        assert set(m['files']) == {f'{name}.json' for name in SOURCE_NAMES}
        assert set(m['counts']) == set(m['tables'])
        assert m['tables']['BaseNPCs'] == {'shards': NPC_SHARDS}
        for name, count in m['counts'].items():
            assert type(count) is int and count >= 0
            if name != 'BaseNPCs':
                assert m['tables'][name] in m['files']
        assert all(m['tables'][shard] == f'npcs/npc{i}.json' for i, shard in enumerate(NPC_SHARDS, 1))
        assert m['counts']['BaseNPCs'] == sum(m['counts'][shard] for shard in NPC_SHARDS)
        for digest in m['sources'].values():
            assert SHA256_PATTERN.fullmatch(digest)
        for filename, info in m['files'].items():
            assert SHA256_PATTERN.fullmatch(info['sha256'])
            assert type(info['bytes']) is int and info['bytes'] > 0
            if not (self.directory / filename).is_file():
                raise StaticDataError(f'静态表文件缺失: {self.directory / filename}')

    def __iter__(self):
        return iter(self.manifest['tables'])

    def __len__(self):
        return len(self.manifest['tables'])

    def __getitem__(self, name):
        filename = self.manifest['tables'][name]
        if name == 'BaseNPCs':
            return self._npcs
        if filename not in self._files:
            self._files[filename] = self._load_file(filename)
        return self._files[filename][name]

    def _load_file(self, filename):
        path = self.directory / filename
        try:
            raw = path.read_bytes()
            info = self.manifest['files'][filename]
            if len(raw) != info['bytes'] or hashlib.sha256(raw).hexdigest() != info['sha256']:
                raise ValueError('文件大小或 SHA-256 与清单不一致')
            tables = json.loads(raw)
            expected = {k for k, v in self.manifest['tables'].items() if v == filename}
            if not isinstance(tables, dict) or set(tables) != expected:
                raise ValueError('文件内表名与清单索引不一致')
            for key, value in tables.items():
                if not isinstance(value, dict) or len(value) != self.manifest['counts'][key]:
                    raise ValueError(f'表 {key} 的类型或条目数与清单不一致')
        except (OSError, ValueError) as exc:
            raise StaticDataError(f'静态表 {path} 无效: {exc}') from exc
        return tables

    # ---- 常用派生查询 -------------------------------------------------

    def starter_hero_ids(self):
        """可选的初始英雄 ID 集合（来自 InitHerosConfig）。"""
        return {entry['heroId'] for entry in self['InitHerosConfig'].values()}

    def first_stage_id(self):
        """静态表中编号最小的关卡。"""
        return min(map(int, self['BaseStages']))

    def next_stage_id(self, stage_id):
        """紧随 ``stage_id`` 的下一关；没有则返回自身。"""
        return min((int(k) for k in self['BaseStages'] if int(k) > stage_id), default=stage_id)
