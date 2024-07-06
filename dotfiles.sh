#!/bin/bash
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# Define home, dotfiles and tmux directories
HOME_DIR="$HOME"
DOTFILES_DIR="${HOME_DIR}/.dotfiles"
TMUX_DIR="${DOTFILES_DIR}/.config/tmux"

# Clone repo
echo "Moving to ${HOME_DIR} and cloning dotfiles"
cd "${HOME_DIR}"
if [ -d "${DOTFILES_DIR}" ]; then
    echo "Dotfiles directory already exists. Skipping clone."
else
    git clone https://github.com/FabioDessi/dotfiles.git .dotfiles
fi

# Clean existing files
echo "Cleaning existing config files"
rm -rf "${HOME_DIR}/.config"

# Init stow
echo "Initialize stow"
cd "${DOTFILES_DIR}"
stow .

# Remove old .zprofile
cd "${HOME_DIR}"
rm -f "${HOME_DIR}/.zprofile"
source "${HOME_DIR}/.zshrc"

# tmux config
echo "Configuring tmux"
if [ -d "${TMUX_DIR}/plugins/tpm" ]; then
    echo "tmux tpm already cloned."
else
    git clone https://github.com/tmux-plugins/tpm "${TMUX_DIR}/plugins/tpm"
fi
tmux source "${TMUX_DIR}/tmux.conf"

echo "Dotfiles setup done."
echo "Remember to install TMUX plugins CTRL-A SHIFT-I."
echo "Download and install JetBrains Mono font and finish the setup importing iTerm2 profile."
echo "Look at README for info."
