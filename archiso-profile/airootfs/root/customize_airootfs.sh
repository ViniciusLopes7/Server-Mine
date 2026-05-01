#!/usr/bin/env bash

set -euo pipefail

# Ensure deterministic live credentials for text-mode login.
if ! id -u Server >/dev/null 2>&1; then
    useradd --badname -m -G wheel -s /bin/bash Server
fi

echo 'Server:crias' | chpasswd
echo 'root:crias' | chpasswd

# Allow wheel users to use sudo with password.
if grep -q '^# %wheel ALL=(ALL:ALL) ALL' /etc/sudoers; then
    sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers
fi
