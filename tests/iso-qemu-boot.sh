#!/bin/bash

set -euo pipefail

if [ "$#" -lt 1 ]; then
    echo "Uso: $0 <caminho-da-iso> [timeout-segundos]" >&2
    exit 1
fi

ISO_FILE="$1"
BOOT_TIMEOUT="${2:-240}"

if [ ! -f "$ISO_FILE" ]; then
    echo "Arquivo ISO nao encontrado: $ISO_FILE" >&2
    exit 1
fi

if ! command -v qemu-system-x86_64 >/dev/null 2>&1; then
    echo "qemu-system-x86_64 nao encontrado no ambiente." >&2
    exit 1
fi

if ! command -v bsdtar >/dev/null 2>&1; then
    echo "bsdtar nao encontrado no ambiente." >&2
    exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

WORK_DIR="$(mktemp -d)"
LOG_FILE="$WORK_DIR/qemu-boot.log"
trap 'rm -rf "$WORK_DIR"' EXIT

kernel_rel="$(bsdtar -tf "$ISO_FILE" | grep -E '.*/boot/x86_64/vmlinuz-linux$' | head -n 1 || true)"
initramfs_rel="$(bsdtar -tf "$ISO_FILE" | grep -E '.*/boot/x86_64/initramfs-linux\.img$' | head -n 1 || true)"

if [ -z "$kernel_rel" ] || [ -z "$initramfs_rel" ]; then
    echo "Kernel ou initramfs nao encontrados na ISO." >&2
    exit 1
fi

bsdtar -xf "$ISO_FILE" -C "$WORK_DIR" "$kernel_rel" "$initramfs_rel"

KERNEL_FILE="$WORK_DIR/$kernel_rel"
INITRAMFS_FILE="$WORK_DIR/$initramfs_rel"

install_dir="${kernel_rel%/boot/x86_64/vmlinuz-linux}"
install_dir="${install_dir#/}"

if [ -z "$install_dir" ] || [ "$install_dir" = "$kernel_rel" ]; then
    echo "Nao foi possivel detectar archisobasedir a partir do kernel na ISO." >&2
    exit 1
fi

if ! command -v blkid >/dev/null 2>&1; then
    echo "blkid nao encontrado no ambiente." >&2
    exit 1
fi

iso_label="$(blkid -o value -s LABEL "$ISO_FILE" 2>/dev/null || true)"
if [ -z "$iso_label" ]; then
    echo "Nao foi possivel detectar label da ISO com blkid." >&2
    exit 1
fi

echo "[iso-qemu-boot] Usando archisobasedir=${install_dir} archisolabel=${iso_label}"
echo "[iso-qemu-boot] Boot smoke em QEMU (timeout=${BOOT_TIMEOUT}s)..."

set +e
timeout "$BOOT_TIMEOUT" qemu-system-x86_64 \
    -m 2048 \
    -cdrom "$ISO_FILE" \
    -kernel "$KERNEL_FILE" \
    -initrd "$INITRAMFS_FILE" \
    -append "archisobasedir=${install_dir} archisolabel=${iso_label} console=tty0 console=ttyS0,115200 loglevel=4 rd.systemd.show_status=1 systemd.log_level=info systemd.log_target=console" \
    -nographic \
    -no-reboot \
    -monitor none \
    -serial stdio > "$LOG_FILE" 2>&1
qemu_status=$?
set -e

cp "$LOG_FILE" "$ROOT_DIR/qemu-boot.log" || true

if grep -Eqi 'Failed to start Switch Root|You are in emergency mode|Cannot open access to console|Kernel panic|Unable to find device with label|Timed out waiting for device' "$LOG_FILE"; then
    echo "Falha de boot detectada no log do QEMU." >&2
    tail -n 120 "$LOG_FILE" >&2
    exit 1
fi

if ! grep -Eqi 'archiso login:|Welcome to Arch Linux|Reached target .*Multi-User|Reached target .*Login Prompts|root@archiso' "$LOG_FILE"; then
    echo "Sem marcador de boot completo detectado no log do QEMU." >&2
    tail -n 120 "$LOG_FILE" >&2
    exit 1
fi

if [ "$qemu_status" -ne 0 ] && [ "$qemu_status" -ne 124 ]; then
    echo "QEMU retornou status inesperado: $qemu_status" >&2
    tail -n 120 "$LOG_FILE" >&2
    exit 1
fi

echo "[iso-qemu-boot] OK"