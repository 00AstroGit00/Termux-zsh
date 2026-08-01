#!/usr/bin/env bash
# Termux-Zsh MOTD Header Module
set -euo pipefail

green="\e[0;32m"
cyan="\e[0;36m"
bold="\e[1m"
nocol="\033[0m"

TERM_VER="${TERMUX_VERSION:-${TERMUX_APP__VERSION_NAME:-unknown}}"
TERM_REL="${TERMUX_APK_RELEASE:-${TERMUX_APP__APK_RELEASE:-F-Droid}}"
ARCH="$(uname -m 2>/dev/null || echo "aarch64")"

if command -v toilet &>/dev/null; then
    printf "${green}"
    toilet -t -f smslant -F crop "Termux" 2>/dev/null || printf "${bold}Termux${nocol}\n"
    printf "${nocol}"
else
    printf "${green}${bold}  _____                                \n"
    printf " |_   _|__ _ __ _ __ ___  _   ___  __  \n"
    printf "   | |/ _ \\ '__| '_ \` _ \\| | | \\ \\/ /  \n"
    printf "   | |  __/ |  | | | | | | |_| |>  <   \n"
    printf "   |_|\\___|_|  |_| |_| |_|\\__,_/_/\\_\\  ${nocol}\n"
fi

printf "${cyan}v${TERM_VER} (${TERM_REL} | ${ARCH})${nocol}\n\n"
