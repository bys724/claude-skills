# 기기 간 작업 (Mac ↔ Windows) — 세팅 지시

> 2026-11-21 Mac Vault 세션에서 작성. **Mac의 claude-skills 세션이 이 문서를 읽고 §7 순서로 실행한다.** Windows 에서 사용자가 직접 할 몫은 §6 에 따로 모았다.
>
> 사용자 목표: Mac 을 끈 상태에서 Windows 로 옮겨도 **어느 기기에서든 같은 종류의 작업**(Vault 논의·노트, 저장소 docs·커밋)을 같은 방식으로 한다. 대화 상태는 설정으로 못 옮기므로 **인계 노트로 증류**한다. 명령어·스킬은 만들지 않는다 — "동기화 뒤 최신 변경을 보고 이어간다"가 전부다.

## 0. 현황 (2026-11-21 Mac 에서 확인한 사실)

- Mac Vault = `~/LocalVault/Obsidian Vault`. **로컬 폴더**. git 아님 · Obsidian Sync 아님 · obsidian-git 없음.
- launchd `com.user.obsidian-backup` 이 **1시간마다** `~/LocalVault/obsidian-vault-migration.sh backup` 실행 = `rsync -avh --delete` 로 **Mac Vault → `~/Documents/ObsidianVault_Backup`**(iCloud Desktop&Documents 동기화 대상). **단방향** · `--delete` 라 백업 쪽에 생긴 파일은 다음 실행에 지워진다. (11-21 20시 수동 1회 실행해 당일 인계 노트를 백업에 반영함.)
- Windows Vault = `C:/Users/bys72/Obsidian/vault_YS` (SETUP_GUIDE §7). **어떻게 갱신되는지 미확인** — iCloud for Windows 로 백업 폴더를 받는 것이면 Mac → Windows 단방향이고, Windows 에서 쓴 변경은 Mac 으로 **돌아오지 않거나 덮어써진다**. 사용자에게 먼저 확인할 것.
- 메모리 = Mac `~/.claude/memory-shared/` (50편 · 256K). Windows 에 없음. 임시 조치로 Vault `tmp/메모리 발췌 2026-11-21.md`(23편 원문 사본)와 `tmp/TPC 인계 2026-11-21.md` 를 둠.

**→ 양방향 동기화가 서기 전에는 Windows 에서 Vault 에 쓰지 않는다(읽기만).** 쓰면 유실되거나 Mac 과 갈라진다.

## 1. 차단 결정 — Vault 양방향 동기화 방식 (사용자가 고른다)

| 안 | 방식 | 장점 | 주의 |
|---|---|---|---|
| **A (권장)** | Obsidian Sync (유료) | Obsidian 전용 · 클라우드 중계라 **한 기기가 꺼져 있어도** 됨 · 충돌 처리 내장 · 숨김 폴더(`.claude/`)도 옵션으로 동기화 | 비용 · 대용량 자산(Career pdf 등)은 용량 플랜 확인 |
| B | OneDrive 안에 Vault (양 기기) | 무료 · 이미 OneDrive-개인 사용 중 · 클라우드 중계 | Obsidian + OneDrive 는 파일 잠금·충돌 사본 이슈가 알려져 있음 · 동기화 완료 전 세션 시작 금지 |
| C | git (obsidian-git) | 이력 · 저장소와 같은 규율 | 678MB 자산 → LFS 나 `.gitignore` 필요 · `.obsidian/workspace` 잡음 · 커밋을 의식해야 함 |

- 어느 안이든 **기존 rsync 백업은 백업으로만** 둔다(해 없음). 단 Windows 가 `ObsidianVault_Backup` 사본을 Vault 로 열고 있다면 **그 사본 사용을 중단**하고 동기화된 Vault 를 연다.
- Syncthing 류 P2P 는 두 기기가 동시에 켜져 있어야 동기화되므로 "Mac 을 끈다"는 조건과 맞지 않아 제외.

## 2. 메모리 → Vault 안으로 (동기화 방식 결정 **뒤에** · Mac 에서 실행)

1. `~/.claude/memory-shared/` → `<Vault>/Meta/claude-memory/` 이동(복사 → 검증 → 원본 삭제). 50편 전부 + `MEMORY.md`. 이동 뒤 `MEMORY.md` 머리말에 "2026-11-xx Vault `Meta/claude-memory/` 로 이동(기기 간 동기화)" 한 줄.
2. Mac `~/.claude/settings.json`: `"autoMemoryDirectory": "~/LocalVault/Obsidian Vault/Meta/claude-memory"` (동기화 방식 B/C 로 Vault 경로가 바뀌면 그 경로).
3. 이 저장소: `templates/user/settings.json` 의 `autoMemoryDirectory` 를 `<Vault root>/Meta/claude-memory` placeholder 로. `scripts/setup-workstation.sh` 52행 `mkdir -p "$CLAUDE_DIR/memory-shared"` 제거(메모리 폴더는 Vault 가 들고 온다). SETUP_GUIDE §2-5 · §7 Vault 있음 항목 문구 갱신.
4. Obsidian 그래프에 메모리가 섞이는 게 싫으면 Obsidian 설정 "Files & Links → Excluded files" 에 `Meta/claude-memory` (선택 · 사용자).
5. 완료 뒤 Vault `tmp/메모리 발췌 2026-11-21.md` 는 삭제해도 된다(원본이 동기화되므로). 삭제는 Vault 세션에서.

## 3. 저장소를 양 기기에 — git 이 동기화 수단

- Windows 에 `~/Documents/<repo>` 로 clone(§6): `source-field-alternation` · `action-agnostic-visual-rl` · `action-agnostic-paper` · `claude-skills`(이미 있음) · 필요 시 `input-prior-mae`.
- 규칙: **세션 시작 fetch · 세션 끝 push**. 사용자 push 정책("요청 시만")은 **기기를 바꾸는 세션에 한해 끝날 때 push** 로 수정 — 11-21 사용자 발언("관련 저장소 최신 버전을 받아놓고 대화를 시작하는 편")과 의도 일치, 문구만 승인받고 `templates/user/CLAUDE.md` Git 워크플로우 절에 한 줄 추가 → `~/.claude/CLAUDE.md` 사본에도 반영.

## 4. 경로 — 홈 기준으로 통일

- 저장소는 양 기기 모두 `~/Documents/<repo>`. 문서의 `/Users/bys724/Documents/...` 는 `~/Documents/...` 로.
- `templates/user/CLAUDE.md` "주요 경로" placeholder 를 **기기별 표**로: Vault(Mac `~/LocalVault/Obsidian Vault` · Windows `C:/Users/bys72/Obsidian/vault_YS` 또는 §1 결정에 따른 새 경로) · claude-skills(`~/Documents/claude-skills`). 각 워크스테이션 사본은 자기 행만 유효. `~/.claude/CLAUDE.md` 사본에도 반영.
- Vault 루트 `CLAUDE.md` 의 `file:///Users/bys724/Documents/<repo>` 링크 교체는 **Vault 세션**에서(§5 와 같은 편집 · 가드레일상 Vault CLAUDE.md 정책 변경은 Vault 세션).
- `~/.claude/settings.json` 의 `permissions.additionalDirectories`·`sandbox` 는 기기별 파일이라 그대로.

## 5. Vault 루트 `CLAUDE.md` 에 "기기 간 작업" 절 (Vault 세션에서 · 짧게 · 이 저장소 세션은 **지시만 남김**)

- **한 번에 한 기기.** 세션을 닫고 동기화 완료를 확인한 뒤 다른 기기를 연다.
- **세션 시작**: 동기화 확인 → `tmp/` 의 최신 `* 인계 *.md` 와 MEMORY.md 상단 → 관련 저장소 `git fetch` → 이어간다.
- **세션 끝(기기를 바꿀 때)**: 논의 상태를 `tmp/<주제> 인계 <날짜>.md` 로 증류(재개 지점·미확정·금지 사항) · 메모리 포인터 한 줄 · 저장소 변경은 push.
- 기기별 경로 표(§4).

## 6. Windows 에서 사용자가 직접 할 일 (Mac 세션 완료 뒤)

1. §1 결정에 따라 Vault 동기화 클라이언트 설치·연결. 백업 사본(`ObsidianVault_Backup`)을 열고 있었다면 닫고 동기화된 Vault 를 연다.
2. `~/.claude/settings.json`: `"autoMemoryDirectory": "<Windows Vault>/Meta/claude-memory"` · `permissions.additionalDirectories` 에 Vault 경로.
3. `cd ~/Documents/claude-skills && git pull` → `claude plugin update ys-research@ys-skills` → `~/.claude/CLAUDE.md` 를 템플릿과 diff 해 경로 표·push 한 줄 반영.
4. 저장소 clone(§3).
5. 첫 세션: 동기화 완료 확인 → `tmp/TPC 인계 2026-11-21.md` §4 부터.

## 7. Mac claude-skills 세션 실행 순서

1. 이 문서 읽기 → 사용자에게 **Windows Vault 의 갱신 경로**(iCloud 사본인지 등)와 **§1 A/B/C** 를 묻는다. 결정 전 §2 이하 진행 금지.
2. §2 메모리 이동 + Mac settings + 템플릿·스크립트·SETUP_GUIDE 갱신.
3. §3 push 정책 문구 승인 → 템플릿 + 사본.
4. §4 경로 표 → 템플릿 + 사본.
5. §5 는 Vault 세션 몫 — 이 저장소에서는 하지 않는다. 사용자에게 "다음 Vault 세션에서 §5" 라고 알린다.
6. §6 을 사용자에게 체크리스트로 출력.
7. 이 문서 §0 "현황" 을 갱신하고 SETUP_GUIDE §7 에 한 줄 추가 → 커밋 → push(Windows 가 pull 하므로).
