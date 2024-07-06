# MacOs Bootstrap scripts

## Info

Set of scripts to bootstrap

## Preconditions

1. make sure the file is executable | chmod +x macOsBootstrap.sh
2. Your password may be necessary for some packages
3. https://docs.brew.sh/Installation#macos-requirements | xcode-select --install
   (_xcode-select installation_ installs git already, however git will be installed via brew packages as well to install as much as possible the brew way
   this way you benefit from frequent brew updates)
4. don't let the “Operation not permitted” error bite you
   Please make sure you system settings allow the termianl full disk access
   https://osxdaily.com/2018/10/09/fix-operation-not-permitted-terminal-error-macos/

## Dotfiles

**SSH Folder Info** Keys and know_hosts are ignored, import keys from a _know_location_ and look for a _README_ file for permissions

## Fonts and iterm2 theme

- Download fonts from: [JetBrainsMono](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip)
- Import the profile named _iterm2-fabio.json_
