#!/bin/bash

USERNAME=$1

git clone https://github.com/suhjohn/lrb ~/lrb
cd ~/lrb
./setup.sh
if [ $(hostname --short) == "nfs" ]
then
#    python3 update_nodes.py $USERNAME
#    git add .
#    git commit -m "update with current node info"
#    git push
    script/git_pulling.sh > ~/git_pulling.log &
    disown
fi