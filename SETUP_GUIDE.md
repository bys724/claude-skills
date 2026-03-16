# Workstation Setup Guide

> 이 문서는 새 워크스테이션에서 "claude-skills 세팅해줘"라고 요청받았을 때 Claude가 참고하는 가이드입니다.

## 핵심 원칙: 사용자 계정 레벨 우선

스킬, MCP 서버, 에이전트 등을 적용할 때 **가능한 한 사용자 계정(user) 레벨에서 설정**할 것.
- MCP: `claude mcp add -s user ...` (프로젝트별 반복 설정 방지)
- 스킬/에이전트: `~/.claude/skills/`, `~/.claude/agents/` 등 계정 레벨 경로에 설치
- 프로젝트 레벨(`.mcp.json`, 프로젝트별 설정)은 해당 프로젝트에서만 필요한 경우에만 사용

## 1. 환경 파악

먼저 다음 정보를 확인하세요:
```bash
# OS 타입 확인
uname -s  # Darwin(macOS), Linux, Windows

# 홈 디렉토리 확인
echo $HOME

# Obsidian Vault 존재 여부
ls -la ~/Documents | grep -i obsidian
ls -la ~/LocalVault
```

## 2. 계정 레벨 설정 (~/.claude.json)

### 기본 구조
```json
{
  "additionalDirectories": [
    // Vault가 있으면 추가
    // 없으면 비워둠
  ],
  "mcpServers": {
    // 필요한 MCP만 추가
  }
}
```

### OS별 샌드박스 설정

#### macOS (Seatbelt 사용)
```json
"sandbox": {
  "enabled": true,
  "filesystem": {
    "allowWrite": [
      // Vault 경로가 있으면 추가
    ]
  }
}
```

#### Linux (bubblewrap 사용)
```json
"sandbox": {
  "enabled": true,
  "filesystem": {
    "allowWrite": [
      // 필요한 경로만
    ]
  }
}
```

#### Windows
- 샌드박스 설정 불필요 (기본적으로 없음)

## 3. CLAUDE.md 설정

### 위치
- `~/.claude/CLAUDE.md`: 계정 레벨
- `{vault}/.claude/CLAUDE.md`: Obsidian용 (있는 경우만)

### 내용 조정
- Vault 경로가 있으면: `global/CLAUDE.md` 복사 후 경로 수정
- Vault가 없으면: 주요 경로 섹션 제거

## 4. 스킬 설치

### 필수 스킬
```bash
# code-cleaner (리팩토링용)
cp -r custom/code-cleaner ~/.claude/skills/
```

### 선택 스킬
- `research-presentation`: 연구 발표용 (Obsidian 필요)
- `paper-summary`: 논문 정리용
- 필요에 따라 선택적 설치

## 5. MCP 서버 설정

### 기본 MCP (항상)
- arxiv-mcp-server: 논문 검색
- claude-mermaid: 다이어그램

### Vault가 있는 경우
**주의**: filesystem MCP 서버를 별도로 만들지 마세요!
- additionalDirectories에 Vault 경로 추가
- sandbox.allowWrite에 쓰기 권한 추가

### Vault가 원격에 있는 경우
```json
"ssh-mcp": {
  "type": "ssh",
  "host": "remote-server",
  "path": "/path/to/vault"
}
```

## 6. 워크스테이션별 대응

### 케이스 1: 맥북 (Vault 있음)
```json
{
  "additionalDirectories": [
    "/Users/username/LocalVault/Obsidian Vault"
  ],
  "sandbox": {
    "enabled": true,
    "filesystem": {
      "allowWrite": ["/Users/username/LocalVault"]
    }
  }
}
```

### 케이스 2: 리눅스 워크스테이션 (Vault 없음)
```json
{
  "additionalDirectories": [],
  "sandbox": {
    "enabled": true,
    "filesystem": {
      "allowWrite": []
    }
  }
}
```

### 케이스 3: SSH로 Vault 접근
- ssh-mcp 설정
- 로컬 임시 노트: `~/temp-notes/`

## 7. 검증 체크리스트

설정 후 확인:
- [ ] `~/.claude.json` 생성/수정됨
- [ ] `~/.claude/CLAUDE.md` 존재
- [ ] `~/.claude/skills/code-cleaner` 설치됨
- [ ] Claude Code 재시작 필요 안내

## 8. 트러블슈팅

### 문제: Obsidian 접근 안 됨
- additionalDirectories 확인
- 절대 경로 사용 확인
- sandbox.allowWrite 확인

### 문제: MCP 충돌
- filesystem-* 네이밍 피하기
- 프로젝트 자동 생성 filesystem과 충돌 주의

### 문제: 권한 에러
- macOS: Seatbelt 제한 확인
- Linux: bubblewrap 설정 확인

## 사용 예시

사용자: "새 워크스테이션에 claude-skills 세팅해줘"

1. OS와 Vault 위치 확인
2. 상황에 맞는 설정 적용
3. 필요한 스킬만 설치
4. 재시작 안내

---
**Note**: 이 가이드는 유연하게 적용하세요. 모든 워크스테이션이 다르므로 상황에 맞게 조정 필요.