# Workstation Setup Guide

> 새 워크스테이션에서 "claude-skills 세팅해줘"라고 요청받았을 때 Claude가 따르는 가이드.

## 원칙

- **사용자 계정 레벨 우선**: 플러그인·MCP는 `-s user`. 프로젝트 레벨은 그 저장소에서만 필요한 것만.
- **`~/.claude/CLAUDE.md`는 템플릿 복사본**. 심링크 금지 — 워크스테이션 실경로가 저장소 템플릿으로 역류함.
- **스킬·에이전트는 `~/.claude/skills`에 복사하지 않는다.** 플러그인으로 설치되고 갱신은 `claude plugin update`.

## 1. 저장소

```bash
git clone --recurse-submodules https://github.com/bys724/claude-skills.git
```

`vendor/mcp/nanobanana`는 MCP 서버 소스. 이미지 생성을 안 쓰는 워크스테이션은 `--recurse-submodules` 생략.

## 2. 스크립트 실행

```bash
bash scripts/setup-workstation.sh
```

하는 일 (재실행 안전):
1. CLI 버전 확인 — 2.1.2xx 미만이면 `claude update` 먼저
2. 마켓플레이스를 이 저장소 경로로 등록 → `ys-research` 플러그인 설치 (이미 있으면 update)
3. `~/.claude/skills/`·`agents/`의 옛 복사본 중 플러그인과 겹치는 것 삭제
4. `~/.claude/CLAUDE.md` 없으면 템플릿 복사
5. `~/.claude/settings.json`에 `outputStyle: ys-research:discuss`, `autoMemoryDirectory: ~/.claude/memory-shared` 병합 (다른 키 유지)
6. MCP 등록 — arxiv-mcp-server, claude-mermaid (없는 것만)

## 3. 수동 마무리

- `~/.claude/CLAUDE.md` 맨 아래 "주요 경로"의 placeholder를 실경로로 교체
- nanobanana MCP: API 키·빌드 → [docs/mcp-servers.md](docs/mcp-servers.md)
- Vault가 있으면 `~/.claude.json`의 `additionalDirectories`에 Vault 경로 추가. **filesystem MCP 서버를 만들지 말 것** (권한 충돌·중복 — [docs/MCP_FILESYSTEM_SOLUTION.md](docs/MCP_FILESYSTEM_SOLUTION.md))
- 샌드박스: macOS(Seatbelt)·Linux(bubblewrap)는 `sandbox.filesystem.allowWrite`에 Vault 경로. Windows는 불필요
- Claude Code 재시작 → `/output-style`에 `ys-research:discuss`·`ys-research:research-dev`가 보이면 정상

## 4. 실험 저장소 (프로젝트 층)

```bash
bash scripts/apply-project-dev.sh <repo-path>
```

- `.claude/settings.json`: `outputStyle: ys-research:research-dev` + Stop hook(보고 형식 검사) 병합
- `docs/STATUS.md`: 없을 때만 템플릿 생성 → **현재 상태로 채우고 커밋**
- `CLAUDE.md`: `@docs/STATUS.md` 한 줄 추가 (매 세션 상태 자동 로드)

문서·설정만 건드리므로 Vault 세션에서 여러 저장소에 일괄 적용 가능. 다른 워크스테이션은 그 저장소를 pull하면 따라온다. 대상: 클러스터 실험 저장소(source-field-alternation, action-agnostic-visual-rl). 논문 저장소·Vault는 대상 아님.

## 5. 갱신

| 층 | 방법 |
|---|---|
| 플러그인 | `git pull` → `claude plugin update ys-research@ys-skills` (또는 setup 스크립트 재실행) → 재시작. **내용을 바꿨으면 `plugin.json`의 `version`을 올려야 update가 반영됨** (같은 버전이면 캐시 유지) |
| 유저 | `setup-workstation.sh` 재실행(settings 병합) + `~/.claude/CLAUDE.md`는 diff 보고 수동 반영 |
| 프로젝트 | `apply-project-dev.sh` 재실행 (settings·hook 갱신, STATUS.md는 건드리지 않음) |

`~/.claude/CLAUDE.md` diff 시 **의도된 차이** = "Vault 노트 양방향 편집 가드레일"과 "주요 경로"의 placeholder ↔ 실경로. 그 외는 반영 대상.

## 6. 선택: Advisor

결정 지점(접근 확정 전·완료 선언 전)에 상위 모델이 대화 전체를 검토하는 실험 기능. `/advisor opus`로 켬, `advisorModel` 설정으로 고정. 호출마다 비용 발생 — 기본 off, 클러스터 세션처럼 판단 실수 비용이 큰 곳에서만.

## 7. 워크스테이션 케이스

- **Vault 있음 (맥북)**: `additionalDirectories` + `sandbox.allowWrite`에 Vault 경로
- **Vault 없음 (리눅스 클러스터 PC)**: 두 항목 비움. 설계 관찰은 저장소 `docs/VAULT_SYNC_TODO.md`에 기록 (Vault 세션이 반영)
- **SSH로 Vault 접근**: ssh-mcp 설정, 로컬 임시 노트 `~/temp-notes/`
