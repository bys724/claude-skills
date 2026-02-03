# Custom Agents

이 디렉토리는 **처음부터 직접 만든 서브에이전트**를 관리합니다.

## 📝 서브에이전트란?

서브에이전트는 독립된 컨텍스트에서 실행되는 특수 AI 어시스턴트입니다.

### 스킬과의 차이점

| | 스킬 | 서브에이전트 |
|---|------|----------|
| 컨텍스트 | 메인 대화 공유 | 독립된 컨텍스트 |
| 상호작용 | 반복적 대화 | 실행 후 요약 반환 |
| 용도 | 대화 중 지속 참고 | 독립 작업 위임 |

### 언제 서브에이전트를 만들까?

✅ **다음과 같은 경우 서브에이전트 사용:**
- 대량의 verbose 출력이 예상되는 작업 (로그 분석, 대규모 테스트)
- 메인 대화 컨텍스트를 보호하고 싶을 때
- 독립적으로 완결되는 작업
- 도구 권한을 제한하고 싶을 때 (예: 읽기 전용 분석)
- 여러 작업을 병렬로 실행하고 싶을 때

❌ **다음과 같은 경우 스킬 사용:**
- 반복적인 대화와 개선이 필요할 때
- 여러 단계에 걸쳐 컨텍스트를 공유해야 할 때
- 메인 대화에서 지속적으로 참고할 워크플로우

## 🆕 새로운 서브에이전트 만들기

### 1. 파일 생성

```bash
mkdir agents/custom/my-agent
cd agents/custom/my-agent
```

### 2. 에이전트 정의 파일 작성

파일명: `my-agent.md` (디렉토리명과 동일하게)

```markdown
---
name: my-agent
description: 이 에이전트가 하는 일에 대한 간단한 설명
model: sonnet  # sonnet, opus, haiku, inherit
tools:
  - Read
  - Grep
  # 필요한 도구만 명시
---

# My Agent System Prompt

이 에이전트의 역할과 작업 방식을 설명합니다.

## 목표

...

## 작업 방식

...

## 출력 형식

...
```

### 3. 설치 및 사용

```bash
# 전역 설치 (모든 프로젝트에서 사용)
./scripts/install-agents.sh my-agent

# 사용
# Claude Code에서: Task tool 사용 시 자동으로 선택 가능
```

## 📖 설정 필드

### 필수 필드
- `name`: 에이전트 고유 이름
- `description`: 에이전트 설명 (언제 사용할지)

### 선택적 필드
- `model`: 사용할 모델 (`sonnet`, `opus`, `haiku`, `inherit`)
- `tools`: 접근 가능한 도구 목록 (기본값: 모두)
- `disallowedTools`: 사용 금지할 도구
- `skills`: 미리 로드할 스킬
- `permissionMode`: 권한 처리 방식

## 💡 활용 예시

### 예시 1: 코드 리뷰 전용 에이전트

```markdown
---
name: code-reviewer
description: Read-only code review with detailed analysis
model: sonnet
tools:
  - Read
  - Grep
  - Glob
---

# Code Reviewer

Perform thorough code review without making changes.

## Guidelines
- Focus on code quality, patterns, potential bugs
- Suggest improvements but don't modify files
- Provide detailed explanations
```

### 예시 2: 병렬 논문 분석 에이전트

```markdown
---
name: quick-paper-analyzer
description: Quick analysis of a single paper with key points extraction
model: haiku  # 빠르고 저렴하게
tools:
  - Read
  - WebFetch
---

# Quick Paper Analyzer

Extract key information from academic papers efficiently.

## Output Format
- Title and authors
- Main contribution (1-2 sentences)
- Methodology summary
- Key results
```

### 예시 3: 대규모 로그 분석 에이전트

```markdown
---
name: log-analyzer
description: Analyze large log files and extract error patterns
model: sonnet
tools:
  - Read
  - Grep
  - Bash
---

# Log Analyzer

Process large log files and summarize critical information.

## Process
1. Scan for ERROR/WARN patterns
2. Identify common patterns
3. Extract stack traces
4. Summarize findings
```

## 🔗 유용한 링크

- [Claude Code 서브에이전트 문서](https://code.claude.com/docs/en/sub-agents)
- [스킬 디렉토리](../../skills/custom/)
