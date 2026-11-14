# MCP Server Configuration

새 워크스테이션에서 Claude Code MCP 서버를 설정하기 위한 가이드.

## 중요: Claude Desktop vs Claude Code

- **Claude Desktop**의 MCP 설정: `~/Library/Application Support/Claude/claude_desktop_config.json`
- **Claude Code**의 MCP 설정: `~/.claude.json`
- 두 설정은 **별도**이므로 **공유되지 않음**
- `claude mcp add-from-claude-desktop` 명령으로 가져올 수 있으나, 인터랙티브 UI가 필요하여 실패할 수 있음
- 실패 시 `claude mcp add` 명령으로 수동 등록

## User-level vs Project-level

**User-level (`-s user`):**
- 모든 프로젝트에서 공통으로 사용
- `~/.claude.json`의 `mcpServers` 섹션에 저장
- **권장**: 대부분의 MCP 서버는 user-level로 등록

**Project-level (기본값):**
- 특정 프로젝트에서만 사용
- `~/.claude.json`의 `projects.<project-path>.mcpServers`에 저장
- 저장소별로 다시 설정해야 함

`~/.claude.json`은 Claude Code 내부 상태가 섞여 있어 직접 편집하지 않고,
`claude mcp add` 명령으로 등록하는 것을 권장합니다.

## OS별 샌드박스 차이점

### macOS (Darwin)
- **샌드박스**: Seatbelt 사용 (제한적)
- **쓰기 권한**: 작업 디렉토리 외부는 명시적 허용 필요
- **설정 필요**: `~/.claude/settings.json`의 `sandbox.filesystem.allowWrite` (`~/.claude.json` 아님)
- **MCP 충돌 주의**: filesystem MCP 서버 이름 충돌 피하기

### Linux
- **샌드박스**: bubblewrap 사용
- **쓰기 권한**: macOS보다 유연
- **설정 필요**: 기본 설정으로 충분한 경우 많음

### Windows
- **샌드박스**: 기본적으로 없음
- **쓰기 권한**: 제한 없음
- **설정 필요**: 최소

## 사용자 레벨 MCP 서버 목록

### filesystem — 쓰지 않음

Vault 접근은 MCP 서버가 아니라 `~/.claude/settings.json`의 `permissions.additionalDirectories`에 Vault 경로를 넣어서 한다 (내장 Read/Edit가 그대로 동작). filesystem MCP를 같이 두면 권한 충돌·도구 중복 — 경위는 [MCP_FILESYSTEM_SOLUTION.md](MCP_FILESYSTEM_SOLUTION.md). 이미 등록돼 있으면 `claude mcp remove filesystem -s user`. Claude **Desktop** 앱에서만 Vault가 필요하면 그 앱 설정에 한해 쓴다.

### arxiv-mcp-server

논문 검색, 다운로드, 읽기를 위한 MCP 서버. paper-summary 스킬에서 사용.

```bash
# Claude Code
# uv 설치 필요: https://docs.astral.sh/uv/
claude mcp add -s user arxiv-mcp-server \
  -- uvx arxiv-mcp-server \
  --storage-path ~/.arxiv-mcp-server/papers
```

**Claude Desktop 직접 설정:**
```json
{
  "mcpServers": {
    "arxiv-mcp-server": {
      "command": "uv",
      "args": [
        "tool",
        "run",
        "arxiv-mcp-server",
        "--storage-path",
        "/Users/username/.arxiv-mcp-server/papers"
      ]
    }
  }
}
```

**환경별 차이점:**
- `uv` 경로: 보통 `~/.local/bin/uv` 또는 `~/.cargo/bin/uv`
- `--storage-path`: 원하는 위치로 변경 가능
- Windows: uv를 막 설치했다면 VSCode·터미널을 **완전히 재시작**해야 Claude Code가 `uvx`를 찾는다 (안 하면 `Failed to connect`)
- **0.8+ 동작 변화**: `read_paper`·`download_paper`는 기본 12k자 청크만 반환 (`return_full_text: true`로 전문). 섹션 단위는 `get_paper_outline` → `read_paper_section`. `search_papers` 기본 5건, `date_from`/`date_to` 필터. 타임아웃 env는 `ARXIV_REQUEST_TIMEOUT`
- npx로 실행하지 말 것 — 같은 이름의 무관한 npm 패키지가 있음

### ssh-mcp

원격 서버 SSH 접근 MCP 서버. 특정 서버에 대한 SSH 명령 실행.

```bash
# Claude Code
claude mcp add -s user ssh-mcp \
  -- npx -y ssh-mcp \
  -- --host=hostname --user=username --key=~/.ssh/id_ed25519
```

**Claude Desktop 직접 설정:**
```json
{
  "mcpServers": {
    "ssh-mcp": {
      "command": "npx",
      "args": [
        "-y",
        "ssh-mcp",
        "--",
        "--host=10.254.39.136",
        "--user=etri",
        "--key=/Users/username/.ssh/id_ed25519"
      ]
    }
  }
}
```

**환경별 차이점:**
- `--host`: 접속할 서버 IP/호스트명
- `--user`: SSH 사용자명
- `--key`: SSH 키 경로 (절대 경로 사용 권장)

### apify

Apify Store의 웹 스크레이퍼/크롤러 접근 MCP 서버. 소셜미디어, 검색엔진, 지도, 이커머스 등 데이터 추출.

```bash
# Claude Code
# Apify API token 필요: https://console.apify.com/account#/integrations
claude mcp add -s user apify \
  --env APIFY_TOKEN=your_apify_api_token \
  -- npx -y @apify/actors-mcp-server
```

**Claude Desktop 직접 설정:**
```json
{
  "mcpServers": {
    "actors-mcp-server": {
      "command": "npx",
      "args": ["-y", "@apify/actors-mcp-server"],
      "env": {
        "APIFY_TOKEN": "your_apify_api_token"
      }
    }
  }
}
```

**환경별 차이점:**
- `APIFY_TOKEN`: [Apify Console](https://console.apify.com/account#/integrations)의 Integrations 섹션에서 발급
- Node.js v18 이상 필요
- Actor 실행 시 Apify 계정 크레딧 사용될 수 있음

**주요 기능:**
- Apify Store에서 Actor 검색 및 실행
- 웹 스크래핑, 크롤링, 자동화 도구 수천 개 접근
- 실행 결과 및 로그 조회
- 데이터셋 및 key-value 스토어 접근

### nanobanana (공식 Gemini 이미지 확장)

Gemini의 이미지 생성/편집 MCP 서버. design-partner 스킬에서 사용.
공식 `gemini-cli-extensions/nanobanana` 내부의 MCP 서버를 standalone 으로 실행.

**이 저장소에서 관리** (submodule):
```bash
cd ~/claude-skills
git submodule update --init vendor/mcp/nanobanana
cd vendor/mcp/nanobanana/mcp-server
npm install && npm run build
```

**Claude Desktop 직접 설정:**
```json
{
  "mcpServers": {
    "nanobanana": {
      "command": "node",
      "args": [
        "/Users/bys724/Documents/claude-skills/vendor/mcp/nanobanana/mcp-server/dist/index.js"
      ],
      "env": {
        "NANOBANANA_API_KEY": "..."
      }
    }
  }
}
```

**모델 지정 필수** (2026-11): 확장 내장 기본값 `gemini-3.1-flash-image-preview`는 2026-06-25 종료됐다. `env`에 `"NANOBANANA_MODEL": "gemini-nano-banana-2.1"` (또는 `gemini-3-pro-image`)를 같이 넣을 것. 업스트림은 2026-03 이후 커밋이 없어 새 ID 수용 여부 미검증 — 안 되면 design-partner의 `api-patterns.md` 직접 호출로.

**환경변수 우선순위** (소스 기준):
`NANOBANANA_API_KEY` > `NANOBANANA_GEMINI_API_KEY` > `NANOBANANA_GOOGLE_API_KEY` > `GEMINI_API_KEY` > `GOOGLE_API_KEY`

**제공 도구:**
- `generate_image`, `edit_image`, `restore_image`

**참고:**
- 구버전 `nano-banana-mcp` (ConechoAI, npm) 은 유지보수 정체로 교체
- 키는 Google AI Studio 에서 발급. **프로젝트 단위로 Tier/billing/모델 권한 결정**, 키는 인증 수단일 뿐
- 용도별 키 분리 권장 (MCP용 / 코드용)

### claude-mermaid (추천)

Mermaid 다이어그램 생성 및 렌더링 MCP 서버. 마인드맵, 플로우차트, 시퀀스 다이어그램 등 시각화 도구.

**특징:**
- 라이브 프리뷰 (브라우저 자동 리프레시)
- PNG/SVG/PDF 출력
- 4가지 테마 (default, forest, dark, neutral)
- 완전 무료 (MIT 오픈소스)
- Vault 의존성 없음

**요구사항:** Node **22.13+** (package.json `engines`). Node가 없거나 낮으면 setup 스크립트가 등록을 건너뛴다.

**등록 (npm 패키지 — 빌드 불필요):**
```bash
claude mcp add -s user claude-mermaid -- npx -y claude-mermaid
```
`scripts/setup-workstation.sh`가 Node 22+일 때 없으면 자동 등록. 업스트림 대안: 플러그인으로 설치 (`/plugin marketplace add veelenga/claude-mermaid`). (구 방식인 vendor 서브모듈 빌드는 2026-09에 제거.)

**사용법:**
```
"ROS 노드 구조 마인드맵 만들어줘"
→ 라이브 프리뷰 자동 열림
→ 대화하며 수정
→ "PNG로 저장해줘"
```

**Obsidian 통합:**
- Mermaid 코드 복사 → Obsidian 노트에 붙여넣기 (네이티브 렌더링)
- 또는 PNG 저장 → vault/attachments/에 저장 후 `![[diagram.png]]` 삽입

---

## 새 워크스테이션 세팅

[SETUP_GUIDE.md](../SETUP_GUIDE.md) + `scripts/setup-workstation.sh`. 이 문서는 서버별 상세만 담는다.

## MCP 서버 추가 시

새 MCP 서버를 도입하면 이 파일에 기록:
1. 서버 이름, 용도
2. 설치 명령어
3. 환경별 차이점 (경로, 인증 등)

---

## 트러블슈팅

### MCP 서버가 동작하지 않을 때

```bash
# MCP 서버 상태 확인
claude mcp list

# 연결 실패 시 서버 제거 후 재등록
claude mcp remove <server-name>
claude mcp add -s user <server-name> -- <command> <args...>
```

### `claude mcp add-from-claude-desktop` 실패 시

인터랙티브 UI 필요로 인해 실패할 수 있습니다. 이 경우:

1. Claude Desktop 설정 파일 확인:
   ```bash
   cat ~/Library/Application\ Support/Claude/claude_desktop_config.json
   ```

2. 각 서버를 `claude mcp add` 명령으로 수동 등록

### Claude Desktop 의 mcpServers 가 통째로 사라졌을 때

`~/Library/Application Support/Claude/claude_desktop_config.json` 의 `mcpServers` 섹션이
앱 업데이트/리셋 시 초기화되는 사례 확인됨.

- 같은 폴더 `backups/claude_desktop_config_backup_*.json` 에 직전 설정 남아있음
- 복원 시 경로가 오래된 경우가 많음 — 현재 유효한 경로인지 반드시 재검증
- 평문 API 키가 있었다면 revoke 후 재발급
- 상세 기록: [docs/MCP_DESKTOP_RECOVERY.md](../docs/MCP_DESKTOP_RECOVERY.md)

### Vault 접근이 안 될 때

`/permissions`에서 Vault 경로가 추가 디렉토리로 잡혀 있는지 확인 → 없으면 `~/.claude/settings.json`의 `permissions.additionalDirectories`에 추가 후 재시작. 예전 filesystem MCP가 남아 있으면 제거 (`claude mcp list`).

### 여러 워크스테이션에서 설정 동기화

MCP 서버 설정(`~/.claude.json`)은 동기화하지 않는 것을 권장합니다:
- 경로가 환경마다 다름
- 내부 상태 정보 포함
- 대신 이 문서를 참고하여 각 머신에서 재설정
