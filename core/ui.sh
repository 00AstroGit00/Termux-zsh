#!/usr/bin/env bash
# Termux-Zsh UI Utilities Library
set -euo pipefail

# Color Codes
export red="\e[0;31m"
export green="\e[0;32m"
export yellow="\e[0;33m"
export cyan="\e[0;36m"
export bold="\e[1m"
export nocol="\033[0m"

# Status Badges
export badge_ok="${green}${bold}[  OK  ]${nocol}"
export badge_warn="${yellow}${bold}[ WARN ]${nocol}"
export badge_fail="${red}${bold}[ FAIL ]${nocol}"

ui_card() {
    local title="${1}"
    local content="${2}"
    printf "${cyan}┌────────────────────────────────────────────────────────────┐${nocol}\n"
    printf "${cyan}│${nocol} %-58s ${cyan}│${nocol}\n" "${bold}${title}${nocol}"
    printf "${cyan}├────────────────────────────────────────────────────────────┤${nocol}\n"
    while IFS= read -r line; do
        printf "${cyan}│${nocol} %-58s ${cyan}│${nocol}\n" "${line}"
    done <<< "${content}"
    printf "${cyan}└────────────────────────────────────────────────────────────┘${nocol}\n"
}

ui_badge_msg() {
    local badge="${1}"
    local message="${2}"
    printf "%b %s\n" "${badge}" "${message}"
}
