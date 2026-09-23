# Scripts

| 스크립트 | 용도 |
|---|---|
| `setup-workstation.sh` | 새 워크스테이션 셋업 — 플러그인 등록·옛 복사본 정리·유저 CLAUDE.md/settings·MCP. 재실행 안전 |
| `apply-project-dev.sh <repo>` | 실험 저장소에 프로젝트 층 적용 — settings.json(스타일+hook)·STATUS.md·CLAUDE.md snippet. 재실행 안전 |
| `obsidian-vault-migration.sh` | (macOS) Vault를 iCloud에서 독립 위치로 이동 + launchd 백업. `migrate` / `backup` / `setup-launchd` |

## 설계 원칙

- **최소 유지**: 반복 실행하는 것만 스크립트. 일회성은 SETUP_GUIDE에 명령어로
- **재실행 안전**: 이미 된 단계는 건너뛰고 말해줌
