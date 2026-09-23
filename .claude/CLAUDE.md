# Claude Skills Repository

Personal workspace for managing Claude Code skills, agents, output styles, and workstation templates.

## 구조

```
.claude-plugin/marketplace.json   # 이 저장소 = 마켓플레이스 ys-skills
plugins/ys-research/              # 플러그인: skills/ agents/ output-styles/
templates/user/                   # ~/.claude 로 복사되는 CLAUDE.md 마스터 · settings.json 키
templates/project-dev/            # 실험 저장소에 적용하는 settings.json · STATUS.md · CLAUDE.md snippet
scripts/                          # setup-workstation.sh · apply-project-dev.sh
docs/                             # AUTHORING.md · mcp-servers.md · 트러블슈팅
vendor/mcp/nanobanana             # git submodule (MCP 서버, 이 경로에서 실행)
```

세 층(플러그인 / 유저 / 프로젝트)의 역할 분담은 [README.md](../README.md), 셋업·갱신 절차는 [SETUP_GUIDE.md](../SETUP_GUIDE.md), 작성 규칙은 [docs/AUTHORING.md](../docs/AUTHORING.md).

## 작업 패턴

- **스킬·에이전트·스타일 수정** → `plugins/ys-research/.claude-plugin/plugin.json`의 `version` 올리기 → `claude plugin validate ./plugins/ys-research` → `claude plugin update ys-research@ys-skills` → Claude Code 재시작. 같은 version이면 update가 캐시를 갱신하지 않음 (2026-09-23 확인)
- **유저 템플릿 수정** (`templates/user/CLAUDE.md`) → 워크스테이션 사본은 diff 보고 수동 반영 (placeholder ↔ 실경로 차이는 의도됨). 답변 형식 규칙은 여기 말고 `output-styles/`에
- **프로젝트 템플릿 수정** → 대상 저장소에서 `scripts/apply-project-dev.sh` 재실행
- **vendor 갱신** → `git submodule update --remote vendor/mcp/nanobanana` 후 빌드

## Maintenance Policy

스킬이 참조하는 외부 지식(공식 문서·API·모델 이름)은 수정 시 최신 여부 확인. 각 스킬의 reference 파일에 공식 URL 명시. Midjourney·Nano Banana처럼 변경이 잦은 도구는 파라미터 주의.

## Vault 연결

도구·워크플로우 저장소라 Vault와 직접 연결은 약함. 새 스킬 아이디어는 `tmp/`·`Questions/`, 워크플로우 컨셉은 `Concepts/`. 신규 Vault 노트 작성·구조 변경은 Vault 작업공간에서 (User CLAUDE.md 양방향 가드레일).
