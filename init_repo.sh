#!/bin/bash

USERNAME=$1

cd $WEBCACHESIM_ROOT
git config credential.helper store

python3 /local/repository/update_nodes.py $USERNAME
git add .
git commit -m "update with current node info"
git push
mkdir $XDG_CONFIG_HOME
mkdir $XDG_CONFIG_HOME/git
mv ~/.git-credentials $XDG_CONFIG_HOME/git
mv $XDG_CONFIG_HOME/git/.git-credentials $XDG_CONFIG_HOME/git/credentials
script/git_pulling.sh > ~/git_pulling.log &
disown
