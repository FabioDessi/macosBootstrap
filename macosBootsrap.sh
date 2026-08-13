#!/bin/bash
# http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

# Variables
HOMEBREW_BIN_PATH="/opt/homebrew/bin/brew"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="${SCRIPT_DIR}/Brewfile"

# Ensure Apple's command line tools are installed
if ! xcode-select -p &>/dev/null; then
  echo "Xcode Command Line Tools not found. Installing..."
  xcode-select --install

  # Wait until the Command Line Tools are installed with a timeout
  max_retries=60 # Number of retries (5 seconds each, total 5*60 = 300 seconds)
  count=0
  until xcode-select -p &>/dev/null; do
    sleep 5
    ((count++))
    if [[ $count -ge $max_retries ]]; then
      echo "Timeout reached. Installation may have failed."
      break
    fi
  done

  if xcode-select -p &>/dev/null; then
    echo "Xcode Command Line Tools installed."
  else
    echo "Failed to confirm installation of Xcode Command Line Tools."
  fi
else
  echo "Xcode Command Line Tools are already installed."
fi

# Check for Homebrew, install if not installed
if ! command -v brew &>/dev/null; then
  echo "Downloading Homebrew installation script..."
  curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh -o install_homebrew.sh
  if [ $? -eq 0 ]; then
    echo "Installing Homebrew..."
    /bin/bash install_homebrew.sh

    # Add Homebrew to PATH by updating .zprofile for zsh
    echo "Configuring Homebrew in zsh environment..."
    echo -e "\neval \"\$($HOMEBREW_BIN_PATH shellenv)\"" >>~/.zprofile
    eval "$($HOMEBREW_BIN_PATH shellenv)"

    echo "Verifying Homebrew installation..."
    max_retries=30 # Total timeout 150 seconds (5 seconds each)
    count=0
    until command -v brew &>/dev/null; do
      sleep 5
      ((count++))
      if [[ $count -ge $max_retries ]]; then
        echo "Timeout reached. Homebrew installation may have failed."
        exit 1
      fi
    done
    echo "Homebrew installed successfully."
  else
    echo "Failed to download Homebrew installation script."
    exit 1
  fi
else
  echo "Homebrew is already installed."
fi

brew update

# Install everything declared in the Brewfile: formulae, casks, Mac App Store
# apps (via mas) and VS Code extensions. Regenerate it anytime with:
#   brew bundle dump --file Brewfile --force
# NOTE: the Mac App Store apps (mas) require being signed in to the App Store;
# those lines will fail (and be reported) if you are not signed in yet.
echo "Installing packages from Brewfile..."
brew bundle install --file="$BREWFILE"

# Cleanup old packages
brew cleanup

echo "Installation of applications complete! Run ohMyZsh.sh next."
