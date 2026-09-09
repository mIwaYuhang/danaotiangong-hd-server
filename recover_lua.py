"""解密 MQKK 封装的 Lua 文件，原文件保持不变。"""
import argparse
import hashlib
import json
import struct
from pathlib import Path

MASK = 0xFFFFFFFF
DELTA = 0x9E3779B9


def decrypt(data, key):
    if len(data) < 8 or len(data) % 4:
        raise ValueError('XXTEA 密文长度无效')
    values = list(struct.unpack('<%dI' % (len(data) // 4), data))
    keys = struct.unpack('<4I', key[:16].ljust(16, b'\0'))
    n = len(values) - 1
    total = ((6 + 52 // (n + 1)) * DELTA) & MASK
    y = values[0]
    while total:
        e = (total >> 2) & 3
        for p in range(n, -1, -1):
            z = values[p - 1] if p else values[n]
            mx = (((z >> 5) ^ (y << 2)) + ((y >> 3) ^ (z << 4))) ^ ((total ^ y) + (keys[(p & 3) ^ e] ^ z))
            values[p] = (values[p] - mx) & MASK
            y = values[p]
        total = (total - DELTA) & MASK
    length = values[-1]
    capacity = n * 4
    if not capacity - 3 <= length <= capacity:
        raise ValueError('XXTEA 明文长度校验失败，请检查密钥或封装')
    return struct.pack('<%dI' % n, *values[:-1])[:length]


def encrypt(data, key):
    """使用与原包一致的带长度字段的 XXTEA 格式。"""
    if not data:
        raise ValueError('不能加密空文件')
    padded = data + b'\0' * ((-len(data)) % 4)
    values = list(struct.unpack('<%dI' % (len(padded) // 4), padded))
    values.append(len(data))
    keys = struct.unpack('<4I', key[:16].ljust(16, b'\0'))
    n = len(values) - 1
    total = 0
    z = values[n]
    for _ in range(6 + 52 // (n + 1)):
        total = (total + DELTA) & MASK
        e = (total >> 2) & 3
        for p in range(n + 1):
            y = values[p + 1] if p < n else values[0]
            mx = (((z >> 5) ^ (y << 2)) + ((y >> 3) ^ (z << 4))) ^ ((total ^ y) + (keys[(p & 3) ^ e] ^ z))
            values[p] = (values[p] + mx) & MASK
            z = values[p]
    return struct.pack('<%dI' % len(values), *values)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('source', type=Path)
    parser.add_argument('output', type=Path)
    parser.add_argument('--key', required=True)
    parser.add_argument('--sign', default='MQKK')
    parser.add_argument('--encrypt', action='store_true', help='加密单个文件；不自动编译 Lua')
    args = parser.parse_args()
    source, output = args.source.resolve(), args.output.resolve()
    if args.encrypt:
        if not source.is_file():
            parser.error('加密源文件不存在')
        if output.exists() or source == output:
            parser.error('加密输出文件必须不存在')
        data = source.read_bytes()
        key = args.key.encode('utf-8')
        sign = args.sign.encode('ascii')
        if not sign:
            parser.error('文件标记不能为空')
        encrypted = encrypt(data, key)
        if decrypt(encrypted, key) != data:
            raise ValueError('加密往返校验失败')
        output.parent.mkdir(parents=True, exist_ok=True)
        with output.open('xb') as stream:
            stream.write(sign + encrypted)
        print(json.dumps({'output': str(output), 'size': output.stat().st_size,
                          'sign': args.sign, 'roundtrip_verified': True,
                          'source_sha256': hashlib.sha256(data).hexdigest()}, ensure_ascii=False))
        return
    if not source.is_dir():
        parser.error('源目录不存在')
    if output.exists() or source == output or source in output.parents:
        parser.error('输出目录必须不存在且不能位于源目录内')
    files = sorted(source.rglob('*.lua'))
    if not files:
        parser.error('源目录没有 Lua 文件')
    output.mkdir(parents=True)
    records = []
    for path in files:
        raw = path.read_bytes()
        record = {'path': path.relative_to(source).as_posix(), 'source_sha256': hashlib.sha256(raw).hexdigest()}
        try:
            sign = args.sign.encode('ascii')
            if not raw.startswith(sign):
                raise ValueError('文件标记不匹配')
            plain = decrypt(raw[len(sign):], args.key.encode('utf-8'))
            if plain.startswith(b'\x1bLJ'):
                kind = 'luajit'
            elif plain.startswith(b'\x1bLua'):
                kind = 'lua-bytecode'
            else:
                try:
                    text = plain.decode('utf-8')
                    kind = 'utf8-text' if all(ord(c) >= 32 or c in '\r\n\t' for c in text) else 'unknown-binary'
                except UnicodeDecodeError:
                    kind = 'unknown-binary'
            target = output / path.relative_to(source)
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(plain)
            record.update(status='decrypted', format=kind, size=len(plain), header=plain[:8].hex(), output_sha256=hashlib.sha256(plain).hexdigest())
        except Exception as exc:
            record.update(status='failed', error=str(exc))
        records.append(record)
    report = {'source': str(source), 'output': str(output), 'files': records}
    (output / 'decryption-report.json').write_text(json.dumps(report, ensure_ascii=False, indent=2), encoding='utf-8')
    counts = {}
    for record in records:
        label = record.get('format', 'failed')
        counts[label] = counts.get(label, 0) + 1
    print(json.dumps(counts, ensure_ascii=False))
    if any(record['status'] == 'failed' for record in records):
        raise SystemExit(1)


if __name__ == '__main__':
    main()
