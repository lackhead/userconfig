#!/usr/bin/env bash
#
# This script installs the dotfiles I use for my shell(s) and

#
set -e

# temp directory to pull git files into
TEMPDIR="${HOME}/dotfiles_tmp"

# where does the sparse repo live
REPODIR="${HOME}/.dotconf"

if [ -d ${TEMPDIR} ]; then
   echo "${TEMPDIR} already exists! Please clean up manually."
   exit 1
fi

if [ -d ${REPODIR} ]; then
   echo "${REPODIR} already exists! Verify install manually."
   exit 0
fi

# Do the work
git clone --separate-git-dir=${REPODIR} git@github.com:lackhead/dotfiles ${TEMPDIR}
rsync --archive --verbose --exclude '.git' --exclude README.md --exclude LICENSE ${TEMPDIR}/ ${HOME}/
rm -rf ${TEMPDIR}
git --git-dir=${REPODIR} --work-tree=${HOME} config status.showUntrackedFiles no
git --git-dir=${REPODIR} --work-tree=${HOME} update-index --assume-unchanged README.md LICENSE
