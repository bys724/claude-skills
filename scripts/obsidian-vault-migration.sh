#!/bin/bash

# Obsidian Vault Migration Script
# iCloud 동기화에서 독립적 위치로 이동 + 정기 백업 설정

# ==========================================
# 1. 변수 설정
# ==========================================
SOURCE_DIR="$HOME/Documents/Obsidian Vault"
NEW_LOCAL_DIR="$HOME/LocalVault"  # iCloud 외부 독립 위치
ICLOUD_BACKUP_DIR="$HOME/Documents/ObsidianVault_Backup"  # iCloud 내 백업 위치

# ==========================================
# 2. Vault 이동 (일회성 실행)
# ==========================================
migrate_vault() {
    echo "📦 Obsidian Vault를 iCloud 외부로 이동합니다..."

    # 대상 디렉토리 생성
    mkdir -p "$NEW_LOCAL_DIR"

    # 현재 Vault 복사 (rsync 사용하여 메타데이터 보존)
    echo "📋 Vault 복사 중... (약 233MB)"
    rsync -avh --progress "$SOURCE_DIR/" "$NEW_LOCAL_DIR/Obsidian Vault/"

    if [ $? -eq 0 ]; then
        echo "✅ 복사 완료!"
        echo ""
        echo "⚠️  다음 단계를 수동으로 진행하세요:"
        echo "1. Obsidian 앱 열기"
        echo "2. 'Open folder as vault' 선택"
        echo "3. 새 위치 선택: $NEW_LOCAL_DIR/Obsidian Vault"
        echo "4. 정상 작동 확인 후 원본 삭제: rm -rf \"$SOURCE_DIR\""
    else
        echo "❌ 복사 실패. 다시 시도해주세요."
        exit 1
    fi
}

# ==========================================
# 3. 단방향 백업 함수 (정기 실행용)
# ==========================================
backup_to_icloud() {
    echo "🔄 $(date '+%Y-%m-%d %H:%M:%S') - iCloud 백업 시작"

    # 백업 디렉토리 생성
    mkdir -p "$ICLOUD_BACKUP_DIR"

    # rsync로 단방향 동기화 (로컬 -> iCloud)
    # --delete: iCloud 백업에서 로컬에 없는 파일 삭제
    # --exclude: 불필요한 파일 제외
    rsync -avh --delete \
        --exclude='.obsidian/workspace*' \
        --exclude='.obsidian/cache' \
        --exclude='.DS_Store' \
        --exclude='*.tmp' \
        "$NEW_LOCAL_DIR/Obsidian Vault/" \
        "$ICLOUD_BACKUP_DIR/"

    if [ $? -eq 0 ]; then
        echo "✅ 백업 완료: $ICLOUD_BACKUP_DIR"
    else
        echo "❌ 백업 실패"
        return 1
    fi
}

# ==========================================
# 4. 실행 모드 선택
# ==========================================
case "$1" in
    "migrate")
        migrate_vault
        ;;
    "backup")
        backup_to_icloud
        ;;
    "setup-cron")
        # crontab 설정 추가
        SCRIPT_PATH="$(cd "$(dirname "$0")" && pwd)/$(basename "$0")"
        echo "⏰ cron 작업 설정 중..."

        # 매 시간마다 백업 (필요에 따라 조정)
        CRON_JOB="0 * * * * $SCRIPT_PATH backup >> $HOME/LocalVault/backup.log 2>&1"

        # 기존 cron에 추가
        (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -

        echo "✅ cron 설정 완료. 매시간 정각에 백업됩니다."
        echo "📝 로그 위치: $HOME/LocalVault/backup.log"
        ;;
    "setup-launchd")
        # macOS launchd 사용 (cron 대신 권장)
        cat > ~/Library/LaunchAgents/com.user.obsidian-backup.plist << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.user.obsidian-backup</string>
    <key>ProgramArguments</key>
    <array>
        <string>$0</string>
        <string>backup</string>
    </array>
    <key>StartInterval</key>
    <integer>3600</integer> <!-- 3600초 = 1시간마다 -->
    <key>StandardOutPath</key>
    <string>$HOME/LocalVault/backup.log</string>
    <key>StandardErrorPath</key>
    <string>$HOME/LocalVault/backup-error.log</string>
</dict>
</plist>
EOF
        launchctl load ~/Library/LaunchAgents/com.user.obsidian-backup.plist
        echo "✅ launchd 설정 완료. 1시간마다 자동 백업됩니다."
        ;;
    *)
        echo "📚 Obsidian Vault 이동 및 백업 스크립트"
        echo ""
        echo "사용법:"
        echo "  ./$(basename "$0") migrate      - Vault를 iCloud 외부로 이동"
        echo "  ./$(basename "$0") backup       - 수동 백업 실행"
        echo "  ./$(basename "$0") setup-cron   - cron으로 자동 백업 설정"
        echo "  ./$(basename "$0") setup-launchd - launchd로 자동 백업 설정 (macOS 권장)"
        echo ""
        echo "현재 설정:"
        echo "  원본: $SOURCE_DIR"
        echo "  신규: $NEW_LOCAL_DIR/Obsidian Vault"
        echo "  백업: $ICLOUD_BACKUP_DIR"
        ;;
esac