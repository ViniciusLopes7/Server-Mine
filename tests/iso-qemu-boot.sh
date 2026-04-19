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
squashfs_rel="$(bsdtar -tf "$ISO_FILE" | grep -E '.*/x86_64/airootfs\.sfs$' | head -n 1 || true)"

if [ -z "$kernel_rel" ] || [ -z "$initramfs_rel" ] || [ -z "$squashfs_rel" ]; then
    echo "Kernel, initramfs ou squashfs nao encontrados na ISO." >&2
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

iso_uuid="$(blkid -o value -s UUID "$ISO_FILE" 2>/dev/null || true)"
iso_label="$(blkid -o value -s LABEL "$ISO_FILE" 2>/dev/null || true)"

if [ -z "$iso_uuid" ] && [ -z "$iso_label" ]; then
    echo "Nao foi possivel detectar UUID/LABEL da ISO com blkid." >&2
    exit 1
fi

img_dev_path=""
if [ -n "$iso_uuid" ]; then
    img_dev_path="/dev/disk/by-uuid/${iso_uuid}"
else
    img_dev_path="/dev/disk/by-label/${iso_label}"
fi

qemu_kernel_args=(
    "archisobasedir=${install_dir}"
    "img_dev=${img_dev_path}"
    "img_loop=/${squashfs_rel}"
)

if [ -n "$iso_uuid" ]; then
    qemu_kernel_args+=("archisosearchuuid=${iso_uuid}")
fi

if [ -n "$iso_label" ]; then
    qemu_kernel_args+=("archisolabel=${iso_label}")
fi

qemu_kernel_args+=(
    "console=tty0"
    "console=ttyS0,115200"
    "loglevel=4"
    "rd.systemd.show_status=1"
    "systemd.log_level=info"
    "systemd.log_target=console"
)

kernel_cmdline="${qemu_kernel_args[*]}"

echo "[iso-qemu-boot] Usando archisobasedir=${install_dir} img_loop=/${squashfs_rel}"
echo "[iso-qemu-boot] Identificadores: UUID=${iso_uuid:-n/a} LABEL=${iso_label:-n/a}"
echo "[iso-qemu-boot] img_dev=${img_dev_path}"
echo "[iso-qemu-boot] Boot smoke em QEMU (timeout=${BOOT_TIMEOUT}s)..."

set +e
timeout "$BOOT_TIMEOUT" qemu-system-x86_64 \
    -m 2048 \
    -cdrom "$ISO_FILE" \
    -kernel "$KERNEL_FILE" \
    -initrd "$INITRAMFS_FILE" \
    -append "$kernel_cmdline" \
    -nographic \
    -no-reboot \
    -monitor none \
    -serial stdio > "$LOG_FILE" 2>&1
qemu_status=$?
set -e

cp "$LOG_FILE" "$ROOT_DIR/qemu-boot.log" || true

if grep -Eqi 'Failed to start Switch Root|You are in emergency mode|dropped into an emergency shell|Cannot open access to console|Kernel panic|Unable to find device with label|Timed out waiting for device' "$LOG_FILE"; then
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