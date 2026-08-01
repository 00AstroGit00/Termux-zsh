#!/usr/bin/env bash
# Termux-Zsh MOTD Shortcuts Module
set -euo pipefail

green="\e[0;32m"
cyan="\e[0;36m"
bold="\e[1m"
nocol="\033[0m"

printf "${green}┌── ⌨️  KEYBOARD SHORTCUTS ──────────────────────────────────────────────┐${nocol}\n"
printf "${green}│${nocol}  ${bold}Ctrl + O${nocol}    Launch 'lf' file manager (preserves directory on exit)  ${green}│${nocol}\n"
printf "${green}│${nocol}  ${bold}Ctrl + E${nocol}    Edit current command line in 'micro' editor             ${green}│${nocol}\n"
printf "${green}└──────────────────────────────────────────────────────────────────────┘${nocol}\n"

printf "${cyan}┌── 🛠️  CUSTOMIZATION COMMANDS ──────────────────────────────────────────┐${nocol}\n"
printf "${cyan}│${nocol}  ${bold}termux-settings${nocol}  Launch interactive settings dashboard menu            ${cyan}│${nocol}\n"
printf "${cyan}│${nocol}  ${bold}termux-doctor${nocol}    Run system health diagnostics and auto-repair       ${cyan}│${nocol}\n"
printf "${cyan}└──────────────────────────────────────────────────────────────────────┘${nocol}\n\n"
