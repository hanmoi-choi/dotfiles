#!/usr/bin/env zsh

# author: Filipe Silva (ninrod)

SCRIPTPATH=$(cd $(dirname $0); pwd -P) && cd $SCRIPTPATH
GIT_ROOT=$(git rev-parse --show-toplevel)
source $GIT_ROOT/zsh/termcolors.zsh

if emacsclient.sh -e "(ignore)" > /dev/null 2>&1; then
  echo -e "emacs daemon is already ${Green}up${Rst}, nothing to do."
  exit 0
else
  echo -e "emacs daemon is ${Red}killed${Rst}. Let us ${Green}ressurect${Rst} it..."
fi


# lang has to be pt_BR.UTF-8 by this point
# LANG=pt_BR.UTF-8
emacs.sh --daemon; rc=$?
if [[ ! $rc = 0 ]]; then
  echo -e "there was a ${Red}problem${Rst} starting emacs daemon: $rc"
  exit $rc
else
  echo -e "emacs daemon ${Blue}started${Rst}. success."
fi

boostrap_time=$(emacsclient.sh -e "(emacs-init-time)")
echo -e "emacs daemon boostrap time: ${Cyan}${boostrap_time}${Rst}"