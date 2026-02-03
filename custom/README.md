# Custom Skills

이 디렉토리는 **완전히 새로운 나만의 스킬**을 관리합니다.

## 📝 용도

공식 스킬과 무관하게 처음부터 직접 만든 스킬들을 여기에 보관합니다.

## 🎯 현재 커스텀 스킬

### paper-summary
논문 읽기, 토론, 종합적인 노트 생성 스킬

- 연구자 관점을 반영한 개인화된 한글 요약
- Obsidian typed links를 활용한 논문 네트워크 구축
- 향후 검색을 위한 태그 기반 분류

## 🆕 새로운 커스텀 스킬 만들기

### 1. 디렉토리 생성

```bash
mkdir custom/my-new-skill
cd custom/my-new-skill
```

### 2. SKILL.md 작성

```markdown
---
skill-id: my-new-skill
skill-name: My New Skill
description: 이 스킬이 하는 일에 대한 간단한 설명
user-invocable: true
---

# My New Skill

Claude를 위한 상세한 지시사항...

## 사용 방법

...

## 참고 자료

...
```

### 3. 설치 및 테스트

```bash
# 로컬 테스트 (이 프로젝트에서만)
cd .claude/skills
ln -s ../../custom/my-new-skill my-new-skill

# 전역 설치 (모든 프로젝트에서 사용)
./scripts/install.sh my-new-skill
```

## 📖 스킬 개발 가이드

### YAML Frontmatter 필수 필드

- `skill-id`: 스킬의 고유 ID (디렉토리명과 동일하게)
- `skill-name`: 사람이 읽을 수 있는 스킬 이름
- `description`: 스킬의 간단한 설명

### 선택적 필드

- `user-invocable: true/false` - 사용자가 직접 호출 가능한지
- `disable-model-invocation: true` - 모델 호출 비활성화 (배포 작업용)

### 모범 사례

- `SKILL.md`는 500줄 이하로 유지
- 상세한 참고 자료는 별도 파일로 분리 (`reference.md`, `examples.md` 등)
- 스크립트나 템플릿은 하위 디렉토리에 정리

## 🔗 유용한 링크

- [Claude Code 스킬 문서](https://code.claude.com/docs/en/skills)
- [공식 Skill Creator 스킬](../vendor/official/skills/skill-creator/)
