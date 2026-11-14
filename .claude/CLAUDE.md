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

- **스킬·에이전트·스타일 수정** → `plugins/ys-research/.claude-plugin/plugin.json`의 `version` 올리기 → `claude plugin validate ./plugins/ys-research` → `claude plugin update ys-research@ys-skills` → Claude Code 재시작. 같은 version이면 update가 캐시를 갱신하지 않음 (2026-09-23 확인, 2026-11-15 Windows 재확인 — 로컬 경로 마켓플레이스여도 `version`이 있으면 `~/.claude/plugins/cache/.../<version>/`로 복사돼 로드됨. 공식 문서의 "로컬은 제자리 로드"와 다름)
- **유저 템플릿 수정** (`templates/user/CLAUDE.md`) → 워크스테이션 사본은 diff 보고 수동 반영 (placeholder ↔ 실경로 차이는 의도됨). 답변 형식 규칙은 여기 말고 `output-styles/`에
- **프로젝트 템플릿 수정** → 대상 저장소에서 `scripts/apply-project-dev.sh` 재실행
- **vendor 갱신** → `git submodule update --remote vendor/mcp/nanobanana` 후 빌드
- **클라우드 루틴 작성·개선** (`routines/*.md`) → 이 로컬 세션이 Vault(유저 CLAUDE.md "주요 경로")를 읽고 관심사·읽은 논문·열린 질문을 요약해 지시문에 반영 → push. 클라우드 루틴은 Vault에 접근하지 못하고 지시문 파일만 읽는다 (Vault 재참조는 사용자가 갱신을 요청할 때만). Vault 쓰기(`_Reading List.md` 등)는 루틴이 하지 않고 보고서의 "Reading List 추가 후보" 블록으로 넘긴다. 루틴 관리는 `/schedule` · claude.ai/code/routines

## Maintenance Policy

스킬이 참조하는 외부 지식(공식 문서·API·모델 이름)은 수정 시 최신 여부 확인. 각 스킬의 reference 파일에 공식 URL 명시. Nano Banana처럼 모델 ID가 자주 바뀌는 도구는 작업 전 공식 deprecations 페이지 확인.

## Vault 연결

도구·워크플로우 저장소라 Vault와 직접 연결은 약함. 새 스킬 아이디어는 `tmp/`·`Questions/`, 워크플로우 컨셉은 `Concepts/`. 신규 Vault 노트 작성·구조 변경은 Vault 작업공간에서 (User CLAUDE.md 양방향 가드레일).
