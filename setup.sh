#!/bin/bash

USERNAME=$1
PROJECT_NAME=$(/bin/ls /proj)
NFS_SHARED_HOME_DIR=/proj/${PROJECT_NAME}/workspaces

if [ ! -d "$NFS_SHARED_HOME_DIR/${USERNAME}/lrb" ]
then
    sleep 60
fi

cd $NFS_SHARED_HOME_DIR/${USERNAME}/lrb
./setup.sh
