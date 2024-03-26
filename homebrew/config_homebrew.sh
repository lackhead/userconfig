#!/usr/bin/env bash
#
# install_homebrew.sh
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.

set -e

# find out how to output bold
bold=$(tput bold)
normal=$(tput sgr0)

# Check for Mac
if test "$(uname)" = "Darwin"
then

   # Check for Homebrew
   if test ! $(which brew); then
      echo "Installing Homebrew..."
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   fi

   # Make sure we're up to date
   brew update

   # Add some casks
   brew tap "homebrew/bundle"

   # Applications
   for app in vlc jumpcut skim spotify sublime-text iterm2; do
      if $(brew list ${app} &>/dev/null); then
         echo "${bold}${app}${normal} already installed"
      else
         brew install --cask --appdir="/Applications" ${app}
      fi
   done

   # Utilities
   for util in ack coreutils curl dict git gettext gnupg imagemagick mplayer ncftp nmap pwgen rcs telnet rar wget youtube-dl vivid; do
      if $(brew list ${util} &>/dev/null); then
         echo "${bold}${util}${normal} already installed"
      else
         brew install ${util}
      fi
   done

   # Upgrades
   brew upgrade

   # Cleanup
   brew cleanup -s

else
   echo "I only install Homebrew on Mac systems"
fi

exit 0
