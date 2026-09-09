"""Lua 数据表导入工具：不执行 Lua，只解析字面量。

用法（在 server 目录下）::

    python -m game_server.tools.lua_import ../lua-recovered/data data/static

只接受：字面量表、数字 / 字符串 / 布尔 / nil、已解析的枚举引用（如 ``ItemType.eHero``）、
以及无副作用的 ``string.lf(...)`` / ``ccp(x, y)`` 构造。任何其它表达式都以 ``ValueError``
报出源文件与位置，绝不猜测取值。``task.lua`` 中依赖设备适配的 UI 布局表会被逐个跳过并记录在清单的 ``unsupported`` 中。

输出：每个源文件一个 JSON（键为表名），最后写入 ``manifest.json``；随后用 ``Catalog`` 回读校验。
"""
import argparse
import hashlib
import json
from pathlib import Path
import re

from ..catalog import Catalog, MANIFEST_VERSION, NPC_SHARDS, SOURCE_NAMES

TOKEN = re.compile(r'\s+|--[^\n]*|"(?:\\.|[^"\\])*"|\d+(?:\.\d+)?|[A-Za-z_]\w*|[{}\[\]=,;.()\-]')
#: 允许的 ``require`` 依赖：只能引用同为数据表的模块。
APPROVED_REQUIRES = ('data.hero', 'data.taskType')
#: 允许的无副作用构造函数。
INERT_CONSTRUCTORS = ('string.lf', 'ccp')


class LuaLiteralParser:
    """受限的 Lua 字面量解析器，把 ``名字 = 表达式`` 依次写入 ``env``。"""

    def __init__(self, text, env, source):
        self.tokens = []
        self.env, self.source, self.index = env, source, 0
        pos = 0
        for match in TOKEN.finditer(text):
            if text[pos:match.start()].strip():
                raise ValueError(f'{source}:{pos}: 不支持的语法 {text[pos:match.start()]!r}')
            pos = match.end()
            if not match[0].isspace() and not match[0].startswith('--'):
                self.tokens.append(match[0])
        if text[pos:].strip():
            raise ValueError(f'{source}:{pos}: 末尾存在不支持的语法')

    def peek(self):
        return self.tokens[self.index] if self.index < len(self.tokens) else '<EOF>'

    def pop(self, expected=None):
        value = self.peek()
        if expected is not None and value != expected:
            raise ValueError(f'{self.source}: 第 {self.index} 个记号应为 {expected}，实际为 {value}')
        self.index += 1
        return value

    def value(self):
        token = self.pop()
        if token == '-':
            return -self.value()
        if token == '(':
            inner = self.value()
            self.pop(')')
            return inner
        if token == '{':
            return self.table()
        if token.startswith('"'):
            return json.loads(token)
        if token[0:1].isdigit():
            return float(token) if '.' in token else int(token)
        if token in ('true', 'false', 'nil'):
            return {'true': True, 'false': False, 'nil': None}[token]
        return self.reference(token)

    def table(self):
        result, next_index = {}, 1
        while self.peek() != '}':
            if self.peek() == '[':
                self.pop()
                key = self.value()
                self.pop(']')
                self.pop('=')
            elif self.index + 1 < len(self.tokens) and self.tokens[self.index + 1] == '=':
                key = self.pop()
                self.pop('=')
            else:
                key, next_index = next_index, next_index + 1
            if key in result:
                raise ValueError(f'{self.source}: 表中键 {key} 重复')
            result[key] = self.value()
            if self.peek() not in (',', ';'):
                break
            self.pop()
        self.pop('}')
        return result

    def reference(self, name):
        while self.peek() == '.':
            self.pop()
            name += '.' + self.pop()
        if self.peek() == '(' and name in INERT_CONSTRUCTORS:
            self.pop()
            args = [self.value()]
            while self.peek() == ',':
                self.pop()
                args.append(self.value())
            self.pop(')')
            if name == 'string.lf' and len(args) == 1 and isinstance(args[0], str):
                return args[0]
            if name == 'ccp' and len(args) == 2 and all(type(x) in (int, float) for x in args):
                return args
            raise ValueError(f'{self.source}: 构造函数 {name} 的参数不合法')
        try:
            value = self.env[name.split('.')[0]]
            for part in name.split('.')[1:]:
                value = value[part]
            return value
        except KeyError as exc:
            raise ValueError(f'{self.source}: 无法解析的表达式 {name}') from exc

    def parse(self):
        while self.peek() != '<EOF>':
            name = self.pop()
            if name == 'require':
                self.pop('(')
                dependency = self.value()
                self.pop(')')
                if dependency not in APPROVED_REQUIRES:
                    raise ValueError(f'{self.source}: 未批准的依赖 {dependency}')
                continue
            self.pop('=')
            self.env[name] = self.value()
        return self.env


def import_tables(source_dir: Path) -> dict:
    """解析全部源文件，返回表、来源摘要、表索引、条目数与被跳过的声明。"""
    env, sources, unsupported, index = {}, {}, [], {}
    for name in SOURCE_NAMES:
        before = set(env)
        raw = (source_dir / f'{name}.lua').read_bytes()
        sources[name] = hashlib.sha256(raw).hexdigest()
        text = raw.decode('utf-8-sig')
        if name == 'task':
            # 逐个顶层声明解析：UI 布局表依赖设备适配调用，记录后跳过而不是编造坐标。
            for block in re.split(r'(?=^[A-Za-z_]\w*\s*=)', text, flags=re.M):
                try:
                    LuaLiteralParser(block, env, f'{name}.lua').parse()
                except ValueError as exc:
                    unsupported.append({'table': block.split('=')[0].strip(), 'error': str(exc)})
        else:
            LuaLiteralParser(text, env, f'{name}.lua').parse()
        for table in set(env) - before:
            index[table] = f'{name}.json'
    seen = set()
    for shard in NPC_SHARDS:
        overlap = seen.intersection(env[shard])
        if overlap:
            raise ValueError(f'NPC {next(iter(overlap))} 在多个分片中重复')
        seen.update(env[shard])
    counts = {k: len(v) for k, v in env.items() if isinstance(v, dict)}
    counts['BaseNPCs'] = len(seen)
    return {'version': MANIFEST_VERSION, 'unsupported': unsupported, 'sources': sources,
            'tables': env, 'counts': counts, 'index': index}


def encode(value) -> bytes:
    """确定性 JSON：先经一次 JSON 往返把 Lua 的数字键统一为字符串，再排序输出。"""
    normalized = json.loads(json.dumps(value, ensure_ascii=False))
    return (json.dumps(normalized, ensure_ascii=False, sort_keys=True, separators=(',', ':')) + '\n').encode('utf-8')


def generate(source_dir: Path, output_dir: Path) -> dict:
    """生成静态表目录，最后写清单，然后用 ``Catalog`` 回读校验。"""
    result = import_tables(Path(source_dir))
    output_dir = Path(output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)
    files = {}
    for name in SOURCE_NAMES:
        filename = f'{name}.json'
        tables = {k: result['tables'][k] for k, v in result['index'].items() if v == filename}
        raw = encode(tables)
        path = output_dir / filename
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_bytes(raw)
        files[filename] = {'sha256': hashlib.sha256(raw).hexdigest(), 'bytes': len(raw)}
    manifest = {k: result[k] for k in ('version', 'sources', 'unsupported', 'counts')}
    manifest['tables'] = dict(result['index'], BaseNPCs={'shards': NPC_SHARDS})
    manifest['files'] = files
    (output_dir / 'manifest.json').write_bytes(encode(manifest))

    loaded = Catalog(output_dir)
    for table, value in result['tables'].items():
        if loaded[table] != json.loads(json.dumps(value)):
            raise ValueError(f'生成的表与解析结果不一致: {table}')
    if len(dict(loaded['BaseNPCs'])) != result['counts']['BaseNPCs']:
        raise ValueError('生成的 NPC 条目数不一致')
    return manifest


def main(argv=None):
    parser = argparse.ArgumentParser(description='把受限的 Lua 字面量数据表导出为静态 JSON 目录')
    parser.add_argument('source', type=Path, help='客户端 data 目录（含 hero.lua、item.lua、npcs/ 等）')
    parser.add_argument('output', type=Path, help='输出目录，通常为 server/data/static')
    args = parser.parse_args(argv)
    manifest = generate(args.source, args.output)
    print(json.dumps({'counts': manifest['counts'], 'unsupported': manifest['unsupported'],
                      'files': manifest['files']}, ensure_ascii=False, sort_keys=True, indent=2))


if __name__ == '__main__':
    main()
