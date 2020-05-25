#!/bin/bash

USERNAME=$1

cd $WEBCACHESIM_ROOT
python3 /local/repository/update_nodes.py
git add .
git commit -m "update with current node info"
git push
script/git_pulling.sh > ~/git_pulling.log &
disown
