# Claude Extensions

개인 맞춤 **스킬**과 **에이전트**를 관리하는 저장소입니다.

## 📋 보유 스킬 & 에이전트 한눈에 보기

### 🎨 내 스킬 (Custom Skills)

| 스킬 | 설명 | 사용법 |
|------|------|--------|
| **paper-summary** | 논문 읽기 및 토론, 종합 노트 생성 | 대화하며 논문 이해 → 개인화된 한글 요약 |
| **research-presentation** | 연구/논문 발표 자료 (PPT) 제작 | Vault 활용, 대화하며 슬라이드 제작 |

### 🤖 내 에이전트 (Custom Agents)

| 에이전트 | 설명 | 사용법 |
|----------|------|--------|
| **research-consultant** | 연구 방향 종합 분석 & 컨설팅 보고서 | Vault + 최신 동향 분석 → RSS 2026 전략 제시 |

### 📦 공식 스킬 (Official Skills - 선택 설치)

Anthropic 제공, 필요한 것만 골라 설치:

| 카테고리 | 스킬 |
|----------|------|
| **문서** | pdf, xlsx, docx, pptx |
| **디자인** | frontend-design, canvas-design, algorithmic-art, theme-factory |
| **웹** | web-artifacts-builder, webapp-testing |
| **개발** | mcp-builder, skill-creator |
| **커뮤니케이션** | doc-coauthoring, internal-comms, brand-guidelines, slack-gif-creator |

---

## 🚀 빠른 시작

### 의존성

#### Obsidian Vault (선택)

일부 스킬/에이전트는 Obsidian Vault를 필요로 합니다:

**Vault 필요:**
- paper-summary
- research-presentation
- research-advisor (에이전트)
- scout (에이전트, vault 출력 옵션)

**Vault 없는 워크스테이션:** 위 스킬/에이전트는 설치하지 않기. 코딩/대화 관련 설정(`~/.claude/CLAUDE.md`)만 적용됨.

Vault 경로 설정: `~/.claude/CLAUDE.md`의 "주요 경로" 참조

### 초기 설정

```bash
# 저장소 클론
git clone --recursive <repository-url>
cd claude-skills

# 또는 이미 클론했다면
git submodule update --init --recursive
```

### 스킬 설치

```bash
# 내 스킬 전체 설치
./scripts/install.sh

# 특정 스킬만
./scripts/install.sh paper-summary

# 공식 스킬 설치 (예: PDF, Excel, PowerPoint)
./scripts/install-official.sh pdf xlsx pptx

# 설치된 스킬 확인
./scripts/list.sh
```

### 에이전트 설치

```bash
# 내 에이전트 설치
./scripts/install-agents.sh research-consultant

# 설치된 에이전트 확인
./scripts/list-agents.sh
```

### 사용 예시

**스킬 (대화형):**
```
"research-presentation 스킬로 DINO 논문 발표 자료 만들어줘"
→ 대화하며 슬라이드 구성, 반복 개선, PPT 파일 생성
```

**에이전트 (독립 실행):**
```
"research-consultant 에이전트로 내 연구 분석하고 RSS 2026 전략 보고서 작성해줘"
→ 독립 실행 (30-60분) → 종합 보고서 반환
```

---

## 🎯 스킬 vs 에이전트

### 스킬 (Skills)
- **컨텍스트**: 메인 대화 공유
- **상호작용**: 반복적 대화, 단계별 개선
- **용도**: 대화하며 함께 작업

**예:** 논문 읽기 (paper-summary), 발표 자료 제작 (research-presentation)

### 에이전트 (Agents)
- **컨텍스트**: 독립 실행, 별도 컨텍스트
- **상호작용**: 실행 후 결과만 반환
- **용도**: 대량 작업 위임, 메인 대화 보호

**예:** 연구 종합 분석 (research-consultant)

---

## 📋 관리 명령어

### 스킬 관리

| 명령어 | 설명 |
|--------|------|
| `./scripts/list.sh` | 스킬 목록 (custom, official, installed) |
| `./scripts/install.sh` | 모든 custom 스킬 설치 |
| `./scripts/install.sh <스킬명>` | 특정 스킬 설치 |
| `./scripts/install-official.sh <스킬명>...` | 공식 스킬 설치 |
| `./scripts/uninstall.sh <스킬명>...` | 스킬 제거 |
| `./scripts/update-official.sh` | 공식 스킬 업데이트 |

### 에이전트 관리

| 명령어 | 설명 |
|--------|------|
| `./scripts/list-agents.sh` | 에이전트 목록 |
| `./scripts/install-agents.sh` | 모든 에이전트 설치 |
| `./scripts/install-agents.sh <에이전트명>` | 특정 에이전트 설치 |
| `./scripts/uninstall-agents.sh <에이전트명>...` | 에이전트 제거 |

---

## 📁 저장소 구조 (참고)

```
claude-extensions/
├── custom/              # 내 스킬
│   ├── paper-summary/
│   └── research-presentation/
├── modified/            # 수정한 공식 스킬 (현재 없음)
├── vendor/official/     # 공식 스킬 원본 (서브모듈)
├── agents/
│   └── custom/          # 내 에이전트
│       └── research-consultant/
└── scripts/             # 관리 스크립트
```

**설치 위치:**
- 스킬: `~/.claude/skills/` (모든 프로젝트에서 사용 가능)
- 에이전트: `~/.claude/agents/` (모든 프로젝트에서 사용 가능)

---

## 🔗 유용한 링크

- [Claude Code 스킬 문서](https://code.claude.com/docs/en/skills)
- [Claude Code 서브에이전트 문서](https://code.claude.com/docs/en/sub-agents)
- [Anthropic 공식 스킬 저장소](https://github.com/anthropics/skills)

---

## 📝 라이센스

개인 사용을 위한 비공개 저장소입니다.
