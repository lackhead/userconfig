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

   # Invoke the Brewfile; given as option or assumed to be in the same directory
   # as this script
   if test -z "$1"; then
      # no argument given, look for the Brewfile in the directory I am in
      bfdir=$(cd $(dirname $0) && pwd -P)
   else
      bfdir=$(dirname $1)
   fi
   echo "Installing any needed brews/casks..."
   (cd $bfdir &>/dev/null && brew bundle)

else
   echo "I only install Homebrew on Mac systems"
fi

exit 0
