# Claude Skills 저장소

개인 맞춤 스킬과 Anthropic 공식 스킬을 함께 관리하는 저장소입니다.

## 📁 저장소 구조

```
claude-skills/
├── .claude/
│   ├── CLAUDE.md              # 프로젝트 설정
│   └── skills/                # 로컬 테스트 환경 (gitignored)
│       └── .gitkeep
├── custom/                    # 순수 커스텀 스킬 (처음부터 직접 제작)
│   ├── README.md              # 커스텀 스킬 가이드
│   └── paper-summary/         # 논문 읽기 및 요약 스킬
│       ├── SKILL.md
│       ├── template.md
│       └── legacy-guide.md
├── modified/                  # 수정된 공식 스킬 (공식 스킬 기반 수정)
│   └── README.md              # 수정 가이드
│       # (공식 스킬을 복사하여 수정한 버전들)
├── vendor/
│   └── official/              # Anthropic 공식 스킬 (서브모듈, 읽기 전용)
│       └── skills/            # 16개 공식 스킬
├── scripts/                   # 관리 스크립트
│   ├── install.sh             # 커스텀/수정 스킬 전역 설치
│   ├── install-official.sh    # 공식 스킬 전역 설치
│   ├── uninstall.sh           # 스킬 제거
│   ├── update-official.sh     # 공식 스킬 업데이트
│   └── list.sh                # 사용 가능한 스킬 목록 보기
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

## 📚 스킬 분류

### 🎨 순수 커스텀 스킬 (`custom/`)

처음부터 직접 제작한 나만의 스킬입니다.

#### Paper Summary
논문 읽기, 토론, 종합적인 노트 생성 스킬

- 연구자 관점을 반영한 개인화된 한글 요약
- Obsidian typed links를 활용한 논문 네트워크 구축
- 향후 검색을 위한 태그 기반 분류

**설치:** `./scripts/install.sh paper-summary`

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

## 🎯 Claude Code의 스킬 탐색 방식

Claude Code는 다음 위치에서 자동으로 스킬을 탐색합니다 (우선순위 순):

1. **Enterprise** (최우선)
2. **Personal**: `~/.claude/skills/` (스크립트로 설치)
3. **Project**: `.claude/skills/` (로컬 테스트)

스크립트로 스킬을 설치하면 `~/.claude/skills/`에 심볼릭 링크가 생성되어 **모든** Claude Code 프로젝트에서 사용할 수 있습니다.

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
