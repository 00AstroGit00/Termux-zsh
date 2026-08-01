#!/usr/bin/env bash
# Termux-Zsh Module Loader Engine
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

load_module() {
    local module_name="${1}"
    local module_path="${SCRIPT_DIR}/modules/${module_name}.sh"
    if [[ -f "${module_path}" ]]; then
        source "${module_path}"
    else
        printf "\e[0;31m[ FAIL ]\033[0m Module missing: %s\n" "${module_path}"
        return 1
    fi
}
