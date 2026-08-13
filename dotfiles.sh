#!/bin/bash
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# Dotfiles are managed with GNU Stow. The repo lives in ~/Projects/dotfiles and
# ships a .stowrc (--target=~), so each top-level directory is a stow "package"
# symlinked into $HOME (e.g. zsh/.zshrc -> ~/.zshrc).
PROJECTS_DIR="${HOME}/Projects"
DOTFILES_DIR="${PROJECTS_DIR}/dotfiles"
TMUX_PLUGINS_DIR="${HOME}/.config/tmux/plugins"

mkdir -p "${PROJECTS_DIR}"

# Clone the dotfiles repo (SSH; fall back to HTTPS if no key is set up yet)
if [ -d "${DOTFILES_DIR}" ]; then
  echo "Dotfiles already present at ${DOTFILES_DIR}. Skipping clone."
else
  echo "Cloning dotfiles into ${DOTFILES_DIR}"
  git clone git@github.com:FabioDessi/dotfiles.git "${DOTFILES_DIR}" \
    || git clone https://github.com/FabioDessi/dotfiles.git "${DOTFILES_DIR}"
fi

# Stow every package. .stowrc handles --target=~ and the ignore rules.
# If stow reports conflicts with pre-existing files, resolve them by hand
# (back up / remove the offending target) and re-run `stow <package>`.
echo "Stowing dotfiles packages..."
cd "${DOTFILES_DIR}"
stow */

# tmux plugin manager. plugins/ is gitignored, so clone tpm after stow;
# it lands in the repo via the ~/.config/tmux symlink.
if [ -d "${TMUX_PLUGINS_DIR}/tpm" ]; then
  echo "tmux tpm already cloned."
else
  echo "Cloning tmux plugin manager (tpm)"
  git clone https://github.com/tmux-plugins/tpm "${TMUX_PLUGINS_DIR}/tpm"
fi

echo "Dotfiles setup done."
echo "Open a new shell so the stowed .zshrc is loaded."
echo "In tmux, install plugins with CTRL-A SHIFT-I."
echo "SSH keys are NOT in the repo: they live in 1Password (see ssh/.ssh/config)."
echo "Look at README for more info."
