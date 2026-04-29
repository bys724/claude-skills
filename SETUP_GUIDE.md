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

### 핵심 원칙: 심링크 금지

`global/CLAUDE.md`는 **워크스테이션 일반 템플릿**으로 유지되어야 함. 심링크로 `~/.claude/CLAUDE.md`를 저장소 파일에 연결하면, 해당 워크스테이션에서 user 가이드를 편집할 때마다 저장소가 워크스테이션 특수 경로(Vault 위치 등)로 오염됨.

```bash
# ❌ 금지
ln -s ~/claude-skills/global/CLAUDE.md ~/.claude/CLAUDE.md

# ✅ 권장 — 사본 + 워크스테이션 실경로 직접 추가
cp ~/claude-skills/global/CLAUDE.md ~/.claude/CLAUDE.md
# ~/.claude/CLAUDE.md의 "주요 경로" 섹션에 placeholder를 실경로로 교체
```

저장소 가이드를 업데이트한 뒤 사본에 반영하려면, 변경분을 수동으로 옮기거나 `cp`를 다시 실행한 뒤 실경로를 재추가할 것.

### 내용 조정
- Vault 경로가 있으면: 복사 후 "주요 경로" 섹션의 placeholder를 실경로로 교체
- Vault가 없으면: "주요 경로" 섹션을 비우거나 주석 처리

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

## 7. 저장소 업데이트 반영 (기존 워크스테이션)

`global/CLAUDE.md`(저장소 마스터)가 업데이트된 후, 이미 셋업된 워크스테이션의 사본(`~/.claude/CLAUDE.md`)에 변경분을 반영하는 절차.

### 의도된 차이 — diff 시 무시할 라인

마스터에는 placeholder, 사본에는 실경로. diff 결과에서 다음은 정상 차이:

| 위치 | 마스터 | 사본 |
|------|-------|------|
| "Vault 노트 양방향 편집 가드레일" 섹션 | `<Vault root>` | 실 Vault 경로 |
| "주요 경로" 섹션 | placeholder + 셋업 안내 문구 | 실경로 두 줄 |

이 외의 모든 차이는 **반영 대상**.

### 절차

```bash
# 1. 저장소 최신화
cd ~/Documents/claude-skills
git pull

# 2. 변경분 확인 (위 placeholder 라인은 무시)
diff ~/.claude/CLAUDE.md global/CLAUDE.md
```

### 반영 방법

- **소규모 변경 (몇 줄)**: diff 보면서 사본에 직접 수동 반영
- **대규모 변경 (구조 변경, 새 섹션 추가 등)**: 사본을 마스터에서 새로 받은 후 워크스테이션 경로 재추가

```bash
cp ~/Documents/claude-skills/global/CLAUDE.md ~/.claude/CLAUDE.md

# 그 후 ~/.claude/CLAUDE.md 편집:
# (a) "Vault 작업공간(<Vault root>)" → 실경로로 교체
# (b) "주요 경로" 섹션의 안내 문구·placeholder 제거 후 실경로 두 줄로 단순화
```

> ⚠️ 사본에 워크스테이션 고유 추가 (예: 해당 머신만의 경로·MCP 설정)가 있으면 cp 전에 백업하거나 수동 반영을 선택할 것.

## 8. 검증 체크리스트

설정 후 확인:
- [ ] `~/.claude.json` 생성/수정됨
- [ ] `~/.claude/CLAUDE.md` 존재
- [ ] `~/.claude/skills/code-cleaner` 설치됨
- [ ] Claude Code 재시작 필요 안내

## 9. 트러블슈팅

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