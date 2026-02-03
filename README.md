# Claude Skills Repository

Personal repository for managing custom Claude Code skills.

## Skills Structure

이 저장소는 개인 맞춤 스킬과 공식 스킬을 함께 관리합니다.

### 개인 스킬 (Custom Skills)

#### Paper Summary
논문 읽기, 토론, 정리를 위한 스킬 (`paper_summary_guide.md`)

- 연구자 관점에서 논문을 개인화된 방식으로 요약
- 논문 간 연결점과 인용 관계를 체계적으로 관리
- Obsidian typed links를 활용한 논문 네트워크 구축

### 공식 스킬 (Official Skills)

Anthropic의 공식 스킬 저장소를 서브모듈로 포함하고 있습니다:

- **문서 처리**: pdf, xlsx, docx, pptx
- **디자인**: frontend-design, canvas-design, algorithmic-art, theme-factory
- **웹 개발**: web-artifacts-builder, webapp-testing
- **개발 도구**: mcp-builder, skill-creator
- **커뮤니케이션**: doc-coauthoring, internal-comms, brand-guidelines, slack-gif-creator

전체 스킬 목록: [공식 저장소](https://github.com/anthropics/skills)

## Structure

```
claude-skills/
├── .claude/
│   └── CLAUDE.md              # Claude Code configuration
├── skills/
│   ├── official/              # Anthropic 공식 스킬 (서브모듈)
│   │   └── skills/            # 16개 공식 스킬
│   └── paper-summary/         # 개인 맞춤 스킬
└── paper_summary_guide.md     # Legacy guide (will be migrated)
```

## Usage

### 기본 사용법

1. Navigate to this directory in Claude Code
2. Reference the skill guide as needed
3. Invoke skill workflows through conversation

### 서브모듈 관리

#### 최초 클론 시

```bash
git clone --recursive <repository-url>
```

또는 일반 클론 후:

```bash
git submodule update --init --recursive
```

#### 공식 스킬 업데이트

공식 저장소의 최신 버전을 가져오려면:

```bash
# 서브모듈을 최신 버전으로 업데이트
cd skills/official
git pull origin main
cd ../..

# 변경사항을 메인 저장소에 커밋
git add skills/official
git commit -m "Update official skills to latest version"
```

또는 루트 디렉토리에서:

```bash
git submodule update --remote skills/official
git add skills/official
git commit -m "Update official skills to latest version"
```

#### 서브모듈 상태 확인

```bash
git submodule status
```

## License

Private repository for personal use.
