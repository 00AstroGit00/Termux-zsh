#!/usr/bin/env bash
#
## Termux-zsh Modernized Setup Script
#

# Color & Format Codes
red="\e[0;31m"      # Red
green="\e[0;32m"    # Green
yellow="\e[0;33m"   # Yellow
cyan="\e[0;36m"     # Cyan
bold="\e[1m"        # Bold
nocol="\033[0m"     # Default

# Status badges
badge_ok="${green}${bold}[  OK  ]${nocol}"
badge_warn="${yellow}${bold}[ WARN ]${nocol}"
badge_fail="${red}${bold}[ FAIL ]${nocol}"

# Strict mode
set -euo pipefail

# Path resolution
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TIMESTAMP="$(date +"%Y-%m-%d_%H-%M-%S")"
BACKUP_DIR="${HOME}/.termux-zsh-backups/backup_${TIMESTAMP}"
LANG_CODE="en"
AUTO_YES=false

# Pre-scan all arguments for -l <lang_code> before loading lang files
for ((i = 1; i <= "${#}"; i++)); do
	arg="${!i}"
	next_index=$((i + 1))
	next_arg="${!next_index:-}"

	if [[ ${arg} == "-y" || ${arg} == "--yes" ]]; then
		AUTO_YES=true
	fi

	if [[ ${arg} == "-l" ]]; then
		if [[ -z ${next_arg} || ${next_arg} == -* ]]; then
			printf "%b Missing language code after -l|--lang\n" "${badge_fail}"
			printf "Use -ls to list available languages or -h for help\n"
			exit 1
		fi
		lang_input="${next_arg,,}"
		if [[ -d "${SCRIPT_DIR}/Termux/lang/${lang_input}" ]]; then
			LANG_CODE="${lang_input}"
		else
			printf "%b No localization found for language code %s\n" "${badge_fail}" "${lang_input}"
			printf "Check available languages with -ls or use -h for help\n"
			exit 1
		fi
		break
	fi
done

# Load lang files safely
mapfile -t LANG_STRINGS < "${SCRIPT_DIR}/Termux/lang/${LANG_CODE}/setup.lang"
mapfile -t COMMON_STRINGS < "${SCRIPT_DIR}/Termux/lang/${LANG_CODE}/common.lang"

while [[ ${#} -gt 0 ]]; do
	case "${1}" in
		-ls)
			printf "${green}${COMMON_STRINGS[9]}${nocol}:\n"
			find "${SCRIPT_DIR}/Termux/lang" -mindepth 1 -maxdepth 1 -type d -exec basename {} \;
			exit 0
			;;
		-y|--yes)
			AUTO_YES=true
			shift
			;;
		-h)
			printf "${green}${COMMON_STRINGS[10]}${nocol}: setup.sh [-y|--yes] [-l <${COMMON_STRINGS[12]}>]\n"
			printf "${green}${COMMON_STRINGS[11]}${nocol}:\n"
			printf "    -y, --yes          Non-interactive automatic mode (accept all defaults)\n"
			printf "    -l <${COMMON_STRINGS[12]}> ${COMMON_STRINGS[13]}\n"
			printf "    -ls                ${COMMON_STRINGS[14]}\n"
			printf "    -h                 ${COMMON_STRINGS[15]}\n"
			exit 0
			;;
		*)
			shift
			;;
	esac
done

backup_item() {
	local target="${1}"
	if [[ -e "${target}" ]]; then
		mkdir -p "${BACKUP_DIR}"
		local rel_path="${target#"${HOME}/"}"
		if [[ "${rel_path}" == "${target}" ]]; then
			rel_path="sys_files/$(basename "${target}")"
		fi
		mkdir -p "${BACKUP_DIR}/$(dirname "${rel_path}")"
		cp -r "${target}" "${BACKUP_DIR}/${rel_path}"
		printf "%b Backed up %s -> %s\n" "${badge_warn}" "${target}" "${BACKUP_DIR}/${rel_path}"
	fi
}

clone_or_update_repo() {
	local repo_url="${1}"
	local dest_dir="${2}"
	local depth_flag="${3:-}"

	if [[ -d "${dest_dir}/.git" ]]; then
		printf "%b Updating existing repository: %s...\n" "${badge_ok}" "${dest_dir}"
		git -C "${dest_dir}" pull --quiet || printf "%b Failed to update %s, skipping...\n" "${badge_warn}" "${dest_dir}"
	else
		printf "%b Cloning %s -> %s...\n" "${badge_ok}" "${repo_url}" "${dest_dir}"
		if [[ -n "${depth_flag}" ]]; then
			git clone --depth="${depth_flag}" "${repo_url}" "${dest_dir}"
		else
			git clone "${repo_url}" "${dest_dir}"
		fi
	fi
}

install_dependencies() {
	printf "%b %s...\n" "${badge_ok}" "${LANG_STRINGS[0]}"
	if command -v pkg &>/dev/null; then
		pkg update -y || true
		pkg install -y termux-tools coreutils less fontconfig-utils git zsh figlet toilet lf curl wget micro man || true
	else
		apt update || { printf "%b %s!\n" "${badge_fail}" "${LANG_STRINGS[1]}"; exit 1; }
		apt install -y termux-tools coreutils less fontconfig-utils git zsh figlet toilet lf curl wget micro man || { printf "%b %s!\n" "${badge_fail}" "${LANG_STRINGS[1]}"; exit 1; }
	fi
}

install_optional_modern_tools() {
	printf "\n"
	printf "${cyan}┌────────────────────────────────────────────────────────────┐${nocol}\n"
	printf "${cyan}│${nocol} ${bold}Optional Modern CLI Utilities Enhancement${nocol}                   ${cyan}│${nocol}\n"
	printf "${cyan}├────────────────────────────────────────────────────────────┤${nocol}\n"
	printf "${cyan}│${nocol} Install eza, bat, fzf, zoxide, ripgrep, fd, delta?          ${cyan}│${nocol}\n"
	printf "${cyan}│${nocol} (Improves file listing, viewing, searching, and navigation) ${cyan}│${nocol}\n"
	printf "${cyan}└────────────────────────────────────────────────────────────┘${nocol}\n"
	if [[ "${AUTO_YES}" == "true" ]]; then
		choice="y"
	else
		read -p "Install modern CLI tools? [Y/n] " -n 1 -r choice || choice="y"
		echo
	fi
	if [[ "${choice}" =~ ^[Yy]$ || -z "${choice}" ]]; then
		printf "%b Installing modern CLI utilities via pkg...\n" "${badge_ok}"
		if command -v pkg &>/dev/null; then
			pkg install -y eza bat fzf zoxide ripgrep fd git-delta || printf "%b Optional tools installation finished with warnings.\n" "${badge_warn}"
		fi
	fi
}

configure_termux() {
	printf "%b %s...\n" "${badge_ok}" "${LANG_STRINGS[2]}"
	if [ -d "${HOME}/.termux" ]; then
		backup_item "${HOME}/.termux"
	fi
	mkdir -p "${HOME}/.termux"
	cp -r "${SCRIPT_DIR}/Termux/"* "${HOME}/.termux/"
	chmod +x "${HOME}/.termux/fonts.sh" "${HOME}/.termux/colors.sh"
	printf "%b %s...\n" "${badge_ok}" "${LANG_STRINGS[5]}"
	ln -fs "${HOME}/.termux/colors/dark/IrBlack.properties" "${HOME}/.termux/colors.properties"

	if [[ -f "${PREFIX:-/data/data/com.termux/files/usr}/etc/motd" ]]; then
		backup_item "${PREFIX:-/data/data/com.termux/files/usr}/etc/motd"
		rm -f "${PREFIX:-/data/data/com.termux/files/usr}/etc/motd"
	fi
	if [[ -f "${PREFIX:-/data/data/com.termux/files/usr}/etc/motd.sh" ]]; then
		backup_item "${PREFIX:-/data/data/com.termux/files/usr}/etc/motd.sh"
	fi
	ln -sf "${HOME}/.termux/motd.sh" "${PREFIX:-/data/data/com.termux/files/usr}/etc/motd.sh"
}

install_ohmyzsh() {
	printf "%b %s...\n" "${badge_ok}" "${LANG_STRINGS[6]}"
	clone_or_update_repo "https://github.com/ohmyzsh/ohmyzsh.git" "${HOME}/.oh-my-zsh"

	local zsh_custom="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"

	printf "%b %s...\n" "${badge_ok}" "${LANG_STRINGS[7]}"
	clone_or_update_repo "https://github.com/romkatv/powerlevel10k.git" "${zsh_custom}/themes/powerlevel10k" "1"

	printf "%b %s...\n" "${badge_ok}" "${LANG_STRINGS[8]}"
	clone_or_update_repo "https://github.com/zsh-users/zsh-autosuggestions.git" "${zsh_custom}/plugins/zsh-autosuggestions"
	clone_or_update_repo "https://github.com/zsh-users/zsh-syntax-highlighting.git" "${zsh_custom}/plugins/zsh-syntax-highlighting"
	clone_or_update_repo "https://github.com/Aloxaf/fzf-tab.git" "${zsh_custom}/plugins/fzf-tab"

	printf "%b %s...\n" "${badge_ok}" "${LANG_STRINGS[9]}"
	backup_item "${HOME}/.zshrc"
	cp -f "${SCRIPT_DIR}/OhMyZsh/zshrc" "${HOME}/.zshrc"

	arch_type="$(dpkg --print-architecture 2>/dev/null || uname -m)"
	if [[ "${arch_type}" == "arm" || "${arch_type}" == *"armv7"* ]]; then
		printf "%b %s!\n" "${badge_warn}" "${LANG_STRINGS[10]}"
		if ! grep -q "POWERLEVEL9K_DISABLE_GITSTATUS=true" "${HOME}/.zshrc"; then
			printf "\n# Disable gitstatus for armv7 devices\nPOWERLEVEL9K_DISABLE_GITSTATUS=true\n" >> "${HOME}/.zshrc"
		fi
	fi
	chmod +rwx "${HOME}/.zshrc"

	if [[ -f "${SCRIPT_DIR}/OhMyZsh/zsh_history" ]]; then
		printf "%b %s...\n" "${badge_ok}" "${LANG_STRINGS[11]}"
		backup_item "${HOME}/.zsh_history"
		cp -f "${SCRIPT_DIR}/OhMyZsh/zsh_history" "${HOME}/.zsh_history"
		chmod +rw "${HOME}/.zsh_history"
	fi

	if [[ -f "${SCRIPT_DIR}/OhMyZsh/custom_aliases.zsh" ]]; then
		printf "%b %s...\n" "${badge_ok}" "${LANG_STRINGS[12]}"
		backup_item "${zsh_custom}/custom_aliases.zsh"
		cp -f "${SCRIPT_DIR}/OhMyZsh/custom_aliases.zsh" "${zsh_custom}/custom_aliases.zsh"
	fi

	printf "%b %s...\n" "${badge_ok}" "${LANG_STRINGS[13]}"
	backup_item "${HOME}/.p10k.zsh"
	cp -f "${SCRIPT_DIR}/OhMyZsh/p10k.zsh" "${HOME}/.p10k.zsh"
	printf "%b %s!\n" "${badge_ok}" "${LANG_STRINGS[14]}"
}

install_cli_tools() {
	printf "%b Installing CLI management tools...\n" "${badge_ok}"
	mkdir -p "${HOME}/bin"
	for cli_script in "${SCRIPT_DIR}/bin"/*; do
		local script_name
		script_name="$(basename "${cli_script}")"
		ln -sf "${cli_script}" "${HOME}/bin/${script_name}"
		chmod +x "${cli_script}"
	done

	# Install MOTD modules
	mkdir -p "${HOME}/.termux/motd"
	cp -f "${SCRIPT_DIR}/motd"/*.sh "${HOME}/.termux/motd/"
	chmod +x "${HOME}/.termux/motd"/*.sh

	# Install Zsh completion plugin
	local zsh_custom="${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"
	if [[ -d "${zsh_custom}" ]]; then
		mkdir -p "${zsh_custom}/plugins/termux"
		cp -f "${SCRIPT_DIR}/OhMyZsh/plugins/termux/_termux" "${zsh_custom}/plugins/termux/_termux"
	fi
}

finish_install() {
	if [ ! -d "${HOME}/.config" ]; then
		mkdir -p "${HOME}/.config"
	fi
	backup_item "${HOME}/.config/lf"
	cp -fr "${SCRIPT_DIR}/lf" "${HOME}/.config/lf"

	arch_type="$(dpkg --print-architecture 2>/dev/null || uname -m)"
	if [[ "${arch_type}" == "arm" || "${arch_type}" == *"armv7"* ]]; then
		rm -rf "${HOME}/.cache/gitstatus"
	fi

	printf "%b %s...\n" "${badge_ok}" "${LANG_STRINGS[15]}"
	if command -v chsh &>/dev/null; then
		chsh -s zsh || true
	fi

	if command -v termux-setup-storage &>/dev/null; then
		termux-setup-storage || true
	fi

	if command -v termux-reload-settings &>/dev/null; then
		termux-reload-settings || true
	fi

	printf "\n"
	printf "${green}┌────────────────────────────────────────────────────────────┐${nocol}\n"
	printf "${green}│${nocol} ${bold}Termux-Zsh Installation Complete!${nocol}                         ${green}│${nocol}\n"
	printf "${green}└────────────────────────────────────────────────────────────┘${nocol}\n"
	if [[ -d "${BACKUP_DIR}" ]]; then
		printf "%b Saved timestamped backup to: %s\n" "${badge_warn}" "${BACKUP_DIR}"
	fi
	printf "%b %s!\n\n" "${badge_ok}" "${LANG_STRINGS[17]}"
}

main() {
	printf "\n"
	printf "${cyan}┌────────────────────────────────────────────────────────────┐${nocol}\n"
	printf "${cyan}│${nocol}                   ${bold}Termux-Zsh Setup Menu${nocol}                    ${cyan}│${nocol}\n"
	printf "${cyan}├────────────────────────────────────────────────────────────┤${nocol}\n"
	printf "${cyan}│${nocol}  [${green}1${nocol}]  ${COMMON_STRINGS[3]} (Zsh + P10k + Themes + Fonts + LF)        ${cyan}│${nocol}\n"
	printf "${cyan}│${nocol}  [${green}2${nocol}]  ${COMMON_STRINGS[6]}                                              ${cyan}│${nocol}\n"
	printf "${cyan}└────────────────────────────────────────────────────────────┘${nocol}\n"

	printf "\n"
	read -p "> " choice || choice="1"

	case "${choice}" in
		1)
			install_dependencies
			install_optional_modern_tools
			configure_termux
			install_ohmyzsh
			install_cli_tools
			finish_install
			exit 0
			;;
		2)
			printf "%b %s!\n" "${badge_fail}" "${LANG_STRINGS[19]}"
			exit 1
			;;
		*)
			printf "%b %s!\n" "${badge_fail}" "${LANG_STRINGS[20]}"
			exit 1
			;;
	esac
}

main "${@}"
