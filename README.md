# Claude Skills 저장소

개인 맞춤 스킬과 Anthropic 공식 스킬을 함께 관리하는 저장소입니다.

## 📁 저장소 구조

```
claude-skills/
├── .claude/
│   ├── CLAUDE.md              # 프로젝트 설정
│   └── skills/                # 로컬 테스트 환경 (gitignored)
│       └── .gitkeep
├── custom/                    # 개인 맞춤 스킬
│   └── paper-summary/         # 논문 읽기 및 요약 스킬
│       ├── SKILL.md
│       ├── template.md
│       └── legacy-guide.md
├── vendor/
│   └── official/              # Anthropic 공식 스킬 (서브모듈)
│       └── skills/            # 16개 공식 스킬
├── scripts/                   # 관리 스크립트
│   ├── install.sh             # 맞춤 스킬 전역 설치
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

## 📚 맞춤 스킬

### Paper Summary

연구용 논문 읽기, 토론, 종합적인 노트 생성 스킬입니다.

- 연구자 관점을 반영한 개인화된 한글 요약
- Obsidian typed links를 활용한 논문 네트워크 구축
- 향후 검색을 위한 태그 기반 분류

**위치:** `custom/paper-summary/`
**설치:** `./scripts/install.sh paper-summary`

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

### 개발 워크플로우

1. **개발**: `custom/` 디렉토리에서 맞춤 스킬 개발
2. **테스트**: `.claude/skills/`에 심볼릭 링크를 만들어 로컬 테스트 (이 프로젝트에서만)
3. **배포**: `./scripts/install.sh`로 전역 설치 (모든 Claude Code 프로젝트에서 사용 가능)

### 이 프로젝트에서 테스트하기

```bash
# 로컬 테스트를 위한 심볼릭 링크 생성
cd .claude/skills
ln -s ../../custom/your-skill your-skill
```

**참고:** `.claude/skills/`는 gitignore 처리되어 있어 (`.gitkeep` 제외) 로컬 테스트 링크는 커밋되지 않습니다.

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
| `./scripts/list.sh` | 사용 가능한 스킬과 설치된 스킬 목록 표시 |
| `./scripts/install.sh` | 모든 맞춤 스킬을 `~/.claude/skills/`에 설치 |
| `./scripts/install.sh <스킬명>` | 특정 맞춤 스킬 설치 |
| `./scripts/install-official.sh <스킬명>...` | 하나 이상의 공식 스킬 설치 |
| `./scripts/uninstall.sh <스킬명>...` | `~/.claude/skills/`에서 스킬 제거 |
| `./scripts/update-official.sh` | 공식 스킬 서브모듈 업데이트 |

## 🎯 Claude Code의 스킬 탐색 방식

Claude Code는 다음 위치에서 자동으로 스킬을 탐색합니다 (우선순위 순):

1. **Enterprise** (최우선)
2. **Personal**: `~/.claude/skills/` (스크립트로 설치)
3. **Project**: `.claude/skills/` (로컬 테스트)

스크립트로 스킬을 설치하면 `~/.claude/skills/`에 심볼릭 링크가 생성되어 **모든** Claude Code 프로젝트에서 사용할 수 있습니다.

## 📖 새로운 맞춤 스킬 만들기

1. `custom/`에 새 디렉토리 생성:
```bash
mkdir custom/my-new-skill
```

2. YAML frontmatter와 지시사항이 포함된 `SKILL.md` 작성:
```markdown
---
skill-id: my-new-skill
skill-name: My New Skill
description: 이 스킬이 하는 일에 대한 간단한 설명
user-invocable: true
---

# My New Skill

Claude를 위한 지시사항...
```

3. 설치 및 테스트:
```bash
./scripts/install.sh my-new-skill
```

## 🔗 유용한 링크

- [Claude Code 스킬 문서](https://code.claude.com/docs/en/skills)
- [Anthropic 공식 스킬 저장소](https://github.com/anthropics/skills)
- [Skill Creator 스킬](vendor/official/skills/skill-creator/)

## 📝 라이센스

개인 사용을 위한 비공개 저장소입니다.
