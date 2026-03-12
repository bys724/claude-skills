# Scripts

## 유지되는 스크립트

### obsidian-vault-migration.sh
Obsidian Vault를 iCloud에서 독립 위치로 이동하고 정기 백업 설정

```bash
# Vault 이동
./obsidian-vault-migration.sh migrate

# 수동 백업
./obsidian-vault-migration.sh backup

# 자동 백업 설정
./obsidian-vault-migration.sh setup-launchd
```

## 참고: 스킬 관리 (필요시 직접 수행)

### 스킬 설치
```bash
# 특정 스킬만
cp -r custom/skill-name ~/.claude/skills/

# 전체 스킬
cp -r custom/* ~/.claude/skills/
```

### 스킬 목록 확인
```bash
ls -la ~/.claude/skills/
```

### 스킬 삭제
```bash
rm -rf ~/.claude/skills/skill-name
```

## 설계 원칙
- **최소 유지**: 실제로 반복 사용하는 스크립트만 유지
- **문서화 우선**: 일회성 작업은 README에 명령어로 문서화
- **YAGNI 원칙**: 필요할 때 만들기