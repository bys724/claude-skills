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
description: 트리거 메커니즘. 무엇을 하고 언제 호출되는지 모두 여기에 명시.
---

# My New Skill

상세 지시사항...
```

frontmatter는 `name`·`description`만 필수. `user-invocable`·`skill-id` 같은 비표준 필드는 쓰지 말 것 (공식 spec 외 잔재).

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

본격적으로 새 스킬을 만들거나 기존 스킬을 평가·최적화하려면 공식 스킬 활용:

- `/skill-creator` — 작성·테스트·description 최적화 워크플로우 (eval 기반)
- 공식 가이드: [vendor/official/skills/skill-creator/SKILL.md](../vendor/official/skills/skill-creator/SKILL.md)

## 참고

- [Claude Code 스킬 문서](https://code.claude.com/docs/en/skills)
- [공식 skill-creator](../vendor/official/skills/skill-creator/) · [공식 mcp-builder](../vendor/official/skills/mcp-builder/)
