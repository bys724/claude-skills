# Modified Agents

이 디렉토리는 **공식 에이전트를 수정한 버전**을 관리합니다.

## 📝 용도

공식 에이전트 (있다면)를 기반으로 하되, 개인적인 필요에 맞게 수정한 에이전트들을 여기에 보관합니다.

**참고:** 현재 Anthropic은 공식 에이전트 저장소를 제공하지 않는 것으로 보입니다. 향후 제공될 경우를 대비한 디렉토리입니다.

## 🔧 수정된 에이전트 만들기

### 미래에 공식 에이전트가 제공되면:

```bash
# 1. 공식 에이전트 복사
cp -r vendor/official-agents/code-reviewer agents/modified/code-reviewer

# 2. 수정 작업
cd agents/modified/code-reviewer
# .md 파일 수정

# 3. 출처 기록
# 파일 상단에 주석 추가:
# <!--
# Based on: vendor/official-agents/code-reviewer
# Modified: 2024-02-03
# Changes: 프로젝트별 코딩 컨벤션 추가
# -->

# 4. 설치
./scripts/install-agents.sh code-reviewer
```

## 📋 관리 원칙

스킬의 `modified/`와 동일한 원칙을 따릅니다:

- **출처 기록**: 원본 에이전트 정보를 주석으로 명시
- **업데이트 추적**: 공식 에이전트 업데이트 시 변경사항 검토
- **문서화**: 수정 내용을 명확히 기록

## 📁 현재 수정된 에이전트

현재는 없음. 공식 에이전트가 제공되면 필요에 따라 수정하세요.
