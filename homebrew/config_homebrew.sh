#!/usr/bin/env bash
#
# install_homebrew.sh
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

set -e

# Check for Mac
if test "$(uname)" = "Darwin"
then

   # Check for Homebrew
   if test ! $(which brew); then
      echo "Installing Homebrew..."
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
   else
      echo "Homebrew already installed at" $(which brew)
   fi

   # Make sure we're up to date
   echo "Updating all brews..."
   brew upgrade

   # Add some casks
   brew tap "homebrew/bundle"

   # Applications
   echo "Installing applications..."
   brew install --cask --appdir="/Applications" vlc
   brew install --cask --appdir="/Applications" jumpcut
   brew install --cask --appdir="/Applications" skim
   brew install --cask --appdir="/Applications" spotify
   brew install --cask --appdir="/Applications" sublime-text
   brew install --cask --appdir="/Applications" vlc
   brew install --cask --appdir="/Applications" iterm2

   # Utilities
   echo "Installing utilities..."
   brew install "ack"
   brew install "coreutils"
   brew install "curl"
   brew install "dict"
   brew install "git"
   brew install "gettext"
   brew install "git"
   brew install "gnupg"
   brew install "imagemagick"
   brew install "mplayer"
   brew install "ncftp"
   brew install "nmap"
   brew install "pwgen"
   brew install "rcs"
   brew install "telnet"
   brew install "rar"
   brew install "wget"
   brew install "youtube-dl"
   brew install "vivid" 

   # Cleanup
   brew cleanup
   /bin/rm -f -r /Library/Caches/Homebrew/*

else
   echo "I only install Homebrew on Mac systems"
fi

exit 0
