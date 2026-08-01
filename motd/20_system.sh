#!/usr/bin/env bash
# Termux-Zsh Fast System Summary MOTD Module
set -euo pipefail

green="\e[0;32m"
cyan="\e[0;36m"
bold="\e[1m"
nocol="\033[0m"

MEM_FREE="$(free -h 2>/dev/null | awk '/Mem:/ {print $4 "/" $2}' || echo "N/A")"
STORAGE_FREE="$(df -h "${HOME}" 2>/dev/null | awk 'NR==2 {print $4}' || echo "N/A")"
UPTIME="$(uptime -p 2>/dev/null | sed 's/up //' || echo "N/A")"

# Battery status (Termux:API opt-in)
battery_info=""
if command -v termux-battery-status &>/dev/null; then
    battery_json="$(termux-battery-status 2>/dev/null || echo '{}')"
    battery_pct="$(echo "${battery_json}" | grep -o '"percentage":[0-9]*' | cut -d: -f2 || true)"
    battery_status="$(echo "${battery_json}" | grep -o '"status":"[^"]*"' | cut -d'"' -f4 || true)"
    if [[ -n "${battery_pct}" ]]; then
        battery_info="  🔋 Battery: ${battery_pct}% (${battery_status:-Unknown})"
    fi
fi

printf "${cyan}┌────────────────────────────────────────────────────────────┐${nocol}\n"
printf "${cyan}│${nocol} ${bold}System Metrics & Resource Usage${nocol}                          ${cyan}│${nocol}\n"
printf "${cyan}├────────────────────────────────────────────────────────────┤${nocol}\n"
printf "${cyan}│${nocol}  💾 Storage: %-15s ⚡ RAM Usage: %-13s ${cyan}│${nocol}\n" "${STORAGE_FREE}" "${MEM_FREE}"
printf "${cyan}│${nocol}  ⏱️  Uptime:  %-44s ${cyan}│${nocol}\n" "${UPTIME}"
if [[ -n "${battery_info}" ]]; then
    printf "${cyan}│${nocol} %-58s ${cyan}│${nocol}\n" "${battery_info}"
fi
printf "${cyan}└────────────────────────────────────────────────────────────┘${nocol}\n"
