# Claude Skills Repository

Personal workspace for managing Claude Code skills, agents, and MCP servers.

## 저장소 구조

```
claude-skills/
├── custom/          # 내가 만든 스킬 (paper-summary, design-partner, research-presentation, code-cleaner)
├── agents/custom/   # 내가 만든 에이전트 (research-advisor, scout)
├── global/          # ~/.claude로 배포되는 글로벌 설정·가이드
├── vendor/          # 외부 자산 (git submodule)
│   ├── mcp/         # MCP 서버 (claude-mermaid, nanobanana 등)
│   └── official/    # Anthropic 공식 스킬
└── scripts/         # install/list/uninstall 스크립트
```

## 스킬 vs 에이전트

- **스킬** (`custom/`): 슬래시 커맨드. 사용자가 의식적으로 호출하는 워크플로우.
- **에이전트** (`agents/custom/`): 서브 에이전트. 메인 컨텍스트에서 위임받아 격리된 환경에서 실행.

세부 작성 가이드라인은 `custom/README.md`, `agents/custom/README.md` 참고.

## Current Focus

- **paper-summary**: 논문 읽기 워크플로우 (arxiv → 대화 → Zotero 보강)
- **research-presentation**: 연구 발표 자료 제작
- **research-advisor**: 연구 동향 분석 및 갭 분석 에이전트
- **design-partner**: AI 이미지 생성 코칭 (Midjourney + Nano Banana)

## 작업 패턴

### 새 스킬/에이전트 추가
- `custom/<name>/SKILL.md` 단일 파일 컨벤션 답습
- 외부 지식 참조 시 reference 파일에 공식 문서 URL 명시
- 추가 후 `scripts/install-*.sh`로 배포 검증

### Vendor 동기화
- `vendor/mcp/`, `vendor/official/`은 git submodule
- 업데이트: `git submodule update --remote <path>`

### 저장소 업데이트 → 워크스테이션 사본 반영
- 이 저장소의 `global/CLAUDE.md`는 마스터 템플릿, `~/.claude/CLAUDE.md`는 워크스테이션 사본 (심링크 금지)
- `git pull` 후 사본에 변경분 옮기는 절차·의도된 차이(placeholder ↔ 실경로) 명세는 [`SETUP_GUIDE.md`](../SETUP_GUIDE.md) "7. 저장소 업데이트 반영" 참고

## Maintenance Policy

스킬/에이전트 업데이트 시, 각 스킬이 참조하는 외부 지식(공식 문서, API 변경사항 등)의 최신 버전을 확인하고 반영할 것.

- 각 스킬의 reference 파일에 공식 문서 URL이 명시되어 있음
- 업데이트 작업 시 해당 URL들을 웹에서 확인하여 변경사항 반영
- 특히 버전 업데이트가 잦은 도구(Midjourney 등)는 파라미터/기능 변경 주의

## Vault 연결

이 저장소는 도구·워크플로우 작업이라 Vault와의 직접 연결은 약함. 다만 다음 노트가 관련됨:
- 새 스킬 아이디어 발의: `tmp/`, `Questions/`
- 워크플로우/도구 컨셉 정리: `Concepts/`

신규 Vault 노트 작성·구조 변경은 Vault 작업공간에서 진행 (User CLAUDE.md의 양방향 가드레일 참고).
