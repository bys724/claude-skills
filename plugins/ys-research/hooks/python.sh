#!/usr/bin/env bash
# 실제로 실행되는 Python 을 찾아 인자 그대로 exec. 못 찾으면 127.
#   bash python.sh script.py [args...]   (stdin 은 그대로 전달)
# `command -v python3` 만으로는 부족하다: Windows 는 PATH 에 Microsoft Store 별칭(WindowsApps\python*.exe)이
# 있어서 찾아지긴 하지만 실행하면 실패한다 (2026-11 Windows PC 실측). uv 로 설치한 Python 은
# ~/.local/bin/python3.X 이름만 있고 python3 은 없을 수 있어 그것도 후보에 넣는다.
for p in python3 python py "$HOME"/.local/bin/python3.*; do
  command -v "$p" >/dev/null 2>&1 || continue
  "$p" -c "" >/dev/null 2>&1 </dev/null || continue
  exec "$p" "$@"
done
echo "python.sh: 실행 가능한 Python 없음 (Windows: 'uv python install --default' 또는 python.org 설치)" >&2
exit 127
