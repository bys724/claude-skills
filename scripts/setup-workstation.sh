#!/usr/bin/env bash
# 새 워크스테이션 셋업. 저장소 어디서든 실행 가능, 몇 번 실행해도 안전(idempotent).
#   bash scripts/setup-workstation.sh
# 하는 일: 플러그인 설치/갱신 → 옛 복사본 정리 → 유저 CLAUDE.md/settings 반영 → MCP 등록
set -euo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && (pwd -W 2>/dev/null || pwd))"   # Git Bash 에선 Windows 경로
CLAUDE_DIR="$HOME/.claude"
PY=(bash "$REPO/plugins/ys-research/hooks/python.sh")   # Windows Store 별칭을 건너뛰는 해석기 탐색 (hook 과 공용)
"${PY[@]}" -c "" || exit 1

echo "== 1. CLI"
if ! command -v claude >/dev/null 2>&1; then
  # VSCode 확장만 깔린 머신은 CLI 가 PATH 에 없다 → 확장 번들 바이너리 사용 (Windows .vscode / 원격 .vscode-server)
  B="$(ls -d "$HOME"/.vscode/extensions/anthropic.claude-code-*/resources/native-binary "$HOME"/.vscode-server/extensions/anthropic.claude-code-*/resources/native-binary 2>/dev/null | sort -V | tail -1 || true)"
  [ -n "$B" ] || { echo "claude CLI 없음: https://code.claude.com/docs/en/setup"; exit 1; }
  export PATH="$B:$PATH"; echo "   PATH 에 없음 → 확장 번들 사용: $B"
fi
claude --version
echo "   (2.1.2xx 미만이면 먼저: claude update)"

echo "== 2. 플러그인 — 마켓플레이스를 이 저장소 경로로 등록(로컬 경로라 제자리 로드) → 설치. 이미 있으면 update"
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

echo "== 5. 유저 settings.json — 템플릿 키 병합 (다른 키는 유지)"
"${PY[@]}" - "$CLAUDE_DIR/settings.json" "$REPO/templates/user/settings.json" <<'PYEOF'
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

echo "== 6. MCP (전제 도구가 있고 아직 없는 것만 유저 스코프로 등록 — 전제 없이 등록하면 매 세션 연결 실패)"
if command -v uvx >/dev/null 2>&1; then
  claude mcp get arxiv-mcp-server >/dev/null 2>&1 || claude mcp add -s user arxiv-mcp-server -- uvx arxiv-mcp-server --storage-path "$HOME/.arxiv-mcp-server/papers"
else
  echo "   arxiv-mcp-server 건너뜀: uv 없음 (https://docs.astral.sh/uv/)"
fi
NODE_MAJOR="$(node -p 'process.versions.node.split(".")[0]' 2>/dev/null || echo 0)"
if [ "$NODE_MAJOR" -ge 22 ]; then   # claude-mermaid engines: node >=22.13
  claude mcp get claude-mermaid >/dev/null 2>&1 || claude mcp add -s user claude-mermaid -- npx -y claude-mermaid
else
  echo "   claude-mermaid 건너뜀: Node 22+ 필요 (현재: ${NODE_MAJOR/#0/없음})"
fi
echo "   nanobanana는 API 키·빌드 필요 → docs/mcp-servers.md"
echo "   filesystem MCP는 쓰지 않는다(permissions.additionalDirectories 사용). 있으면: claude mcp remove filesystem -s user"

echo "== 완료. Claude Code 재시작 → /output-style 에 discuss·research-dev 가 보이면 정상"
