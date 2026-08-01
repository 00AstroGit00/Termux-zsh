#!/usr/bin/env bash
#
## Termux-zsh Repair & Restoration Tool
#

set -euo pipefail

green="\e[0;32m"
yellow="\e[0;33m"
red="\e[0;31m"
nocol="\033[0m"

BACKUP_ROOT="${HOME}/.termux-zsh-backups"

printf "${yellow}=========================================${nocol}\n"
printf "${green}  Termux-zsh Restoration & Repair Tool  ${nocol}\n"
printf "${yellow}=========================================${nocol}\n\n"

if [[ ! -d "${BACKUP_ROOT}" ]]; then
    printf "${red}No backup directory found at ${BACKUP_ROOT}.${nocol}\n"
    printf "To reset shell back to bash, run: ${green}chsh -s bash${nocol}\n"
    exit 1
fi

latest_backup="$(ls -td "${BACKUP_ROOT}"/backup_* 2>/dev/null | head -n 1 || true)"

if [[ -z "${latest_backup}" || ! -d "${latest_backup}" ]]; then
    printf "${red}No timestamped backups found inside ${BACKUP_ROOT}.${nocol}\n"
    exit 1
fi

printf "Latest available backup: ${green}${latest_backup}${nocol}\n\n"
read -p "Do you want to restore your previous configuration from this backup? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    printf "${green}Restoring configuration files...${nocol}\n"
    
    if [[ -d "${latest_backup}/.termux" ]]; then
        rm -rf "${HOME}/.termux"
        cp -r "${latest_backup}/.termux" "${HOME}/"
        printf "Restored: ${HOME}/.termux\n"
    fi

    if [[ -f "${latest_backup}/.zshrc" ]]; then
        cp -f "${latest_backup}/.zshrc" "${HOME}/.zshrc"
        printf "Restored: ${HOME}/.zshrc\n"
    fi

    if [[ -f "${latest_backup}/.p10k.zsh" ]]; then
        cp -f "${latest_backup}/.p10k.zsh" "${HOME}/.p10k.zsh"
        printf "Restored: ${HOME}/.p10k.zsh\n"
    fi

    if [[ -d "${latest_backup}/.config/lf" ]]; then
        rm -rf "${HOME}/.config/lf"
        mkdir -p "${HOME}/.config"
        cp -r "${latest_backup}/.config/lf" "${HOME}/.config/"
        printf "Restored: ${HOME}/.config/lf\n"
    fi

    if [[ -f "${latest_backup}/sys_files/motd" ]]; then
        cp -f "${latest_backup}/sys_files/motd" "${PREFIX:-/data/data/com.termux/files/usr}/etc/motd"
        printf "Restored: MOTD banner\n"
    fi

    printf "\n${green}Restoration completed successfully!${nocol}\n"
fi

printf "\n"
read -p "Do you want to revert your default login shell to bash? [y/N] " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    if command -v chsh &>/dev/null; then
        chsh -s bash
        printf "${green}Default shell changed to bash.${nocol}\n"
    fi
fi

printf "\n${green}Repair process complete. Restart Termux for changes to take effect.${nocol}\n"
