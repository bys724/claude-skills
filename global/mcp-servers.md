# MCP Server Configuration

새 워크스테이션에서 Claude Code MCP 서버를 설정하기 위한 가이드.

`~/.claude.json`은 Claude Code 내부 상태가 섞여 있어 직접 관리하지 않고,
`claude mcp add` 명령으로 개별 등록한다.

## 사용자 레벨 MCP 서버 목록

### arxiv-mcp-server

논문 검색, 다운로드, 읽기를 위한 MCP 서버. paper-summary 스킬에서 사용.

```bash
# uv 설치 필요: https://docs.astral.sh/uv/
claude mcp add -s user arxiv-mcp-server \
  -- uv tool run arxiv-mcp-server \
  --storage-path ~/.arxiv-mcp-server/papers
```

**환경별 차이점:**
- `uv` 경로: 보통 `~/.local/bin/uv` 또는 `~/.cargo/bin/uv`
- `--storage-path`: 원하는 위치로 변경 가능

---

## 새 워크스테이션 세팅 워크플로우

### 1. 전역 설정 (CLAUDE.md)

```bash
# 이 저장소 클론
git clone <repo-url> ~/claude-skills

# 전역 CLAUDE.md 심링크
ln -s ~/claude-skills/global/CLAUDE.md ~/.claude/CLAUDE.md
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

---

## MCP 서버 추가 시

새 MCP 서버를 도입하면 이 파일에 기록:
1. 서버 이름, 용도
2. 설치 명령어
3. 환경별 차이점 (경로, 인증 등)
