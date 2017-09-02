#!/bin/sh
#
# This script sets some defaults for MacOS to get things tweaked
# just the way I like 'em.
#
# Shout out to Mathias Bynens who came up with the idea and the
# settings:
#   https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
/usr/bin/sudo -v

#######################################################
# General Options                                     #
#######################################################
echo "Setting general options"

# Disable press-and-hold for keys in favor of key repeat.
/usr/bin/defaults write -g ApplePressAndHoldEnabled -bool false

# Use AirDrop over every interface. srsly this should be a default.
/usr/bin/defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# Set a really fast key repeat.
/usr/bin/defaults write NSGlobalDomain KeyRepeat -int 2

# set shell to zsh
/usr/bin/chsh -s /bin/zsh


#######################################################
# Time Machine.                                       #
#######################################################
echo "Setting Time Machine preferences"

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Disable local Time Machine backups
hash tmutil &> /dev/null && sudo tmutil disablelocal


#######################################################
# Trackpad.                                           #
#######################################################
echo "Setting Trackpad preferences"

# Tap with two fingers to emulate right click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true


#######################################################
# Finder                                              #
#######################################################
echo "Setting Finder preferences"

# Show the ~/Library and /Volumes folders
chflags nohidden ~/Library
sudo chflags nohidden /Volumes

# Set the Finder prefs for showing a few different volumes on the Desktop.
/usr/bin/defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
/usr/bin/defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Always open everything in Finder's list view. This is important.
/usr/bin/defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# New window points to home
defaults write com.apple.finder NewWindowTarget -string "PfHm"

# show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true


#######################################################
# Hot Corners.                                        #
#######################################################
echo "Setting up hot corners"

# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center

# Run the screensaver if we're in the bottom-left corner
/usr/bin/defaults write com.apple.dock wvous-bl-corner -int 5
/usr/bin/defaults write com.apple.dock wvous-bl-modifier -int 0

# Disable the screensaver if we're in the upper-right corner
/usr/bin/defaults write com.apple.dock wvous-ur-corner -int 5
/usr/bin/defaults write com.apple.dock wvous-ur-modifier -int 0

# Show Desktop in the bottom right corner
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0


#######################################################
# CD/DVD                                              #
#######################################################
echo "Setting CD & DVD preferences"

# Disable blank CD automatic action.
defaults write com.apple.digihub com.apple.digihub.blank.cd.appeared -dict action 1

# Disable music CD automatic action.
defaults write com.apple.digihub com.apple.digihub.cd.music.appeared -dict action 1

# Disable picture CD automatic action.
defaults write com.apple.digihub com.apple.digihub.cd.picture.appeared -dict action 1

# Disable blank DVD automatic action.
defaults write com.apple.digihub com.apple.digihub.blank.dvd.appeared -dict action 1

# Disable video DVD automatic action.
defaults write com.apple.digihub com.apple.digihub.dvd.video.appeared -dict action 1


#######################################################
# CD/DVD                                              #
#######################################################
echo "Setting Photos preferences"

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true


#######################################################
# Dock                                                #
#######################################################
echo "Setting Dock preferences"

# Position (left, bottom, right)
defaults write com.apple.dock orientation -string "right"

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true



#######################################################
# We're done                                          #
#######################################################
echo "Customization complete."
echo "Note that some of these changes require a logout/restart to take effect."
