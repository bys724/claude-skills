# MCP Filesystem 권한 문제 해결 가이드

## 문제 진단

### 근본 원인
1. **MCP 서버 충돌**: `filesystem-obsidian`과 프로젝트 자동 생성 `filesystem` 충돌
2. **샌드박스 제한**: macOS Seatbelt이 쓰기 권한 차단
3. **경로 해석 문제**: 상대/절대 경로 혼재

## 해결 방안 (권장 순서)

### 방안 1: Simple Directory Addition (권장) ✅
가장 단순하고 안전한 방법

```bash
# 프로젝트에서 Claude Code 시작 시
claude --add-dir ~/LocalVault/Obsidian\ Vault

# 또는 실행 중 추가
/add-dir ~/LocalVault/Obsidian\ Vault
```

**장점**:
- 즉시 적용
- 충돌 없음
- 세션별 제어 가능

**단점**:
- 매번 추가 필요

### 방안 2: 계정 레벨 통합 설정
```json
// ~/.claude.json
{
  "additionalDirectories": [
    "/Users/bys724/LocalVault/Obsidian Vault",
    "/Users/bys724/LocalVault"
  ],
  "sandbox": {
    "enabled": true,
    "filesystem": {
      "allowWrite": [
        "/Users/bys724/LocalVault"
      ]
    }
  }
}
```

**주의**: filesystem MCP 서버는 설정하지 않음 (자동 생성과 충돌)

### 방안 3: 프로젝트별 설정
```json
// {project}/.claude/settings.local.json
{
  "additionalDirectories": [
    "/Users/bys724/LocalVault/Obsidian Vault"
  ],
  "permissions": {
    "allow": [
      "Read(path:/Users/bys724/LocalVault/Obsidian Vault)",
      "Write(path:/Users/bys724/LocalVault/Obsidian Vault)"
    ]
  }
}
```

## 보안 고려사항

### DO ✅
1. **특정 경로만 허용**: 전체 홈 디렉토리 X
2. **프로젝트별 격리**: 필요한 곳만 접근
3. **명시적 권한**: additionalDirectories 사용

### DON'T ❌
1. 샌드박스 완전 비활성화
2. 루트 디렉토리 접근 허용
3. 와일드카드 경로 사용

## 실전 워크플로우

### 저장소 → Obsidian 작성
```python
# 1. 프로젝트에서 작업
cd ~/projects/my-repo
claude

# 2. Obsidian 접근 추가 (세션 시작 시 한 번만)
/add-dir ~/LocalVault/Obsidian\ Vault

# 3. 직접 경로로 작성
Write("/Users/bys724/LocalVault/Obsidian Vault/새노트.md")
```

### 권한 에러 발생 시
```bash
# 1. 현재 허용 디렉토리 확인
/list-dirs

# 2. 필요한 디렉토리 추가
/add-dir ~/LocalVault/Obsidian\ Vault

# 3. 재시도
```

## 디버깅 체크리스트

- [ ] Claude Code 재시작했나?
- [ ] 절대 경로 사용했나? (`~` 아닌 `/Users/...`)
- [ ] additionalDirectories에 경로 있나?
- [ ] sandbox.allowWrite에 경로 있나?
- [ ] 프로젝트 .claude 폴더가 설정 오버라이드하나?

## 최종 권장사항

### 단기 (즉시 해결)
```bash
claude --add-dir ~/LocalVault/Obsidian\ Vault
```

### 장기 (영구 해결)
1. 계정 레벨 additionalDirectories 설정
2. filesystem MCP 서버는 설정하지 않음
3. 프로젝트별로 필요시 /add-dir 사용

## FAQ

**Q: 왜 filesystem-obsidian이 작동 안 하나?**
A: 프로젝트에서 자동 생성되는 filesystem과 충돌

**Q: 매번 add-dir 해야 하나?**
A: 계정 레벨 additionalDirectories 설정하면 불필요

**Q: 보안상 안전한가?**
A: 특정 경로만 허용하면 안전. 샌드박스는 유지