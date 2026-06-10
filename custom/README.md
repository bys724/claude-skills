# Custom Skills

직접 만든 스킬을 관리하는 디렉토리. 호출은 슬래시 커맨드(`/<name>`) 또는 description 트리거로 발생.

## 현재 커스텀 스킬

- **paper-summary**: 논문 읽기 워크플로우 (arxiv → 대화 → Zotero 보강)
- **research-presentation**: 연구 발표 자료 제작 (Obsidian 노트 통합)
- **design-partner**: AI 이미지 생성 코칭 (Midjourney + Nano Banana)
- **code-cleaner**: 저장소 정리 (코드·구조·문서·주석)

## 새 스킬 만들기

### 1. 디렉토리 생성

```bash
mkdir custom/my-new-skill
```

### 2. SKILL.md 작성

```markdown
---
name: my-new-skill
description: "This skill should be used when the user says \"트리거 문구\", \"trigger phrase\", or requests X. 기능 설명."
---

# My New Skill

상세 지시사항...
```

### Frontmatter 필드

**필수:**
- `name` — 스킬 이름 (디렉토리명과 일치)
- `description` — 트리거 판단의 핵심 신호. 3인칭 `"This skill should be used when..."` 형태로 작성

**선택 (공식 지원):**
- `allowed-tools` — 스킬 실행 시 사전 승인할 도구 (예: `Read Edit Write Bash(rm *)`)
- `when_to_use` — description 뒤에 합산됨 (둘 합쳐 1,536자 cap). 우리는 description에 통합하는 방식 사용
- `context: fork` — 격리 실행. 대화형 스킬에는 부적합 (사용자 피드백 불가)
- `disable-model-invocation` — 모델이 자동 트리거하지 못하게 (슬래시 전용)

**쓰지 않는 필드:**
- `user-invocable`, `skill-id` — 공식 spec 외 잔재

### 3. 설치 (심링크)

```bash
ln -s ~/Documents/claude-skills/custom/my-new-skill ~/.claude/skills/my-new-skill
```

저장소 push 후 다른 워크스테이션에서도 동일 명령으로 install (SETUP_GUIDE 4번 참고).

## 작성 원칙 (공식 skill-creator 비판적 흡수)

- **description은 "pushy"하게**: 모델이 트리거 여부를 판단하는 유일한 신호. *무엇을 하는지* + *언제 써야 하는지* 모두 description에 (본문 아님). 너무 차분하면 undertrigger
- **SKILL.md는 500줄 이하**: 길어지면 reference 파일로 분리 (`reference.md`, `examples.md` 등). 큰 reference엔 ToC
- **Why를 설명**: `ALWAYS`/`NEVER` 같은 강제어 남발 금지. 이유를 설명하면 모델이 edge case에서도 적절히 판단 (User CLAUDE.md 코딩 원칙과 동일)
- **한국어 OK**: 우리 컨벤션. 모델은 한국어 instruction도 잘 따름

### Opus 4.8 이후 추가 원칙

4.8은 지시를 더 literal하게 해석하고, 도구 호출보다 추론을 선호하며, 기본적으로 더 간결하다 ([공식 prompting 가이드](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-4-8)). 이에 맞춰:

- **도구 호출을 명시**: "필요하면 도구 써"는 4.8에서 건너뛰기 쉬움. *언제·무엇을* 적을 것 (예: "이 단계에서 `read_paper`로 전문 파악"). 도구 의존 스킬일수록 중요
- **지시 범위를 명시 (literal)**: 4.8은 한 항목의 지시를 다른 항목에 자동 일반화하지 않음. "모든 섹션에", "첫 개만이 아니라 전부"처럼 적용 범위를 적을 것
- **강제 진행보고 금지**: "N단계마다 요약" 류 스캐폴딩은 4.8에서 과보고를 유발. 4.8은 자연스럽게 체크인하므로 신뢰
- **꼭 필요한 상세 출력은 명시**: 4.8은 간결함을 위해 부연 설명을 생략하기 쉬움. 단계별 설명·근거가 산출물의 핵심이면 "생략하지 말 것"을 명시

본격적으로 새 스킬을 만들거나 기존 스킬을 평가·최적화하려면 공식 스킬 활용:

- `/skill-creator` — 작성·테스트·description 최적화 워크플로우 (eval 기반)
- 공식 가이드: [vendor/official/skills/skill-creator/SKILL.md](../vendor/official/skills/skill-creator/SKILL.md)

## 참고

- [Claude Code 스킬 문서](https://code.claude.com/docs/en/skills)
- [공식 skill-creator](../vendor/official/skills/skill-creator/) · [공식 mcp-builder](../vendor/official/skills/mcp-builder/)
