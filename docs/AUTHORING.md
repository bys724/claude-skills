# 스킬·에이전트 작성 가이드

플러그인 `plugins/ys-research/` 안의 스킬·에이전트·출력 스타일을 만들고 고치는 규칙. 설치는 플러그인 단위(`scripts/setup-workstation.sh`) — 파일을 `~/.claude/`로 복사하지 않는다.

## 스킬 (`plugins/ys-research/skills/<name>/SKILL.md`)

호출은 슬래시 커맨드(`/<name>`) 또는 description 트리거. 현재: paper-summary · research-presentation · design-partner · code-cleaner.

### Frontmatter

```markdown
---
name: my-new-skill
description: "This skill should be used when the user says \"트리거 문구\", \"trigger phrase\", or requests X. 기능 설명."
---
```

**필수:** `name`(디렉토리명과 일치), `description`(트리거 판단의 유일한 신호 — 3인칭 `"This skill should be used when..."`).

**선택 (공식 지원):**
- `allowed-tools` — 스킬 실행 시 사전 승인할 도구 (예: `Read Edit Write Bash(rm *)`)
- `when_to_use` — description 뒤에 합산됨 (둘 합쳐 1,536자 cap). 우리는 description에 통합
- `context: fork` — 격리 실행. 대화형 스킬에는 부적합 (사용자 피드백 불가)
- `disable-model-invocation` — 모델 자동 트리거 금지 (슬래시 전용)

**쓰지 않는 필드:** `user-invocable`, `skill-id` — 공식 spec 외 잔재.

### 작성 원칙 (공식 skill-creator 비판적 흡수)

- **description은 "pushy"하게**: 모델이 트리거 여부를 판단하는 유일한 신호. *무엇을 하는지* + *언제 써야 하는지* 모두 description에 (본문 아님). 너무 차분하면 undertrigger
- **SKILL.md는 500줄 이하**: 길어지면 `references/`로 분리. 큰 reference엔 ToC
- **Why를 설명**: `ALWAYS`/`NEVER` 남발 금지. 이유를 설명하면 모델이 edge case에서도 적절히 판단
- **한국어 OK**: 우리 컨벤션. 모델은 한국어 instruction도 잘 따름

### Opus 4.8 이후 추가 원칙

4.8은 지시를 더 literal하게 해석하고, 도구 호출보다 추론을 선호하며, 기본적으로 더 간결하다 ([공식 prompting 가이드](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-4-8)). 이에 맞춰:

- **도구 호출을 명시**: "필요하면 도구 써"는 건너뛰기 쉬움. *언제·무엇을* 적을 것
- **지시 범위를 명시 (literal)**: 한 항목의 지시를 다른 항목에 자동 일반화하지 않음. "모든 섹션에", "첫 개만이 아니라 전부"처럼 적을 것
- **강제 진행보고 금지**: "N단계마다 요약" 류 스캐폴딩은 과보고 유발. 자연스럽게 체크인하므로 신뢰
- **꼭 필요한 상세 출력은 명시**: 단계별 설명·근거가 산출물의 핵심이면 "생략하지 말 것"을 명시

본격적으로 새 스킬을 만들거나 평가·최적화하려면 `/skill-creator` (Claude Code가 자동 동기화하는 공식 스킬, `anthropic-skills:skill-creator`) 활용.

## 에이전트 (`plugins/ys-research/agents/<name>.md`)

독립 컨텍스트에서 실행되는 서브에이전트. 현재: research-advisor · scout.

| | 스킬 | 서브에이전트 |
|---|---|---|
| 컨텍스트 | 메인 대화 공유 | 독립 |
| 상호작용 | 반복 대화 | 실행 후 요약 반환 |
| 용도 | 대화 중 지속 참고 | 독립 작업 위임 |

**서브에이전트가 맞는 경우:** 대량 verbose 출력(로그·대규모 테스트), 메인 컨텍스트 보호, 독립 완결 작업, 도구 권한 제한(읽기 전용 분석), 병렬 실행.
**스킬이 맞는 경우:** 반복 대화·개선, 여러 단계에 걸친 컨텍스트 공유, 대화 중 지속 참고 워크플로우.

```markdown
---
name: my-agent
description: 이 에이전트가 하는 일 + 언제 쓰는지
model: sonnet          # sonnet, opus, haiku, inherit
tools:
  - Read
  - Grep
---

# 시스템 프롬프트: 역할 · 작업 방식 · 출력 형식
```

**선택 필드:** `model`, `tools`(기본 모두), `disallowedTools`, `skills`(미리 로드), `permissionMode`, `memory`(에이전트 자체 auto memory).

## 출력 스타일 (`plugins/ys-research/output-styles/<name>.md`)

매 응답의 형식·톤을 정한다. 한 번에 하나만 활성 — 유저 기본은 `discuss`, 실험 저장소는 `.claude/settings.json`에서 `ys-research:research-dev`를 선택. `keep-coding-instructions: true`를 유지해야 코딩 능력이 그대로 남는다. 형식 규칙은 여기에 두고 CLAUDE.md에는 두지 않는다 (CLAUDE.md는 누적 로드라 저장소별로 다르게 할 수 없음).

## 변경 후 검증·반영

1. `plugins/ys-research/.claude-plugin/plugin.json`의 `version` 올리기 — 같은 버전이면 `update`가 캐시를 갱신하지 않는다 (플러그인은 `~/.claude/plugins/cache/`에 버전별로 복사됨)
2. `claude plugin validate ./plugins/ys-research` · `claude plugin validate .` (마켓플레이스)
3. `claude plugin update ys-research@ys-skills` → Claude Code 재시작

## 참고

- [Claude Code 스킬 문서](https://code.claude.com/docs/en/skills) · [서브에이전트](https://code.claude.com/docs/en/sub-agents) · [출력 스타일](https://code.claude.com/docs/en/output-styles) · [플러그인 레퍼런스](https://code.claude.com/docs/en/plugins-reference)
