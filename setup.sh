#!/bin/bash

USERNAME=$1
PROJECT_NAME=$(/bin/ls /proj)
NFS_SHARED_HOME_DIR=/proj/${PROJECT_NAME}/workspaces

git clone https://github.com/suhjohn/lrb $NFS_SHARED_HOME_DIR/${USERNAME}/lrb
cd $NFS_SHARED_HOME_DIR/${USERNAME}/lrb
./setup.sh