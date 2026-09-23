#!/usr/bin/env bash
# 새 워크스테이션 셋업. 저장소 어디서든 실행 가능, 몇 번 실행해도 안전(idempotent).
#   bash scripts/setup-workstation.sh
# 하는 일: 플러그인 설치/갱신 → 옛 복사본 정리 → 유저 CLAUDE.md/settings 반영 → MCP 등록
set -euo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && (pwd -W 2>/dev/null || pwd))"   # Git Bash 에선 Windows 경로
CLAUDE_DIR="$HOME/.claude"
PY="$(command -v python3 || command -v python)"

echo "== 1. CLI"
claude --version || { echo "claude CLI 없음: npm i -g @anthropic-ai/claude-code"; exit 1; }
echo "   (2.1.2xx 미만이면 먼저: claude update)"

echo "== 2. 플러그인 — 마켓플레이스를 이 저장소 경로로 등록 → 설치(캐시 복사). 이미 있으면 update"
claude plugin marketplace add "$REPO" 2>/dev/null || echo "   마켓플레이스 이미 등록됨"
claude plugin install ys-research@ys-skills -s user 2>/dev/null || claude plugin update ys-research@ys-skills

echo "== 3. 플러그인과 중복되는 옛 복사본 정리"
for s in paper-summary research-presentation design-partner code-cleaner midjourney-coach; do
  [ -d "$CLAUDE_DIR/skills/$s" ] && rm -rf "$CLAUDE_DIR/skills/$s" && echo "   removed skills/$s"
done
for a in research-advisor scout; do
  [ -f "$CLAUDE_DIR/agents/$a.md" ] && rm -f "$CLAUDE_DIR/agents/$a.md" && echo "   removed agents/$a.md"
done

echo "== 4. 유저 CLAUDE.md (템플릿 복사본 — 심링크 금지, SETUP_GUIDE 참고)"
if [ ! -f "$CLAUDE_DIR/CLAUDE.md" ]; then
  cp "$REPO/templates/user/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"
  echo "   복사함 → '주요 경로' 절의 placeholder를 이 워크스테이션 실경로로 바꿀 것"
else
  echo "   이미 있음. 변경분: diff \"$CLAUDE_DIR/CLAUDE.md\" \"$REPO/templates/user/CLAUDE.md\""
fi

echo "== 5. 유저 settings.json — outputStyle, autoMemoryDirectory 병합 (다른 키는 유지)"
"$PY" - "$CLAUDE_DIR/settings.json" "$REPO/templates/user/settings.json" <<'PYEOF'
import json, os, sys
dst, src = sys.argv[1], sys.argv[2]
cur = json.load(open(dst, encoding="utf-8")) if os.path.exists(dst) else {}
new = json.load(open(src, encoding="utf-8"))
changed = {k: v for k, v in new.items() if cur.get(k) != v}
cur.update(new)
json.dump(cur, open(dst, "w", encoding="utf-8"), ensure_ascii=False, indent=2)
print("   갱신:", changed if changed else "변경 없음")
PYEOF
mkdir -p "$CLAUDE_DIR/memory-shared"

echo "== 6. MCP (없는 것만 유저 스코프로 등록)"
claude mcp get arxiv-mcp-server >/dev/null 2>&1 || claude mcp add -s user arxiv-mcp-server -- uv tool run arxiv-mcp-server --storage-path "$HOME/.arxiv-mcp-server/papers"
claude mcp get claude-mermaid  >/dev/null 2>&1 || claude mcp add -s user claude-mermaid -- npx -y claude-mermaid
echo "   nanobanana는 API 키·빌드 필요 → docs/mcp-servers.md"
echo "   filesystem MCP는 쓰지 않는다(additionalDirectories 사용). 있으면: claude mcp remove filesystem -s user"

echo "== 완료. Claude Code 재시작 → /output-style 에 discuss·research-dev 가 보이면 정상"
