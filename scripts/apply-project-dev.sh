#!/usr/bin/env bash
# dev 저장소에 프로젝트 층 적용. 몇 번 실행해도 안전.
#   bash scripts/apply-project-dev.sh <repo-path>
# 하는 일: .claude/settings.json 병합(outputStyle + Stop hook) · docs/STATUS.md 생성(없을 때만) · CLAUDE.md에 @docs/STATUS.md 추가
set -euo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && (pwd -W 2>/dev/null || pwd))"   # Git Bash 에선 Windows 경로
T="$REPO/templates/project-dev"
TARGET="${1:?usage: apply-project-dev.sh <repo-path>}"
PY="$(command -v python3 || command -v python)"
cd "$TARGET"
mkdir -p .claude docs

"$PY" - .claude/settings.json "$T/settings.json" <<'PYEOF'
import json, os, sys
dst, src = sys.argv[1], sys.argv[2]
cur = json.load(open(dst, encoding="utf-8")) if os.path.exists(dst) else {}
new = json.load(open(src, encoding="utf-8"))
cur["outputStyle"] = new["outputStyle"]
cur.setdefault("hooks", {})["Stop"] = new["hooks"]["Stop"]   # Stop 만 교체, 다른 hook 은 유지
json.dump(cur, open(dst, "w", encoding="utf-8"), ensure_ascii=False, indent=2)
print("  .claude/settings.json: outputStyle + Stop hook 반영")
PYEOF

if [ ! -f docs/STATUS.md ]; then
  sed "s/<저장소명>/$(basename "$PWD")/" "$T/STATUS.md" > docs/STATUS.md
  echo "  docs/STATUS.md 생성 — 내용은 현재 상태로 채울 것"
else
  echo "  docs/STATUS.md 이미 있음 (유지)"
fi

CM="CLAUDE.md"; [ -f "$CM" ] || CM=".claude/CLAUDE.md"
if grep -q '@docs/STATUS.md' "$CM" 2>/dev/null; then
  echo "  $CM: @docs/STATUS.md 이미 있음"
else
  cat "$T/CLAUDE.md.snippet" >> "$CM"
  echo "  $CM: '현재 상태' 절 + @docs/STATUS.md 추가"
fi
echo "완료: $TARGET"
