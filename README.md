# macOS Bootstrap scripts

Scripts to bootstrap my work machine. Goal: if this MacBook dies, it can be
rebuilt from public repos (this one + the dotfiles repo) plus the NAS, ending up
almost ready to work.

## Preconditions

1. Make the scripts executable: `chmod +x *.sh`
2. Your password may be required for some packages (casks that run installers).
3. Install Xcode Command Line Tools: `xcode-select --install`
   (installs git, but git is also installed via Homebrew to benefit from brew updates).
4. Grant the terminal **Full Disk Access** to avoid the "Operation not permitted"
   error (System Settings → Privacy & Security → Full Disk Access).

## Scripts (run in order)

| Order | Script           | Description                                                          |
| ----- | ---------------- | ------------------------------------------------------------------- |
| 1     | macosBootsrap.sh | Xcode CLT + Homebrew, then `brew bundle install` from the Brewfile  |
| 2     | ohMyZsh.sh       | Unattended Oh My Zsh install                                        |
| 3     | dotfiles.sh      | Clone dotfiles to `~/Projects/dotfiles` and stow every package      |

## Brewfile (source of truth for packages)

The `Brewfile` declares everything installed via Homebrew: formulae, casks,
Mac App Store apps (via `mas`) and VS Code extensions.

- Install everything: `brew bundle install --file Brewfile`
- Regenerate from the current machine: `brew bundle dump --file Brewfile --force`

**Mac App Store apps:** you must be signed in to the App Store for the `mas`
lines (e.g. WireGuard) to install.

## Dotfiles

Managed with GNU Stow. The repo lives in `~/Projects/dotfiles` and ships a
`.stowrc` (`--target=~`); `dotfiles.sh` runs `stow */` to symlink every package
into `$HOME` (e.g. `zsh/.zshrc` → `~/.zshrc`).

**SSH keys:** NOT in the repo — they are managed by **1Password** (SSH agent via
`IdentityAgent` in `ssh/.ssh/config`). Nothing to import by hand: sign in to
1Password and enable its SSH agent.

## Fonts & iTerm2 theme

- **Font:** [JetBrains Mono Nerd Font](https://github.com/ryanoasis/nerd-fonts/releases/latest)
  (`font-monaspace` is also in the Brewfile).
- **iTerm2 profile:** import `iterm2-fabio.json`
  (Settings → Profiles → Other Actions… → Import JSON Profiles). It is the full
  profile — font, keymaps, behaviours and the JetBrains **Islands** colors for
  both light and dark mode (follows the macOS appearance automatically).
