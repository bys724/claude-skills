# Modified Skills

이 디렉토리는 **공식 스킬을 수정한 버전**을 관리합니다.

## 📝 용도

공식 스킬(`vendor/official/skills/`)을 기반으로 하되, 개인적인 필요에 맞게 수정한 스킬들을 여기에 보관합니다.

## 🔧 수정된 스킬 만들기

### 1. 공식 스킬 복사

```bash
# 예시: pdf 스킬을 수정하고 싶은 경우
cp -r vendor/official/skills/pdf modified/pdf
```

### 2. 수정 작업

```bash
cd modified/pdf
# SKILL.md나 다른 파일들을 수정
```

### 3. 설치

```bash
# 수정된 스킬을 ~/.claude/skills/에 설치
./scripts/install.sh pdf
```

**중요:** 같은 이름의 스킬이 있으면 `modified/`의 버전이 우선 설치됩니다.

## 📋 관리 원칙

- **출처 기록**: 각 스킬의 SKILL.md 상단에 원본 스킬 정보 주석 추가
  ```markdown
  <!--
  Based on: vendor/official/skills/pdf
  Modified: 2024-02-03
  Changes: 간단한 수정 내용 설명
  -->
  ```

- **업데이트 추적**: 공식 스킬이 업데이트되면 변경사항을 검토하고 필요시 머지

- **문서화**: 원본과 달라진 부분을 명확히 문서화

## 🔄 공식 스킬 업데이트 시

```bash
# 1. 공식 스킬 업데이트
./scripts/update-official.sh

# 2. 수정된 스킬과 비교
diff -r vendor/official/skills/pdf modified/pdf

# 3. 필요한 변경사항 머지
# (수동으로 검토 후 적용)
```

## 📁 현재 수정된 스킬

현재는 없음. 필요에 따라 공식 스킬을 복사하고 수정하세요.
