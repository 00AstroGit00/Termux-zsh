#!/usr/bin/env bash
# Termux-Zsh Android API Integration Hooks
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/core/api.sh"

get_battery_level() {
    if command -v termux-battery-status &>/dev/null; then
        termux-battery-status 2>/dev/null | grep -E '"percentage":' | tr -d '",:a-z' | xargs || echo "N/A"
    else
        echo "N/A"
    fi
}

send_notification() {
    local title="${1:-Termux-Zsh}"
    local content="${2:-Task Completed}"
    if command -v termux-notification &>/dev/null; then
        termux-notification --title "${title}" --content "${content}" || true
    fi
}
