#!/usr/bin/env bash
# Termux-Zsh Backup Engine
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/core/env.sh"
source "${SCRIPT_DIR}/core/ui.sh"

backup_create() {
    local label="${1:-manual}"
    local timestamp="$(date +"%Y-%m-%d_%H-%M-%S")"
    local backup_dir="${BACKUP_ROOT}/backup_${label}_${timestamp}"

    mkdir -p "${backup_dir}"
    
    [[ -d "${TERMUX_HOME}/.termux" ]] && cp -r "${TERMUX_HOME}/.termux" "${backup_dir}/"
    [[ -f "${TERMUX_HOME}/.zshrc" ]] && cp -f "${TERMUX_HOME}/.zshrc" "${backup_dir}/"
    [[ -f "${TERMUX_HOME}/.p10k.zsh" ]] && cp -f "${TERMUX_HOME}/.p10k.zsh" "${backup_dir}/"
    [[ -d "${TERMUX_HOME}/.config/lf" ]] && mkdir -p "${backup_dir}/.config" && cp -r "${TERMUX_HOME}/.config/lf" "${backup_dir}/.config/"

    ui_badge_msg "${badge_ok}" "Created backup: ${backup_dir}"
}

backup_list() {
    if [[ ! -d "${BACKUP_ROOT}" ]]; then
        ui_badge_msg "${badge_warn}" "No backups directory found at ${BACKUP_ROOT}"
        return 0
    fi
    printf "${cyan}Available Backups:${nocol}\n"
    ls -1d "${BACKUP_ROOT}"/backup_* 2>/dev/null || ui_badge_msg "${badge_warn}" "No backups found."
}

backup_restore_latest() {
    if [[ ! -d "${BACKUP_ROOT}" ]]; then
        ui_badge_msg "${badge_fail}" "No backup directory exists."
        return 1
    fi
    local latest="$(ls -td "${BACKUP_ROOT}"/backup_* 2>/dev/null | head -n 1 || true)"
    if [[ -z "${latest}" ]]; then
        ui_badge_msg "${badge_fail}" "No backups available to restore."
        return 1
    fi
    
    ui_badge_msg "${badge_ok}" "Restoring from: ${latest}"
    [[ -d "${latest}/.termux" ]] && rm -rf "${TERMUX_HOME}/.termux" && cp -r "${latest}/.termux" "${TERMUX_HOME}/"
    [[ -f "${latest}/.zshrc" ]] && cp -f "${latest}/.zshrc" "${TERMUX_HOME}/.zshrc"
    [[ -f "${latest}/.p10k.zsh" ]] && cp -f "${latest}/.p10k.zsh" "${TERMUX_HOME}/.p10k.zsh"
    [[ -d "${latest}/.config/lf" ]] && mkdir -p "${TERMUX_HOME}/.config" && cp -r "${latest}/.config/lf" "${TERMUX_HOME}/.config/"

    ui_badge_msg "${badge_ok}" "Restoration completed successfully."
}
