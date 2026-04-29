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
- **설정 필요**: `sandbox.filesystem.allowWrite` in ~/.claude.json
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

### filesystem (조건부)

공식 파일시스템 접근 MCP 서버. **Obsidian Vault 접근을 위해 필수**.

**주요 use case:**
- Obsidian Vault 읽기/쓰기
- 논문 메모 작성 및 관리
- paper-summary, research-presentation 스킬에서 사용

```bash
# Claude Code (User-level 권장)
# Obsidian Vault만 포함하는 것을 권장
claude mcp add -s user filesystem \
  -- npx -y @modelcontextprotocol/server-filesystem \
  "/Users/bys724/LocalVault/Obsidian Vault"
```

**Claude Desktop 직접 설정:**
```json
// ~/Library/Application Support/Claude/claude_desktop_config.json
{
  "mcpServers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem",
        "/Users/bys724/LocalVault/Obsidian Vault"
      ]
    }
  }
}
```

**환경별 차이점:**
- **macOS**: `/Users/bys724/LocalVault/Obsidian Vault`
- **Linux**: `/home/username/Documents/Obsidian Vault`
- **Windows**: `C:/Users/username/Documents/Obsidian Vault` (슬래시 사용)
- 공백이 있는 경로는 따옴표로 감싸기
- 여러 디렉토리 지정 가능하나, 보안상 필요한 것만 포함 권장

### arxiv-mcp-server

논문 검색, 다운로드, 읽기를 위한 MCP 서버. paper-summary 스킬에서 사용.

```bash
# Claude Code
# uv 설치 필요: https://docs.astral.sh/uv/
claude mcp add -s user arxiv-mcp-server \
  -- uv tool run arxiv-mcp-server \
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

**이 저장소에서 관리:**
```bash
# 저장소 클론 시 서브모듈로 포함됨
cd ~/claude-skills
git submodule update --init --recursive

# 의존성 설치 및 빌드
cd vendor/mcp/claude-mermaid
npm install
npm run build
```

**Claude Desktop 직접 설정:**
```json
{
  "mcpServers": {
    "claude-mermaid": {
      "command": "node",
      "args": [
        "/Users/bys724/claude-skills/vendor/mcp/claude-mermaid/build/index.js"
      ]
    }
  }
}
```

**환경별 차이점:**
- **macOS**: `/Users/bys724/claude-skills/...`
- **Linux**: `/home/username/claude-skills/...`
- **Windows**: `C:/Users/username/claude-skills/...` (슬래시 사용)
- Node.js 필요 (이미 설치되어 있을 것)

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

## 새 워크스테이션 세팅 워크플로우

### 1. 전역 설정 (CLAUDE.md)

```bash
# 이 저장소 클론
git clone <repo-url> ~/claude-skills

# 전역 CLAUDE.md를 사본으로 두기 (심링크 금지 — 워크스테이션 특수 경로가 저장소로 역류함)
cp ~/claude-skills/global/CLAUDE.md ~/.claude/CLAUDE.md
# 이후 ~/.claude/CLAUDE.md "주요 경로" 섹션에 워크스테이션 실경로 추가
# 자세한 절차: ~/claude-skills/SETUP_GUIDE.md
```

### 2. MCP 서버 등록

```bash
# arxiv-mcp-server
claude mcp add -s user arxiv-mcp-server \
  -- uv tool run arxiv-mcp-server \
  --storage-path ~/.arxiv-mcp-server/papers
```

### 3. 스킬 등록

```bash
# Claude Code 설정에서 스킬 경로 추가
# Settings > Skills > Add skill path: ~/claude-skills/custom/
```

### 4. 에이전트 등록

```bash
# Claude Code 설정에서 에이전트 경로 추가
# Settings > Agents > Add agent path: ~/claude-skills/agents/custom/
```

### 5. 프로젝트별 설정 (필요 시)

```bash
# vault 접근 권한 추가 (settings.json)
# ~/.claude/settings.json에 additionalDirectories 추가
```

### 6. 로컬 환경 조정

저장소 설정은 범용 경로를 사용하므로, 각 머신의 실제 환경에 맞게 조정이 필요합니다.

#### 6.1. 전역 CLAUDE.md 경로 수정

`global/CLAUDE.md`의 "주요 경로" 섹션은 저장소에 커밋하지 않고 로컬에서만 수정:

```bash
# global/CLAUDE.md 파일을 열고 실제 경로로 수정
# 예: Vault 경로를 /Users/bys724/LocalVault/Obsidian Vault로 변경
```

**중요:** 이 수정사항은 `.git/info/exclude`에 추가하거나, 커밋 시 주의해서 제외해야 합니다.

#### 6.2. MCP 서버 경로 조정

MCP 서버 등록 시 실제 사용 중인 경로로 조정:

```bash
# 예: 기존 arxiv papers 디렉토리가 있다면 그 경로 사용
claude mcp add -s user arxiv-mcp-server \
  -- uv tool run arxiv-mcp-server \
  --storage-path /Users/bys724/.arxiv-mcp-server/papers
```

#### 6.3. 로컬 설정 파일 활용

머신별 차이점이 많다면 로컬 설정 파일 사용 검토:

- `.claude/settings.local.json` (프로젝트별)
- 별도의 `local-paths.sh` 스크립트 (gitignore)

---

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

### filesystem 서버가 Vault에 접근하지 못할 때

1. 경로가 정확한지 확인:
   ```bash
   ls -la "/Users/bys724/LocalVault/Obsidian Vault"
   ```

2. User-level로 등록되었는지 확인:
   ```bash
   claude mcp list
   # "filesystem:" 줄에서 경로 확인
   ```

3. Project-level 설정이 있다면 제거:
   ```bash
   # ~/.claude.json에서 projects.<project-path>.mcpServers.filesystem 제거
   ```

### 여러 워크스테이션에서 설정 동기화

MCP 서버 설정(`~/.claude.json`)은 동기화하지 않는 것을 권장합니다:
- 경로가 환경마다 다름
- 내부 상태 정보 포함
- 대신 이 문서를 참고하여 각 머신에서 재설정
