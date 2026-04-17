# Claude Desktop MCP 복구 로그

> 2026-04-17 트러블슈팅 기록. 반복 실수 방지용.

## 증상

Claude Desktop 앱에서 Obsidian Vault 접근 불가.
MCP 인디케이터도 없음.

## 원인

`~/Library/Application Support/Claude/claude_desktop_config.json` 의
`mcpServers` 섹션이 통째로 사라진 상태. `preferences`만 남음.

- 마지막 정상 동작: 2026-03-10 (mcp.log 기준)
- 이후 MCP 서버 기동 기록 없음
- 같은 폴더 `backups/claude_desktop_config_backup_20260310.json` 에 직전 설정 남아있음

Claude Desktop 앱이 특정 업데이트/리셋 시 config를 초기화할 수 있음.

## 복구 절차

1. `backups/claude_desktop_config_backup_20260310.json` 참조해 `mcpServers` 복원
2. 경로 검증 필수 — Vault 경로가 `Documents/Obsidian Vault` 에서
   `LocalVault/Obsidian Vault` 로 이전된 상태였음
3. 평문 API 키는 빼고 복원 후 키 재발급 (노출된 키는 revoke)
4. Cmd+Q 로 완전 종료 후 재시작

## 동일 기회에 정리한 것

- `nano-banana-mcp` (ConechoAI, npm) → 유지보수 정체 확인 후 제거
- 공식 `gemini-cli-extensions/nanobanana` 로 교체
  - `mcp-server/` 디렉토리가 standalone MCP 서버로 동작
  - `NANOBANANA_API_KEY` 또는 `GEMINI_API_KEY` 둘 다 인식
  - 현재 기본 모델: `gemini-3.1-flash-image-preview` (Nano Banana 2)

## 검증 방법

재시작 전 확인:

```bash
python3 -c "import json; json.load(open('...claude_desktop_config.json'))"
```

재시작 후 확인: 입력창 오른쪽 아래 MCP 인디케이터에 서버명 표시.
로그는 `~/Library/Logs/Claude/mcp*.log`.

## 교훈

- Desktop config 변경 시 백업 자동 생성되는지 확인하는 습관
- 키를 config 에 평문으로 두지 말 것 (유출 시 git 이력까지 남음)
- Claude Code `~/.claude.json` 과 Desktop config 는 별개. 두 번 관리 필요
