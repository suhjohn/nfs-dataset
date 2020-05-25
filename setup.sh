#!/bin/bash

USERNAME=$1
PROJECT_NAME=$(/bin/ls /proj)
NFS_SHARED_HOME_DIR=/proj/${PROJECT_NAME}/workspaces

if [ $(hostname --short) == "nfs" ]
then
    git clone https://github.com/suhjohn/lrb $NFS_SHARED_HOME_DIR/${USERNAME}/lrb
else
    while [ ! -d "$NFS_SHARED_HOME_DIR/${USERNAME}/lrb" ]
    do
        sleep 5
    done
fi


cd $NFS_SHARED_HOME_DIR/${USERNAME}/lrb
./setup.sh
