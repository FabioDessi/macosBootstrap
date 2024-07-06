# MacOs Bootstrap scripts

## Info

Set of scripts to bootstrap my work machine. Below some notes to remember

### Preconditions

1. make sure the files are executable | chmod +x
2. Your password may be necessary for some packages
3. https://docs.brew.sh/Installation#macos-requirements | xcode-select --install
   (_xcode-select installation_ installs git already, however git will be installed via brew packages as well to install as much as possible the brew way
   this way you benefit from frequent brew updates)
4. don't let the “Operation not permitted” error bite you
   Please make sure you system settings allow the termianl full disk access
   https://osxdaily.com/2018/10/09/fix-operation-not-permitted-terminal-error-macos/

### Scripts description and order

| Order | Script name       | Description                                                         |
| ----- | ----------------- | ------------------------------------------------------------------- |
| 1     | macOsBootstrap.sh | Install Xcode command line tools, brew, and all formulaes and casks |
| 2     | ohMyZsh.sh        | Isolated oh my zsh install                                          |
| 3     | dotfiles.sh       | Clone dotfiles repo, cleanup and installation                       |

### Dotfiles

**SSH Folder Info** Keys and know hosts are ignored, import keys from a _know_location_ and look _README_ file for permissions info.

### Fonts and iterm2 theme

- Download fonts from: [JetBrainsMono](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip)
- Import the profile named _iterm2-fabio.json_
