#!/bin/bash

SERVER_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_SCRIPT="$SERVER_DIR/backup-cron.sh"
LOG_FILE="/var/log/minecraft-backup.log"
SERVER_USER="${SERVER_USER:-}"

# Reuse shared ANSI color definitions when available (installed stacks ship it in .shared).
COMMON_LIB="$SERVER_DIR/.shared/common.sh"
if [ -f "$COMMON_LIB" ]; then
    # shellcheck source=/dev/null
    source "$COMMON_LIB"
else
    BLUE='\033[0;34m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    CYAN='\033[0;36m'
    NC='\033[0m'
fi

detect_server_user() {
    if [ -n "$SERVER_USER" ]; then
        return 0
    fi

    SERVER_USER=$(stat -c '%U' "$SERVER_DIR" 2>/dev/null || true)
    if [ -z "$SERVER_USER" ] || [ "$SERVER_USER" = "UNKNOWN" ]; then
        SERVER_USER="$(id -un)"
    fi
}

echo -e "${BLUE}==========================================${NC}"
echo -e "${BLUE} Configuracao de Backup Minecraft${NC}"
echo -e "${BLUE}==========================================${NC}"

if [ ! -f "$BACKUP_SCRIPT" ]; then
    echo -e "${YELLOW}AVISO:${NC} Backup script nao encontrado: $BACKUP_SCRIPT"
    exit 1
fi

chmod +x "$BACKUP_SCRIPT"

echo -e "${CYAN}Escolha a frequencia:${NC}"
echo "1) Diario as 03:00"
echo "2) Duas vezes por dia (03:00 e 15:00)"
echo "3) A cada 4 horas"
echo "4) Semanal (domingo as 03:00)"
echo "5) Personalizado"
read -r -p "Opcao (1-5): " choice

case "$choice" in
    1) CRON_EXPR="0 3 * * *" ; DESC="Diario as 03:00" ;;
    2) CRON_EXPR="0 3,15 * * *" ; DESC="Duas vezes por dia" ;;
    3) CRON_EXPR="0 */4 * * *" ; DESC="A cada 4 horas" ;;
    4) CRON_EXPR="0 3 * * 0" ; DESC="Semanal domingo as 03:00" ;;
    5)
        read -r -p "Digite a expressao cron: " CRON_EXPR
        DESC="Personalizado ($CRON_EXPR)"
        ;;
    *)
        echo "Opcao invalida."
        exit 1
        ;;
esac

CRON_LINE="$CRON_EXPR $BACKUP_SCRIPT >> \"$LOG_FILE\" 2>&1"
tmp_cron_file="$(mktemp)"
trap 'rm -f "$tmp_cron_file"' EXIT

detect_server_user

if [ "$(id -u)" -eq 0 ] && [ -n "$SERVER_USER" ] && [ "$SERVER_USER" != "root" ]; then
    crontab -u "$SERVER_USER" -l 2>/dev/null | grep -Fv "$BACKUP_SCRIPT" > "$tmp_cron_file" || true
    printf '%s\n' "$CRON_LINE" >> "$tmp_cron_file"
    crontab -u "$SERVER_USER" "$tmp_cron_file"
else
    crontab -l 2>/dev/null | grep -Fv "$BACKUP_SCRIPT" > "$tmp_cron_file" || true
    printf '%s\n' "$CRON_LINE" >> "$tmp_cron_file"
    crontab "$tmp_cron_file"
fi

echo -e "${GREEN}Backup configurado:${NC} $DESC"
echo "Log: $LOG_FILE"
