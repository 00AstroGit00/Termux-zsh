#!/usr/bin/env bash
# Termux-Zsh Developer API Framework (core/api.sh)
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/core/env.sh"
source "${SCRIPT_DIR}/core/ui.sh"

CONFIG_FILE="${TERMUX_HOME}/.termux/termux-zsh.conf"

# Logging & Status Functions
api_log_info()    { printf "${cyan}[ INFO ]${nocol} %s\n" "${1}"; }
api_log_success() { printf "%b %s\n" "${badge_ok}" "${1}"; }
api_log_warn()    { printf "%b %s\n" "${badge_warn}" "${1}"; }
api_log_error()   { printf "%b %s\n" "${badge_fail}" "${1}"; }

# Configuration Key-Value Engine (~/.termux/termux-zsh.conf)
api_config_get() {
    local key="${1}" default_val="${2:-}"
    if [[ -f "${CONFIG_FILE}" ]]; then
        local val="$(grep -E "^${key}=" "${CONFIG_FILE}" | cut -d'=' -f2- || true)"
        echo "${val:-${default_val}}"
    else
        echo "${default_val}"
    fi
}

api_config_set() {
    local key="${1}" val="${2}"
    mkdir -p "$(dirname "${CONFIG_FILE}")"
    touch "${CONFIG_FILE}"
    if grep -q -E "^${key}=" "${CONFIG_FILE}"; then
        sed -i "s|^${key}=.*|${key}=${val}|" "${CONFIG_FILE}"
    else
        echo "${key}=${val}" >> "${CONFIG_FILE}"
    fi
}

# Path & Dependency Validation
api_require_cmd() {
    local cmd="${1}" pkg_suggestion="${2:-}"
    if ! command -v "${cmd}" &>/dev/null; then
        api_log_error "Missing required command: '${cmd}'. Install via: pkg install ${pkg_suggestion:-${cmd}}"
        return 1
    fi
}
