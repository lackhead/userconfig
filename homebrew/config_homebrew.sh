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

   # # Invoke the Brewfile; given as option or assumed to be in the same directory
   # # as this script
   # if test -z "$1"; then
   #    # no argument given, look for the Brewfile in the directory I am in
   #    bfdir=$(cd $(dirname $0) && pwd -P)
   # else
   #    bfdir=$(dirname $1)
   # fi
   # echo "Installing any needed brews/casks..."
   # (cd $bfdir &>/dev/null && brew bundle)
   # Upgrade any already-installed formulae.

   # Make sure we're up to date
   echo "Updating all brews..."
   brew upgrade --all

   # Add some casks
   brew tap "caskroom/cask"
   brew tap "homebrew/bundle"
   brew tap "homebrew/core"

   # Applications
   echo "Installing applications..."
   brew cask install --appdir="/Applications" google-drive
   brew cask install --appdir="/Applications" google-chrome
   brew cask install --appdir="/Applications" firefox
   brew cask install --appdir="/Applications" dropbox
   brew cask install --appdir="/Applications" slack
   brew cask install --appdir="/Applications" vlc
   brew cask install --appdir="/Applications" flux
   brew cask install --appdir="/Applications" appcleaner
   brew cask install --appdir="/Applications" android-file-transfer
   brew cask install --appdir="/Applications" backblaze
   brew cask install --appdir="/Applications" backblaze-downloader
   brew cask install --appdir="/Applications" chessx
   brew cask install --appdir="/Applications" firefox
   brew cask install --appdir="/Applications" google-chrome
   brew cask install --appdir="/Applications" istat-menus
   brew cask install --appdir="/Applications" little-snitch
   brew cask install --appdir="/Applications" jumpcut
   brew cask install --appdir="/Applications" karabiner
   brew cask install --appdir="/Applications" micro-snitch
   brew cask install --appdir="/Applications" skim
   brew cask install --appdir="/Applications" slack
   brew cask install --appdir="/Applications" spotify
   brew cask install --appdir="/Applications" sublime-text
   brew cask install --appdir="/Applications" swinsian
   brew cask install --appdir="/Applications" vlc

   # Utilities
   echo "Installing utilities..."
   brew install "ack"
   brew install "coreutils"
   brew install "curl"
   brew install "dict"
   brew install "dirmngr"
   brew install "git"
   brew install "ffmpeg"
   brew install "flac"
   brew install "freetype"
   brew install "geckodriver"
   brew install "gettext"
   brew install "git"
   brew install "gnupg"
   brew install "gpg-agent"
   brew install "httpie"
   brew install "id3v2"
   brew install "imagemagick"
   brew install "karabiner"
   brew install "libusb-compat"
   brew install "lame"
   brew install "mplayer"
   brew install "ncftp"
   brew install "nmap"
   brew install "pwgen"
   brew install "python3"
   brew install "rcs"
   brew install "stockfish"
   brew install "telnet"
   brew install "unrar"
   brew install "wget"
   brew install "youtube-dl"

   # Cleanup
   brew cleanup
   /bin/rm -f -r /Library/Caches/Homebrew/*

else
   echo "I only install Homebrew on Mac systems"
fi

exit 0
