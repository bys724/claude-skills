# 기기 간 작업 (Mac ↔ Windows) — 세팅 지시

> 2026-11-21 Mac Vault 세션에서 작성. **Mac의 claude-skills 세션이 이 문서를 읽고 §7 순서로 실행한다.** Windows 에서 사용자가 직접 할 몫은 §6 에 따로 모았다.
>
> 사용자 목표: Mac 을 끈 상태에서 Windows 로 옮겨도 **어느 기기에서든 같은 종류의 작업**(Vault 논의·노트, 저장소 docs·커밋)을 같은 방식으로 한다. 대화 상태는 설정으로 못 옮기므로 **인계 노트로 증류**한다. 명령어·스킬은 만들지 않는다 — "동기화 뒤 최신 변경을 보고 이어간다"가 전부다.

## 0. 현황 (2026-11-21 Mac 에서 확인 · 같은 날 정정 · 같은 날 Mac 측 실행 완료)

- **Mac claude-skills 세션 §7 실행 완료 (2026-11-21)**: §2 메모리 50편을 `<Vault>/Meta/claude-memory/` 로 이동(원본 삭제) · Mac `autoMemoryDirectory` 전환 · 템플릿 settings placeholder + setup 스크립트는 `<...>` placeholder 값을 건너뜀 · §3 push 문구·§4 기기별 경로 표를 템플릿과 Mac 사본에 반영 · SETUP_GUIDE §2-5·§3·§5-1·§7 갱신. **남은 것 = §5(Vault 세션) · §6(Windows 사용자)**. 아래 항목들은 실행 전 기록.
- **Windows §6 실행 완료 (2026-11-21)**: 메모리 50편·인계 노트 동기화 확인 · `autoMemoryDirectory` 전환 · `~/.claude/CLAUDE.md` 반영 · 저장소 3개 clone(`input-prior-mae` 제외 · `action-agnostic-visual-rl` 서브모듈 미초기화). **Windows 저장소 위치는 `~/Documents` 가 아니라 `C:/Users/bys72/<repo>`** — claude-skills 가 이미 거기 있어 통일. 아래 §3·§4·§6 의 `~/Documents` 는 Mac 에만 해당. 미실행 = §6-2 Windows Vault `.claude/settings.json` 생성 · §4 "설정 층 구조" Vault 레이어 경로 갱신.
- **Vault 는 양 기기 모두 Obsidian Sync 로 동기화 중이다.** Mac `~/LocalVault/Obsidian Vault` (`.obsidian/core-plugins.json` `"sync": true`) ↔ Windows `C:/Users/bys72/Obsidian/vault_YS` (사용자 확인 · iCloud/OneDrive 와 무관). 처음에 "로컬 폴더"로 적었던 것은 오판 — 정정.
- launchd `com.user.obsidian-backup` 의 1시간 `rsync --delete` → `~/Documents/ObsidianVault_Backup`(iCloud) 은 **별도 백업**일 뿐이다. 그대로 둔다. Windows 는 이 사본을 쓰지 않는다.
- 메모리 = Mac `~/.claude/memory-shared/` (50편 · 256K) **→ §2 완료, 지금은 `<Vault>/Meta/claude-memory/`**. Windows 에 없음 → Vault 안에 넣으면 Obsidian Sync 가 함께 옮긴다. 임시 조치 `tmp/메모리 발췌 2026-11-21.md` 는 §2 뒤 삭제 대상.
- Obsidian Sync 주의 둘: ① **앱이 열려 있을 때만** 동기화된다 — 기기를 끄기 전 Obsidian 에서 동기화 완료(상태 아이콘) 확인. ② `.obsidian/` 외 **점(.) 폴더는 동기화하지 않는다** → **11-21 Vault 세션에서 해결**: `.claude/CLAUDE.md` 를 `Meta/claude/vault-guide.md` 로 옮기고 루트 `CLAUDE.md` 가 `@Meta/claude/vault-guide.md` 로 불러온다(동기화됨). `.claude/settings.json`·`settings.local.json` 은 Mac 절대 경로·권한 목록이라 **기기별로 두는 게 맞음**(옮기지 않음 · Windows 는 자기 것 생성). 옛 `.claude/agents/obsidian-research-assistant.md` 삭제.

## 1. 동기화 방식 — 결정 완료 (A · Obsidian Sync · 이미 운용 중)

사용자가 11-21 확인. 추가 결정 없음. OneDrive/git 안은 폐기. §2 이하 **바로 진행 가능**.

## 2. 메모리 → Vault 안으로 (Mac 에서 실행 · 차단 없음)

1. `~/.claude/memory-shared/` → `<Vault>/Meta/claude-memory/` 이동(복사 → 검증 → 원본 삭제). 50편 전부 + `MEMORY.md`. 이동 뒤 `MEMORY.md` 머리말에 "2026-11-xx Vault `Meta/claude-memory/` 로 이동(기기 간 동기화)" 한 줄.
2. Mac `~/.claude/settings.json`: `"autoMemoryDirectory": "~/LocalVault/Obsidian Vault/Meta/claude-memory"` .
3. 이 저장소: `templates/user/settings.json` 의 `autoMemoryDirectory` 를 `<Vault root>/Meta/claude-memory` placeholder 로. `scripts/setup-workstation.sh` 52행 `mkdir -p "$CLAUDE_DIR/memory-shared"` 제거(메모리 폴더는 Vault 가 들고 온다). SETUP_GUIDE §2-5 · §7 Vault 있음 항목 문구 갱신.
4. Obsidian 그래프에 메모리가 섞이는 게 싫으면 Obsidian 설정 "Files & Links → Excluded files" 에 `Meta/claude-memory` (선택 · 사용자).
5. 완료 뒤 Vault `tmp/메모리 발췌 2026-11-21.md` 는 삭제해도 된다(원본이 동기화되므로). 삭제는 Vault 세션에서.

## 3. 저장소를 양 기기에 — git 이 동기화 수단

- Windows 에 `~/Documents/<repo>` 로 clone(§6): `source-field-alternation` · `action-agnostic-visual-rl` · `action-agnostic-paper` · `claude-skills`(이미 있음) · 필요 시 `input-prior-mae`.
- 규칙: **세션 시작 fetch · 세션 끝 push**. 사용자 push 정책("요청 시만")은 **기기를 바꾸는 세션에 한해 끝날 때 push** 로 수정 — 11-21 사용자 발언("관련 저장소 최신 버전을 받아놓고 대화를 시작하는 편")과 의도 일치, 문구만 승인받고 `templates/user/CLAUDE.md` Git 워크플로우 절에 한 줄 추가 → `~/.claude/CLAUDE.md` 사본에도 반영.

## 4. 경로 — 홈 기준으로 통일

- 저장소는 양 기기 모두 `~/Documents/<repo>`. 문서의 `/Users/bys724/Documents/...` 는 `~/Documents/...` 로.
- `templates/user/CLAUDE.md` "주요 경로" placeholder 를 **기기별 표**로: Vault(Mac `~/LocalVault/Obsidian Vault` · Windows `C:/Users/bys72/Obsidian/vault_YS`) · claude-skills(`~/Documents/claude-skills`). 각 워크스테이션 사본은 자기 행만 유효. `~/.claude/CLAUDE.md` 사본에도 반영.
- Vault 루트 `CLAUDE.md` 의 `file:///Users/bys724/Documents/<repo>` 링크 교체는 **Vault 세션**에서(§5 와 같은 편집 · 가드레일상 Vault CLAUDE.md 정책 변경은 Vault 세션).
- `~/.claude/settings.json` 의 `permissions.additionalDirectories`·`sandbox` 는 기기별 파일이라 그대로.
- `templates/user/CLAUDE.md` "설정 층 구조" 절의 **Vault** 레이어 경로 `Obsidian Vault/.claude/CLAUDE.md` → `Obsidian Vault/Meta/claude/vault-guide.md` (루트 CLAUDE.md 가 @import). `~/.claude/CLAUDE.md` 사본에도.

## 5. Vault 루트 `CLAUDE.md` 에 "기기 간 작업" 절 (Vault 세션에서 · 짧게 · 이 저장소 세션은 **지시만 남김**)

- **한 번에 한 기기.** 세션을 닫고 동기화 완료를 확인한 뒤 다른 기기를 연다.
- **세션 시작**: 동기화 확인 → `tmp/` 의 최신 `* 인계 *.md` 와 MEMORY.md 상단 → 관련 저장소 `git fetch` → 이어간다.
- **세션 끝(기기를 바꿀 때)**: 논의 상태를 `tmp/<주제> 인계 <날짜>.md` 로 증류(재개 지점·미확정·금지 사항) · 메모리 포인터 한 줄 · 저장소 변경은 push.
- 기기별 경로 표(§4).

## 6. Windows 에서 사용자가 직접 할 일 (Mac 세션 완료 뒤)

1. Obsidian 열어 동기화 완료 확인 → `Meta/claude-memory/` 와 `tmp/*인계*.md` 가 보이는지.
2. Vault 지침은 `Meta/claude/vault-guide.md` 로 동기화돼 오므로 복사할 것 없음. Windows Vault 의 `.claude/settings.json` 은 **자기 경로로 새로 생성**(`permissions.additionalDirectories` 에 Windows 저장소 경로). 권한 허용 목록은 쓰면서 쌓이게 둔다.
3. `~/.claude/settings.json`: `"autoMemoryDirectory": "C:/Users/bys72/Obsidian/vault_YS/Meta/claude-memory"` · `permissions.additionalDirectories` 에 Vault 경로.
4. `cd ~/Documents/claude-skills && git pull` → `claude plugin update ys-research@ys-skills` → `~/.claude/CLAUDE.md` 를 템플릿과 diff 해 경로 표·push 한 줄 반영.
5. 저장소 clone(§3).
6. 첫 세션: 동기화 완료 확인 → `tmp/TPC 인계 2026-11-21.md` §4 부터.

## 7. Mac claude-skills 세션 실행 순서

1. 이 문서 읽기. §1 은 결정 완료 — 바로 §2 로.
2. §2 메모리 이동 + Mac settings + 템플릿·스크립트·SETUP_GUIDE 갱신.
3. §3 push 정책 문구 승인 → 템플릿 + 사본.
4. §4 경로 표 → 템플릿 + 사본.
5. §5 는 Vault 세션 몫 — 이 저장소에서는 하지 않는다. 사용자에게 "다음 Vault 세션에서 §5" 라고 알린다.
6. §6 을 사용자에게 체크리스트로 출력.
7. 이 문서 §0 "현황" 을 갱신하고 SETUP_GUIDE §7 에 한 줄 추가 → 커밋 → push(Windows 가 pull 하므로).
