"""兼容入口：``python server/server.py``，等价于 ``python -m game_server``。"""
from pathlib import Path
import sys

sys.path.insert(0, str(Path(__file__).resolve().parent))

from game_server.cli import main  # noqa: E402

if __name__ == '__main__':
    main()
