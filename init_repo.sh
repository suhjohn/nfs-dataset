#!/bin/bash

USERNAME=$1

cd $WEBCACHESIM_ROOT
git config credential.helper store
git fetch

mkdir $XDG_CONFIG_HOME
mkdir $XDG_CONFIG_HOME/git
mv ~/.git-credentials $XDG_CONFIG_HOME/git/credentials

if [ $(hostname --short) == "nfs" ]
then
    python3 /local/repository/update_nodes.py $USERNAME
    git add .
    git commit -m "update with current node info"
    git push
    script/git_pulling.sh > ~/git_pulling.log &
    disown
fi