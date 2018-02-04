#!/usr/bin/env bash
#
# This script installs the ~/bin directory which contains
# scripts I've written. The assumption is that these files
# will be symlinked from ~/bin from the same directory as this
# script, although an optional argument of a directory
# will install there instead.

set -e

# what directory are we working out of
BIN_ROOT=$(cd $(dirname $0) && pwd -P)

# Global variables
CMDS_RUN=0
SKIPS=0
DEST_HOME=${HOME}
overwrite_all="false"
skip_all="false"
backup_all="false"
TEST="false"


#############
# FUNCTIONS #
#############

# Display function
fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

# This function takes a shell string and execs it, or prints it out if
# $TEST is set
execute () {
  local cmd=$1
  if [[ ${TEST} == "true" ]]; then
    echo "   $cmd"
  else
    echo -n $( echo ${cmd} | head -n1 | cut -d " " -f1 | sed 's/: $//g') ""
    eval "$cmd" || fail "Could not execute \"$cmd\"!"
    CMDS_RUN=$(( $CMDS_RUN + 1 ))
  fi
}

# This function will symlink a file; arguments are source file and destination
link_file () {
  local src=$1 dst=$2
  local overwrite= backup= skip= action=

  # skip if already linked
  if [ -L "$dst" ]; then
      if [ $(readlink $dst) == "$src" ]; then
         return
      fi
  fi

  if [ -e "$dst" ]; then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then

       echo "File already exists: $dst, what do you want to do?"
       echo "[s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
       read -n 1 action && echo
       case "$action" in
         o )
           overwrite=true;;
         O )
           overwrite_all=true;;
         b )
           backup=true;;
         B )
           backup_all=true;;
         s )
           skip=true;;
         S )
           skip_all=true;;
         * )
           ;;
       esac

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]; then
      if [ -d "$dst" ]; then
         echo "${dst} is a directory; ARE YOU SURE YOU WANT TO REMOVE IT? (Y/N)"
         read -n 1 action && echo
         case "$action" in
           y|Y* )
             ;;
           *)
             echo "skipping $src"
             SKIPS=$(( $SKIPS + 1 ))
             return
             ;;
         esac
      fi
      execute "rm -rvf $dst"
    fi

    if [ "$backup" == "true" ]; then
      execute "mv -v $dst ${dst}.backup"
    fi

    if [ "$skip" == "true" ]; then
      echo "skipping $src"
      SKIPS=$(( $SKIPS + 1 ))
    fi
  fi

  if [ "$skip" != "true" ]; then
    execute "ln -sv $1 $2"
  fi
}


#####################
# PROCESS ARGUMENTS #
#####################
while getopts "Bd:hOSt" opt $@; do
  case "$opt" in
    b) backup_all="true" ;;
    d) DEST_HOME=$(echo ${OPTARG} | sed 's:/$::') ;;
    o) overwrite_all="true" ;;
    s) skip_all="true" ;;
    t) TEST="true" ;;
    ?) echo ""
       echo "Usage: $(basename $0) [ -BOSt ] [ -d <dir> ]"
       echo ""
       echo "   -B   Backup all files/links that currently exist"
       echo "   -d   Install into <dir> instead of ${HOME}/bin"
       echo "   -O   overwrite all existing files without prompting"
       echo "   -S   Skip any existing files"
       echo "   -t   Test mode; show what would be done"
       echo ""
       exit
       ;;
  esac
done
shift $((OPTIND - 1))


#######################
# DO THE INSTALLATION #
#######################

# All files/directories that go in the dest should be prepended with a dot. Anything
# further underneath that should be linked as is

# create the bin directory if it doesn't exist
if [ ! -d "${DEST_HOME}/bin" ]; then
    if [[ ${TEST} == "true" ]]; then
        echo "   /bin/mkdir ${DEST_HOME}/bin"
    else
        /bin/mkdir ${DEST_HOME}/bin
    fi
fi

# create the directory structure
if [ "$TEST" == "true" ]; then
   ( cd ${BIN_ROOT} && find . -mindepth 1 -type d ! -name . | sed 's:/::1' | xargs -n1 -I {} echo "  " /bin/mkdir -p ${DEST_HOME}/{} )
else
   ( cd ${BIN_ROOT} && find . -mindepth 1 -type d ! -name . | sed 's:/::1' | xargs -n1 -I {} /bin/mkdir -p ${DEST_HOME}/{} )
fi

# for each item in this directory, link to the source
for file in $( cd ${BIN_ROOT} && find . -mindepth 1 -type f ! -name . ); do
    if [[ $(basename $file) == $(basename $0) ]]; then
       continue
    fi
    link_file ${BIN_ROOT}/$(echo $file | sed 's:^./::') ${DEST_HOME}/bin/$(echo $file | sed 's:^./::')
    # force the right perms
    if [ "$TEST" == "true" ]; then
        echo "  " /bin/chmod 0755 ${DEST_HOME}/bin/$(echo $file | sed 's:^./::')
    else
        /bin/chmod -v 0755 ${DEST_HOME}/bin/$(echo $file | sed 's:^./::')
    fi
done



# Exit out
if [[ ${TEST} == "true" ]]; then
   echo "   Test run complete"
   exit
elif [[ "$CMDS_RUN" -eq 0 ]]; then
   echo -n "Nothing to do; everything up to date "
fi
if [[ "$SKIPS" -ne 0 ]]; then
     echo -n "(${SKIPS} files skipped)"
fi
echo

