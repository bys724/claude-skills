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

**필수 (우리 컨벤션):** `name`(디렉토리명과 일치), `description`(트리거 판단의 유일한 신호). 공식 spec상 둘 다 선택이지만 우리는 항상 쓴다. 기존 스킬의 3인칭 `"This skill should be used when..."` 형식은 유지해도 되나 공식 문서가 권하는 형식은 아니다 — 새 스킬은 **핵심 용도를 맨 앞에** 직접 서술 (1,536자에서 잘리므로).

**선택 (공식 지원):**
- `allowed-tools` — 스킬 실행 시 사전 승인할 도구 (예: `Read Edit Write Bash(rm *)`)
- `when_to_use` — description 뒤에 합산됨 (둘 합쳐 1,536자 cap). 우리는 description에 통합
- `context: fork` — 격리 실행. 대화형 스킬에는 부적합 (사용자 피드백 불가)
- `disable-model-invocation` — 모델 자동 트리거 금지 (슬래시 전용)
- `user-invocable: false` — 슬래시 메뉴에서 숨김 (모델 전용)
- `argument-hint` · `model` · `effort` · `paths` · `shell` 등 — 전체 목록은 [스킬 문서](https://code.claude.com/docs/en/skills)

**쓰지 않는 필드:** `skill-id` — 공식 spec 외 잔재. 모르는 필드는 오류 없이 무시되므로 오타에 주의.

### 작성 원칙 (공식 skill-creator 비판적 흡수)

- **description은 "pushy"하게**: 모델이 트리거 여부를 판단하는 유일한 신호. *무엇을 하는지* + *언제 써야 하는지* 모두 description에 (본문 아님). 너무 차분하면 undertrigger
- **SKILL.md는 500줄 이하**: 길어지면 `references/`로 분리. 큰 reference엔 ToC
- **Why를 설명**: `ALWAYS`/`NEVER`·`CRITICAL` 남발 금지. 이유를 설명하면 모델이 edge case에서도 적절히 판단. 금지문보다 "대신 무엇을 하라"가 잘 먹힌다
- **한국어 OK**: 우리 컨벤션. 모델은 한국어 instruction도 잘 따름

### Claude 5 계열 (Opus 5 / 5.5) 기준 원칙

[공식 prompting 가이드](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices) · [Opus 5](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5) · [Opus 5.5](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/prompting-claude-opus-5-5) (2026-11 확인). 4.8용 지시는 대체로 그대로 동작하지만, 5 계열은 응답이 길고, 진행 상황을 자주 말하고, 요청 밖으로 범위를 넓히고, 시키지 않아도 자기 검증·서브에이전트 위임을 한다. 그래서:

- **지시 범위는 계속 명시 (literal)**: 한 항목의 지시를 다른 항목에 자동 일반화하지 않는다. "모든 섹션에", "첫 개만이 아니라 전부"처럼 적을 것. 반대로 "고위험만 보고" 같은 필터는 문자 그대로 따르므로, 리뷰류는 전부 보고시키고 거르는 건 따로
- **범위 확장 억제**: 좁은 스킬엔 "요청된 것을 요청된 범위에서만" 한 줄. 4.8 시절의 "도구를 언제 쓸지 명시"는 유지하되 "애매하면 도구 써" 같은 일괄 지시는 과호출 유발
- **검증 단계를 덧붙이지 말 것**: "마지막에 다시 확인", "서브에이전트로 검증" 류는 비용만 늘린다 (5 계열은 스스로 검증)
- **진행보고 스캐폴딩 금지**: "N단계마다 요약"은 쓰지 않는다. 5 계열은 이미 자주 말한다 — 필요하면 오히려 줄이라고 적을 것
- **길이는 명시**: 짧은 산출물이 핵심이면 "간결하게"를 명시 (effort를 낮춰도 보이는 응답은 잘 안 짧아짐). 반대로 단계별 설명·근거가 산출물의 핵심이면 "생략하지 말 것"을 명시
- **추론을 응답에 쓰라고 요구하지 말 것**: "생각 과정을 써라" 대신 "답의 짧은 설명"이나 "한 일의 요약"을 요구

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

**선택 필드:** `model`(`sonnet`·`opus`·`haiku`·`fable`·`inherit`·전체 ID), `tools`(기본 모두), `disallowedTools`, `skills`(미리 로드), `memory`(에이전트 자체 auto memory), `effort`, `maxTurns`, `color` 등.
**플러그인 에이전트 제약:** `permissionMode`·`hooks`·`mcpServers`·`initialPrompt`는 플러그인으로 배포하면 **무시된다**. MCP 도구(예: `mcp__apify__*`)는 `tools`에 이름만 적고 서버는 유저 스코프에 따로 등록.

## 출력 스타일 (`plugins/ys-research/output-styles/<name>.md`)

매 응답의 형식·톤을 정한다. 한 번에 하나만 활성 — 유저 기본은 `discuss`, 실험 저장소는 `.claude/settings.json`에서 `ys-research:research-dev`를 선택. `keep-coding-instructions: true`를 유지해야 코딩 능력이 그대로 남는다. 형식 규칙은 여기에 두고 CLAUDE.md에는 두지 않는다 (CLAUDE.md는 누적 로드라 저장소별로 다르게 할 수 없음).

## Hook (`plugins/ys-research/hooks/`)

플러그인이 켜진 모든 머신·저장소에서 매 턴 실행되는 결정론적 스크립트. output style·CLAUDE.md의 상시 지시가 긴 세션에서 흐려지는 것과 달리 hook은 턴마다 다시 주입되므로, "매 요청마다 반드시"인 행동은 여기에 둔다. 현재: `english_coach.py`(UserPromptSubmit — 프롬프트 언어 판정 → 그 턴의 지시문 주입).

- `hooks/hooks.json`은 최상위 `"hooks"` 래퍼 + settings.json의 `hooks` 키와 같은 형식. 경로는 `"${CLAUDE_PLUGIN_ROOT}"` (중괄호·따옴표 — 공식 표기). 상태 파일은 `${CLAUDE_PLUGIN_DATA}`에 (ROOT는 버전마다 바뀜)
- Windows에서 hook은 Git Bash로 돈다 (없으면 PowerShell — 필요하면 hook에 `"shell"` 지정)
- 해석기는 `bash "${CLAUDE_PLUGIN_ROOT}/hooks/python.sh" <script>`로 고른다. `command -v python3`만으론 Windows Store 별칭(찾아지지만 실행 안 됨)을 집는다 (2026-11 실측). 끝에 `|| true` — Python이 없는 머신에서 매 턴 hook 오류가 뜨지 않게
- **입출력 인코딩을 locale에 맡기지 말 것** — stdin은 `sys.stdin.buffer.read().decode("utf-8")`, 출력 JSON은 `ensure_ascii=True`(기본값). Windows cp949·C locale에서 한글·이모지로 hook이 죽는다 (실측). `reconfigure()`는 3.7+ 라 클러스터 python3 3.6에선 무효
- 주입 지시문은 스크립트 안에 둔다(단일 정본). 범위를 명시할 것 — "이 블록에만 적용, 다른 영어 교정 요청엔 적용 안 함"처럼. 모델은 한 과제의 지시를 다른 과제에 자동 일반화하지 않지만, 반대로 새어 나가는 것도 막아야 한다
- 테스트는 가짜 stdin으로: `echo '{"prompt":"..."}' | python hooks/english_coach.py`. hook 변경은 재시작 후에만 반영된다
- 끄기: `ENGLISH_COACH=off` (settings `env`)

## Eval (`plugins/ys-research/evals/`)

`claude plugin eval`로 트리거·hook 회귀 테스트. 케이스 = 디렉토리 하나 (`prompt.md` frontmatter + 프롬프트, `graders/*.md` 채점기 하나씩). 플러그인 있는 갈래 vs 없는 갈래를 비교해 Δ로 효과를 본다. 형식: [공식 문서](https://code.claude.com/docs/en/plugin-evals).

- 현재 케이스: 스킬 4종 트리거 · code-cleaner 비트리거(평상시 수정) · 영어 코치 모드 1/2/건너뜀
- 채점기는 `tool_used`(Skill 호출)·`regex`(응답 본문)만 쓴다 — 추가 비용 0. `llm` 채점기는 run마다 판정 호출 3회가 붙는다
- 매 run이 실제 모델 호출 (케이스 × runs × 2갈래). 전체 1회 ≈ $1.6 (2026-11 실측)
- frontmatter 값에 `: `가 들어가면 따옴표로 감쌀 것 (YAML 파싱 실패 → 케이스 로드 실패)
- 샌드박스는 HOME을 임시 폴더로 바꾼다 — hook이 HOME 기준 경로에 기대면 eval에서만 조용히 실패한다 (python.sh가 `uv python find`를 쓰는 이유)

```bash
claude plugin eval ./plugins/ys-research --runs 1 --max-cost-usd 3 --trust-plugin --no-publish   # 전체
claude plugin eval ./plugins/ys-research --tag hook --runs 1 --ablation none --keep-temp          # 디버깅
```

스킬 description·hook을 고친 뒤엔 관련 태그(`trigger`·`negative`·`hook`)만이라도 돌린다. `results/`는 gitignore.

## 변경 후 검증·반영

1. `plugins/ys-research/.claude-plugin/plugin.json`의 `version` 올리기 — 같은 버전이면 `update`가 캐시를 갱신하지 않는다. 로컬 디렉토리 마켓플레이스여도 `version`이 있으면 `~/.claude/plugins/cache/ys-skills/ys-research/<version>/`에 복사돼 거기서 로드된다 (2026-11-15 Windows 실측: `installed_plugins.json`의 `installPath`)
2. `claude plugin validate ./plugins/ys-research` · `claude plugin validate .` (마켓플레이스)
3. `claude plugin update ys-research@ys-skills` → Claude Code 재시작

## 참고

- [Claude Code 스킬 문서](https://code.claude.com/docs/en/skills) · [서브에이전트](https://code.claude.com/docs/en/sub-agents) · [출력 스타일](https://code.claude.com/docs/en/output-styles) · [플러그인 레퍼런스](https://code.claude.com/docs/en/plugins-reference) · [hooks](https://code.claude.com/docs/en/hooks)
