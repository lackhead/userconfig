# Chad Lake's User Configuration

Here you will find the files and notes I use to setup and config my working
environment, including my shell and my system (Mac). There really isn't anything
magical here but I find it useful when jumping around on new systems.

There are a few sections/directories:

## macos

The config_macos.sh script will write defaults to the MacOS environment to set up
things like hot corners, Finder prefs, etc. For the most part this really only
needs to be run once per user.

## dotfiles

This is where general dotfiles are kept. Any file that is in this directory (except
for the install_dotfiles.sh script) are linked into the user's home directory. This
includes directories as well (directory structures are mirrored and only individual
files are symlinked). Any existing files can be skipped, backed up, or overwritten.
Run install-dotfiles.sh -h for more details.

## homebrew

The install_homebrew.sh script will install homebrew (if necessary) and then check
to make sure everything in the Brewfile is installed on this system.

## bin

This is a directory that contain some personal scripts I have written that were
significant enough to exist outside of a simple shell alias/function.






