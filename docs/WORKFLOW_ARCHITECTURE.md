# Workflow Architecture Design

## 현재 문제점 분석

### Context Switching Problem
- **저장소 → Obsidian**: 저장소 CLAUDE.md가 문서 작성 방식 오버라이드
- **Obsidian → 저장소**: 워크스테이션 환경에서 접근성 문제
- **역할 충돌**: 각 CLAUDE.md의 목적이 불분명

## 제안하는 3-Layer Architecture

```
┌─────────────────────────────────────┐
│  1. Global (~/.claude/CLAUDE.md)    │ ← 개인 철학/스타일
├─────────────────────────────────────┤
│  2. Domain (Obsidian/CLAUDE.md)     │ ← 문서 작성 규칙
├─────────────────────────────────────┤
│  3. Project (repo/.claude/CLAUDE.md)│ ← 프로젝트별 기술 규칙
└─────────────────────────────────────┘
```

## 계층별 역할 정의

### Layer 1: Global (계정 레벨)
**위치**: `~/.claude/CLAUDE.md`
**역할**: 개인 철학과 기본 원칙
```markdown
- 최소주의 철학
- YAGNI 원칙
- 언어 선택 (한글/영어)
- 기본 작업 스타일
```

### Layer 2: Domain (Obsidian)
**위치**: `/LocalVault/Obsidian Vault/.claude/CLAUDE.md`
**역할**: 문서 작성 전용 규칙
```markdown
- Obsidian 문서 포맷
- 노트 작성 스타일
- 태그/링크 규칙
- LaTeX 수식 표현
```

### Layer 3: Project (저장소별)
**위치**: `{repo}/.claude/CLAUDE.md`
**역할**: 프로젝트별 기술 규칙
```markdown
- 프로젝트 아키텍처
- 코딩 컨벤션
- API 패턴
- 테스트 전략
```

## 실전 워크플로우

### Scenario 1: 저장소에서 Obsidian 참조
```bash
# 저장소에서 작업 시작
cd ~/projects/my-repo
claude

# Obsidian 노트 읽기 (filesystem-obsidian MCP 사용)
"관련 개념 노트 읽어줘"
→ mcp__filesystem-obsidian__read_file

# 아이디어 기록 (Domain 규칙 명시 적용)
"이 아이디어 Obsidian에 기록해줘 (obsidian-style)"
→ Layer 2 규칙으로 작성
```

### Scenario 2: Cross-Reference 전략
```bash
# 프로젝트 CLAUDE.md에 추가
## Cross References
- 문서 작성: obsidian-style 적용
- 코드 작성: 프로젝트 규칙 적용
```

## 구현 방안

### 1. Directive System (명시적 지시)
```markdown
# 사용 예시
"obsidian-style로 문서 작성해줘"
"project-style로 코드 작성해줘"
```

### 2. Context Flag
```markdown
# 프로젝트 CLAUDE.md에 추가
context_modes:
  - code: default
  - docs: obsidian-style
```

### 3. Workspace Detection
```bash
# 자동 감지 로직
if (writing to Obsidian):
    apply Layer 2 rules
elif (writing code):
    apply Layer 3 rules
else:
    apply Layer 1 rules
```

## 워크스테이션 호환성

### Remote Obsidian Access
```yaml
# MCP 설정 (워크스테이션용)
ssh-obsidian:
  type: ssh
  host: home-server
  path: /home/user/Obsidian
```

### Fallback Strategy
```markdown
# 프로젝트 CLAUDE.md
## Obsidian Unavailable
- 임시 노트: `project/docs/temp-notes.md`
- 나중에 동기화: sync-to-obsidian.sh
```

## Best Practice

### DO ✅
1. **명확한 계층 구조** 유지
2. **컨텍스트 전환 명시** ("obsidian-style로")
3. **프로젝트별 최소 설정**

### DON'T ❌
1. 모든 규칙을 프로젝트에 복사
2. 암묵적 컨텍스트 전환 기대
3. 워크스테이션 고려 없는 설계

## Migration Checklist

- [ ] Global CLAUDE.md 정리 (철학만)
- [ ] Obsidian CLAUDE.md 생성 (문서 규칙)
- [ ] 프로젝트 CLAUDE.md 업데이트 (기술 규칙 + cross-ref)
- [ ] filesystem MCP 설정 확인
- [ ] 워크스테이션 대안 마련