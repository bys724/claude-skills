---
name: code-cleaner
description: "This skill should be used when the user explicitly requests repository cleanup or says \"\uc815\ub9ac\ud574\uc918\", \"\ub9ac\ud329\ud1a0\ub9c1\", \"\uae54\ub054\ud558\uac8c\", \"refactor\", \"cleanup\", \"\ucf54\ub4dc \uc815\ub9ac\", or asks to reorganize code, folder structure, documentation, or comments. Performs broad cleanup across code, folder structure, docs, and comments \u2014 minimizing and clarifying structure while preserving essence. Only activates on explicit cleanup requests, not during normal code editing."
allowed-tools: Read Edit Write Glob Grep Bash(rm *) Bash(mv *) Bash(mkdir *) Bash(ls *) Bash(git status *) Bash(git diff *)
---

# Code Cleaner — 저장소 정리

평상시 코드 편집과 분리된 작업 모드. 평상시는 User CLAUDE.md "수술적 변경" 원칙(인접 코드에 손대지 않기)을 따르지만, 이 스킬은 사용자가 명시적으로 정리를 요청했을 때만 활성화되며 **코드·폴더 구조·문서·주석을 광범위하게 정리**.

| 모드 | 원칙 |
|---|---|
| 평상시 코드 편집 | 수술적 변경, drive-by 금지 (User CLAUDE.md) |
| 정리 모드 (이 스킬) | 코드·구조·문서·주석 광범위 정리, 합의 후 진행 |

## 목표

저장소의 **본질을 잃지 않으면서** 전체 관계가 한눈에 파악되도록 정리:

- 불필요한 요소 걷어내기
- 구조 명확화·최소화
- 핵심에 집중되는 형태로 재배치

## 자동 동의 vs 사용자 확인

**자동 OK (확인 없이 삭제·정리)**:

- 임시파일·일회성 작업 산출물
- 특정 디버깅·실험을 위해 만든 코드 중 목적이 종료된 것
- 명백한 중복·백업 파일

**사용자 확인 필요 (합의 후 진행)**:

- 폴더 구조 변경
- 문서 통폐합·재구성
- 코드 모듈 통합·분리
- "혹시 쓸지도 모르는" 회색지대 — 판단이 갈리는 항목

## 작업 순서

1. **분석**: 저장소 전반 훑기. 정리 후보를 *자동 OK* / *확인 필요*로 분류
2. **합의**: 확인 필요 항목을 사용자에게 제시하고 범위·방향 합의
3. **실행**: 자동 OK 즉시 처리, 합의된 항목 일괄 처리
4. **검증**: 정리 후 구조가 본질을 더 잘 드러내는지 확인

## 정리 원칙

- **삭제 우선**: 통합·이동보다 삭제가 가능하면 삭제
- **통합 지향**: 비슷한 목적·기능은 한 곳으로
- **문서로 대체**: 삭제한 기능 중 외부 참조 가능성 있는 것은 README에 한 줄로 기록
- **WHY > WHAT**: 남는 코드·문서의 주석은 의도 중심

## 금지 사항

- "혹시 모르니" 남겨두기
- 영구 백업 파일 (이력은 git에 위임)
- 비슷한 기능을 별도 파일로 분산
- 본질을 가리는 과도한 자동화
