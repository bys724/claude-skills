# Skills TODO

최신 Claude Code Skills 가이드 기준으로 정리한 개선/신규 작업 목록.
참고: [Skills 공식 문서](https://code.claude.com/docs/en/skills), [Best Practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)

---

## 1. 기존 스킬 개선 — 완료

### 공통: Frontmatter 표준화 ✅

4개 스킬 모두 description을 3인칭 영문 + 한국어 트리거 문구로 변경 완료.

**결정 사항:**
- `when_to_use` 필드는 공식 spec에서 지원하지만, `description`과 합산 1,536자 제한을 공유하므로 `description` 하나에 통합하는 방식 채택
- `user-invocable` 등 비표준 필드 사용하지 않음

### 1.1 paper-summary ✅

- [x] Frontmatter: description을 3인칭 + 트리거 문구로 변경
- [x] Vocabulary Quiz를 Phase 0으로 통합 (독립 스킬 대신 병합 — 어휘 소스가 논문 읽기에서 나오므로)
- [x] "논문 제목 개선" → `zotero-enrichment.md` §3에 이미지 폴더 rename 절차 추가로 해결
- [x] vault 경로 하드코딩(macOS) → 전역 CLAUDE.md 참조 방식으로 수정

### 1.2 design-partner ✅

- [x] Frontmatter: description을 3인칭 + 트리거 문구로 변경
- [x] reference 파일 5개를 `references/` 디렉토리로 이동, SKILL.md 내 경로 전부 갱신

**미완료 (우선순위 낮음):**
- [ ] CLAUDE.md에서 제거한 내용 통합:
  - "AI 이미지 생성 프롬프트 워크플로우" (프로젝트 폴더 구조, notes.md 관리) → `references/vault-image-workflow.md`
  - "영상/시퀀스 작업 워크플로우" (이미지 버전 관리) → 83줄의 기존 Vault 정책 언급 부분과 통합
- [ ] 스타일 교육 섹션(136-155줄)을 reference로 이동 가능 (body 179줄이라 급하지 않음)

### 1.3 code-cleaner ✅

- [x] Frontmatter: description을 3인칭 + 트리거 문구로 변경
- [x] `allowed-tools` 필드 추가: Read, Edit, Write, Glob, Grep, Bash(rm/mv/mkdir/ls/git)

### 1.4 research-presentation ✅

- [x] Frontmatter: description을 3인칭 + 트리거 문구로 변경
- [x] themes.md reference 파일 존재 확인 (`references/themes.md` 정상)

**미완료 (우선순위 낮음):**
- [ ] Example 섹션(123-148줄)을 references/examples.md로 이동 가능

---

## 2. 신규 스킬 — 해소됨

### 2.1 vocabulary-quiz → paper-summary Phase 0으로 통합 ✅

독립 스킬 대신 paper-summary Phase 0으로 병합. 이유: 어휘 소스가 논문 읽기(Phase 2)에서 발생하고, Phase 3 §7에서 등록되며, 다음 세션 Phase 0에서 복습하는 하나의 학습 사이클.

### 2.2 agent-report-rules → 불필요 ✅

Vault CLAUDE.md에 "Agent Report Output Rules" 섹션이 이미 존재 (기본 규칙 포함). 에이전트가 vault 작업 시 자연스럽게 참조하므로 별도 파일 불필요.

### 2.3 paper-title-improvement → zotero-enrichment.md에 통합 ✅

별도 reference 파일 대신 `zotero-enrichment.md` §3 "파일 이름 변경" 섹션에 이미지 폴더 rename 절차를 추가하여 해결.

---

## 3. Progressive Disclosure 점검 ✅

| 스킬 | SKILL.md 줄수 | references/ 수 | 상태 |
|------|-------------|---------------|------|
| paper-summary | ~109 | 1 (zotero-enrichment.md) | ✅ 양호 |
| design-partner | ~179 | 5 (references/로 이동 완료) | ✅ 양호 |
| code-cleaner | ~59 | 0 | ✅ 간결 |
| research-presentation | ~161 | 1 (themes.md) | ✅ 양호 |

---

## 4. 기타 — 해소됨

- [x] keybindings-help: Claude Code 빌트인 기능으로 확인. 커스텀 스킬 아님
- [x] `allowed-tools` 필드 활용: code-cleaner에 적용 완료
- [x] `context: fork` 검토: 현재 4개 스킬 모두 대화형(Phase별 사용자 피드백 필요)이라 부적합
- [x] `when_to_use` 검토: 공식 지원 필드이나, description과 1,536자 cap 공유하므로 description 통합 방식 유지

**미검토:**
- [ ] `!command` 동적 주입 활용 가능한 곳 검토
- [ ] `disable-model-invocation` 활용 가능한 곳 검토
