#!/usr/bin/env bash
# Termux-Zsh Fast System Summary MOTD Module
set -euo pipefail

green="\e[0;32m"
cyan="\e[0;36m"
bold="\e[1m"
nocol="\033[0m"

MEM_FREE="$(free -h 2>/dev/null | awk '/Mem:/ {print $4 "/" $2}' || echo "N/A")"
STORAGE_FREE="$(df -h "${HOME}" 2>/dev/null | awk 'NR==2 {print $4}' || echo "N/A")"

printf "${cyan}┌── 📊 SYSTEM METRICS ──────────────────────────────────────────────────┐${nocol}\n"
printf "${cyan}│${nocol}  ${bold}RAM Available:${nocol} %-14s ${bold}Storage Free:${nocol} %-14s ${cyan}│${nocol}\n" "${MEM_FREE}" "${STORAGE_FREE}"
printf "${cyan}└──────────────────────────────────────────────────────────────────────┘${nocol}\n\n"
