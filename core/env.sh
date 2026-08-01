#!/usr/bin/env bash
# Termux-Zsh Core Environment Initialization
set -euo pipefail

# Root directories
export SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export TERMUX_PREFIX="${PREFIX:-/data/data/com.termux/files/usr}"
export TERMUX_HOME="${HOME:-/data/data/com.termux/files/home}"
export BACKUP_ROOT="${TERMUX_HOME}/.termux-zsh-backups"

# System Detection
export TERMUX_ARCH="$(dpkg --print-architecture 2>/dev/null || uname -m)"
export TERMUX_VER="${TERMUX_VERSION:-${TERMUX_APP__VERSION_NAME:-unknown}}"
export TERMUX_REL="${TERMUX_APK_RELEASE:-${TERMUX_APP__APK_RELEASE:-F-Droid}}"

# Zsh Custom Directory
export ZSH_CUSTOM_DIR="${ZSH_CUSTOM:-${TERMUX_HOME}/.oh-my-zsh/custom}"
