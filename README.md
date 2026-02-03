# Claude Extensions 저장소

개인 맞춤 **스킬과 에이전트**를 Anthropic 공식 스킬과 함께 관리하는 저장소입니다.

## 🎯 스킬 vs 에이전트

| | 스킬 | 에이전트 |
|---|------|----------|
| **컨텍스트** | 메인 대화 공유 | 독립된 컨텍스트 |
| **상호작용** | 반복적 대화 가능 | 실행 후 요약 반환 |
| **용도** | 대화 중 지속 참고 | 독립 작업 위임 |
| **출력** | 대화 흐름 속 통합 | 고립된 결과 요약 |
| **예시** | 문서 작성 가이드, 코딩 컨벤션 | 로그 분석, 병렬 테스트 실행 |

## 📁 저장소 구조

```
claude-extensions/
├── .claude/
│   ├── CLAUDE.md              # 프로젝트 설정
│   └── skills/                # 로컬 테스트 환경 (gitignored)
├── custom/                    # 순수 커스텀 스킬
│   ├── README.md
│   └── paper-summary/
├── modified/                  # 수정된 공식 스킬
│   └── README.md
├── vendor/official/           # 공식 스킬 (서브모듈, 읽기 전용)
│   └── skills/
├── agents/                    # 에이전트 (독립 컨텍스트에서 실행)
│   ├── custom/                # 순수 커스텀 에이전트
│   │   └── README.md
│   └── modified/              # 수정된 에이전트 (향후 공식용)
│       └── README.md
├── scripts/                   # 관리 스크립트
│   ├── install.sh             # 스킬 설치 → ~/.claude/skills/
│   ├── install-official.sh    # 공식 스킬 설치
│   ├── install-agents.sh      # 에이전트 설치 → ~/.claude/agents/
│   ├── uninstall.sh           # 스킬 제거
│   ├── uninstall-agents.sh    # 에이전트 제거
│   ├── list.sh                # 스킬 목록
│   ├── list-agents.sh         # 에이전트 목록
│   └── update-official.sh     # 공식 스킬 업데이트
└── README.md
```

## 🚀 시작하기

### 1. 초기 설정

서브모듈과 함께 저장소 클론:

```bash
git clone --recursive <repository-url>
cd claude-skills
```

이미 클론한 경우:

```bash
git submodule update --init --recursive
```

### 2. 스킬 설치

**모든 맞춤 스킬 설치:**
```bash
./scripts/install.sh
```

**특정 맞춤 스킬만 설치:**
```bash
./scripts/install.sh paper-summary
```

**공식 스킬 설치 (필요한 것만 선택):**
```bash
./scripts/install-official.sh pdf xlsx pptx
```

**사용 가능한 스킬과 설치된 스킬 확인:**
```bash
./scripts/list.sh
```

### 3. 스킬 제거

```bash
./scripts/uninstall.sh paper-summary pdf
```

### 4. 에이전트 설치

**모든 맞춤 에이전트 설치:**
```bash
./scripts/install-agents.sh
```

**특정 에이전트만 설치:**
```bash
./scripts/install-agents.sh my-agent
```

**에이전트 목록 확인:**
```bash
./scripts/list-agents.sh
```

**에이전트 제거:**
```bash
./scripts/uninstall-agents.sh my-agent
```

## 📚 스킬 분류

### 🎨 순수 커스텀 스킬 (`custom/`)

처음부터 직접 제작한 나만의 스킬입니다.

#### Paper Summary
논문 읽기, 토론, 종합적인 노트 생성 스킬

- 연구자 관점을 반영한 개인화된 한글 요약
- Obsidian typed links를 활용한 논문 네트워크 구축
- 향후 검색을 위한 태그 기반 분류

**설치:** `./scripts/install.sh paper-summary`

#### Research Presentation
연구/논문 발표 자료 (PPT) 제작 스킬

- 대화하며 반복적으로 개선
- Obsidian vault의 논문/개념 노트 자동 통합
- 학술 발표에 최적화된 템플릿
- 공식 pptx 스킬 활용

**설치:** `./scripts/install.sh research-presentation`

### 🔧 수정된 공식 스킬 (`modified/`)

공식 스킬을 기반으로 개인적인 필요에 맞게 수정한 버전입니다.

현재는 없음. 공식 스킬을 수정하려면 `modified/README.md`를 참고하세요.

**수정 방법:**
```bash
# 공식 스킬 복사
cp -r vendor/official/skills/pdf modified/pdf

# 수정 후 설치
./scripts/install.sh pdf  # modified/pdf가 우선 설치됨
```

## 🏢 공식 스킬

이 저장소는 Anthropic의 공식 스킬을 서브모듈로 포함합니다:

- **문서 처리**: pdf, xlsx, docx, pptx
- **디자인**: frontend-design, canvas-design, algorithmic-art, theme-factory
- **웹 개발**: web-artifacts-builder, webapp-testing
- **개발 도구**: mcp-builder, skill-creator
- **커뮤니케이션**: doc-coauthoring, internal-comms, brand-guidelines, slack-gif-creator

**사용 가능한 공식 스킬 전체 보기:**
```bash
ls vendor/official/skills/
```

**특정 공식 스킬 설치:**
```bash
./scripts/install-official.sh pdf xlsx
```

## 🤖 에이전트 분류

### 💻 순수 커스텀 에이전트 (`agents/custom/`)

독립적인 컨텍스트에서 실행되는 특수 작업용 에이전트입니다.

#### Research Consultant
종합 연구 컨설팅 에이전트

- Obsidian vault 논문/아이디어 분석
- 최신 연구 동향 조사 (WebSearch)
- 연구 갭 식별 및 기회 발견
- 진로 및 연구 방향 조언
- 종합 컨설팅 보고서 생성

**사용법:**
```
"research-consultant 에이전트로 내 연구 방향 분석해줘"
```

**설치:** `./scripts/install-agents.sh research-consultant`

---

**추가 에이전트 생성:**
```bash
mkdir agents/custom/my-agent
cd agents/custom/my-agent
# my-agent.md 작성
./scripts/install-agents.sh my-agent
```

### 🔧 수정된 에이전트 (`agents/modified/`)

향후 공식 에이전트가 제공될 경우를 대비한 디렉토리입니다.

현재는 없음. `agents/modified/README.md` 참고.

## 🔄 워크플로우

### 1. 순수 커스텀 스킬 개발

```bash
# 1. 새 스킬 생성
mkdir custom/my-skill
cd custom/my-skill

# 2. SKILL.md 작성
# (custom/README.md 참고)

# 3. 로컬 테스트 (이 프로젝트에서만)
cd ../../.claude/skills
ln -s ../../custom/my-skill my-skill

# 4. 전역 설치 (모든 Claude Code 프로젝트)
./scripts/install.sh my-skill
```

### 2. 공식 스킬 수정

```bash
# 1. 공식 스킬 복사
cp -r vendor/official/skills/pdf modified/pdf

# 2. 수정 작업
cd modified/pdf
# SKILL.md 등을 수정

# 3. 출처 기록 (중요!)
# SKILL.md 상단에 주석 추가:
# <!--
# Based on: vendor/official/skills/pdf
# Modified: 2024-02-03
# Changes: 추가한 기능이나 변경 내용
# -->

# 4. 전역 설치
./scripts/install.sh pdf  # modified/pdf가 우선 설치됨
```

### 3. 공식 스킬 그대로 사용

```bash
# 필요한 공식 스킬만 선택 설치
./scripts/install-official.sh xlsx pptx docx
```

### 로컬 테스트 환경

`.claude/skills/`에 심볼릭 링크를 만들면 이 프로젝트에서만 스킬을 테스트할 수 있습니다.

```bash
cd .claude/skills
ln -s ../../custom/my-skill my-skill
```

**참고:** `.claude/skills/`는 gitignore 처리되어 로컬 테스트 링크는 커밋되지 않습니다.

### 공식 스킬 업데이트

새 버전의 공식 스킬이 출시되면:

```bash
# 서브모듈을 최신 버전으로 업데이트
./scripts/update-official.sh

# 변경사항 확인
git status

# 업데이트 커밋
git add vendor/official
git commit -m "Update official skills to latest version"
```

## 📋 스킬 관리 명령어

| 명령어 | 설명 |
|--------|------|
| `./scripts/list.sh` | 모든 스킬 목록 표시 (custom, modified, official) |
| `./scripts/install.sh` | 모든 custom/modified 스킬을 `~/.claude/skills/`에 설치 |
| `./scripts/install.sh <스킬명>` | 특정 스킬 설치 (modified 우선, 없으면 custom) |
| `./scripts/install-official.sh <스킬명>...` | 공식 스킬 설치 (원본 그대로) |
| `./scripts/uninstall.sh <스킬명>...` | 설치된 스킬 제거 |
| `./scripts/update-official.sh` | 공식 스킬 서브모듈 업데이트 |

### 스킬 우선순위

같은 이름의 스킬이 여러 곳에 있을 때:
- `./scripts/install.sh`: **modified/** > custom/
- `./scripts/install-official.sh`: vendor/official/ (항상)

## 📋 에이전트 관리 명령어

| 명령어 | 설명 |
|--------|------|
| `./scripts/list-agents.sh` | 모든 에이전트 목록 표시 (custom, modified) |
| `./scripts/install-agents.sh` | 모든 custom/modified 에이전트를 `~/.claude/agents/`에 설치 |
| `./scripts/install-agents.sh <에이전트명>` | 특정 에이전트 설치 (modified 우선, 없으면 custom) |
| `./scripts/uninstall-agents.sh <에이전트명>...` | 설치된 에이전트 제거 |

### 에이전트 우선순위

스킬과 동일: **modified/** > custom/

## 🎯 Claude Code의 스킬/에이전트 탐색 방식

### 스킬 탐색

Claude Code는 다음 위치에서 자동으로 스킬을 탐색합니다 (우선순위 순):

1. **Enterprise** (최우선)
2. **Personal**: `~/.claude/skills/` (스크립트로 설치)
3. **Project**: `.claude/skills/` (로컬 테스트)

### 에이전트 탐색

Claude Code는 다음 위치에서 에이전트를 탐색합니다 (우선순위 순):

1. **CLI flag** (`--agents`): 세션 전용, 최우선
2. **Project**: `.claude/agents/` (프로젝트별)
3. **Personal**: `~/.claude/agents/` (스크립트로 설치)
4. **Plugin**: 플러그인 디렉토리

스크립트로 설치하면 심볼릭 링크가 생성되어 **모든** Claude Code 프로젝트에서 사용할 수 있습니다.

## 📖 스킬 개발 가이드

### 순수 커스텀 스킬 만들기

자세한 내용은 `custom/README.md`를 참고하세요.

```bash
mkdir custom/my-new-skill
cd custom/my-new-skill
# SKILL.md 작성 후
cd ../..
./scripts/install.sh my-new-skill
```

### 공식 스킬 수정하기

자세한 내용은 `modified/README.md`를 참고하세요.

```bash
# 1. 공식 스킬 복사
cp -r vendor/official/skills/pdf modified/pdf

# 2. 수정 작업 및 출처 기록

# 3. 설치
./scripts/install.sh pdf  # modified 버전이 우선 설치됨
```

## 🔗 유용한 링크

- [Claude Code 스킬 문서](https://code.claude.com/docs/en/skills)
- [Anthropic 공식 스킬 저장소](https://github.com/anthropics/skills)
- [Skill Creator 스킬](vendor/official/skills/skill-creator/)

## 📝 라이센스

개인 사용을 위한 비공개 저장소입니다.
