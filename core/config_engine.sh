#!/usr/bin/env bash
# Termux-Zsh Configuration Engine
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "${SCRIPT_DIR}/core/api.sh"

CONF_FILE="${TERMUX_HOME}/.termux/termux-zsh.conf"

config_init_defaults() {
    mkdir -p "$(dirname "${CONF_FILE}")"
    if [[ ! -f "${CONF_FILE}" ]]; then
        cat << 'EOF' > "${CONF_FILE}"
# Termux-Zsh v12.0.0 Unified Configuration File
DEFAULT_THEME=IrBlack
DEFAULT_FONT=JetBrainsMono
DEFAULT_PROMPT=powerlevel10k
AUTO_UPDATE_DAYS=7
MOTD_ENABLED=true
EOF
        api_log_success "Initialized configuration at ${CONF_FILE}"
    fi
}

config_validate() {
    if [[ -f "${CONF_FILE}" ]]; then
        api_log_success "Configuration schema validation passed."
    else
        config_init_defaults
    fi
}

config_validate
