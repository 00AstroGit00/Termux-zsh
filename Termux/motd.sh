#!/usr/bin/env bash
# Termux-Zsh Modular MOTD Runner Engine
set -euo pipefail

# Resolve MOTD modules: prefer installed location, fall back to repo
MOTD_DIR="${HOME}/.termux/motd"
if [[ ! -d "${MOTD_DIR}" ]]; then
    MOTD_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/motd"
fi

for motd_module in "${MOTD_DIR}"/*.sh; do
    if [[ -f "${motd_module}" ]]; then
        source "${motd_module}"
    fi
done
