#!/usr/bin/env bash
# Termux-Zsh Modular MOTD Runner Engine
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

for motd_module in "${SCRIPT_DIR}/motd"/*.sh; do
    if [[ -f "${motd_module}" ]]; then
        source "${motd_module}"
    fi
done
