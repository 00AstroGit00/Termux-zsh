#!/usr/bin/env bash
# Termux-Zsh MOTD Update Alert Module
set -euo pipefail

yellow="\e[0;33m"
bold="\e[1m"
nocol="\033[0m"

CACHE_FILE="${HOME}/.cache/termux-zsh-update-check"
mkdir -p "${HOME}/.cache" 2>/dev/null || true

# Run check once every 7 days (604800 seconds)
now="$(date +%s 2>/dev/null || echo 0)"
last_check=0
if [[ -f "${CACHE_FILE}" ]]; then
    last_check="$(cat "${CACHE_FILE}" 2>/dev/null || echo 0)"
fi

if [[ ${now} -gt 0 && $((now - last_check)) -gt 604800 ]]; then
    echo "${now}" > "${CACHE_FILE}" 2>/dev/null || true
    # Asynchronous background update check
    (
        latest_tag="$(curl -s --max-time 3 "https://api.github.com/repos/00AstroGit00/Termux-zsh/releases/latest" 2>/dev/null | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' || echo '')"
        if [[ -n "${latest_tag}" && "${latest_tag}" != "v13.0.0" ]]; then
            printf "\n${yellow}${bold}[ UPDATE ]${nocol} Termux-zsh release %s is available! Run: ${bold}termux update${nocol}\n" "${latest_tag}"
        fi
    ) &>/dev/null &
fi
