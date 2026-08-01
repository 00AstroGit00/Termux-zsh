# You can set your custom aliases here

# Git
alias gc='git commit'
# Termux-zsh
alias color-changer='bash "${HOME}"/.termux/colors.sh'
alias font-changer='bash "${HOME}"/.termux/fonts.sh'
alias p10k-update='git -C "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"/themes/powerlevel10k pull'
alias custom-plugins-update='echo "Checking custom plugins for updates ..."; echo ""; for plugin_dir in "${ZSH_CUSTOM:-${HOME}/.oh-my-zsh/custom}"/plugins/*; do if [[ -d "${plugin_dir}/.git" && "$(basename "${plugin_dir}")" != "example" ]]; then echo "Checking $(basename "${plugin_dir}") ..."; git -C "${plugin_dir}" pull; echo ""; fi; done'
