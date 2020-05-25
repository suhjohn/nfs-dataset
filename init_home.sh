
#!/bin/bash

USERNAME=$1
PROJECT_NAME=$(/bin/ls /proj)
NFS_SHARED_HOME_DIR=/proj/${PROJECT_NAME}/workspaces

sudo /bin/cp /local/repository/.bashrc $NFS_SHARED_HOME_DIR/${USERNAME}/
sudo /bin/cp /local/repository/init_repo.sh $NFS_SHARED_HOME_DIR/${USERNAME}/

if [ $(hostname --short) == "nfs" ]
then
    usermod --move-home --home $NFS_SHARED_HOME_DIR/${USERNAME} ${USERNAME}
else
    usermod --home $NFS_SHARED_HOME_DIR/${USERNAME} ${USERNAME}
fi

# Setup password-less ssh between nodes
mkdir $NFS_SHARED_HOME_DIR/${USERNAME}/.ssh
sudo /bin/cp /local/repository/config $NFS_SHARED_HOME_DIR/${USERNAME}/.ssh/

if [ $(hostname --short) == "nfs" ]
then
  ssh_dir=$NFS_SHARED_HOME_DIR/$USERNAME/.ssh
  /usr/bin/geni-get key > $ssh_dir/id_rsa
  chmod 600 $ssh_dir/id_rsa
  chown $USERNAME: $ssh_dir/id_rsa
  ssh-keygen -y -f $ssh_dir/id_rsa > $ssh_dir/id_rsa.pub
  cat $ssh_dir/id_rsa.pub >> $ssh_dir/authorized_keys
  chmod 644 $ssh_dir/authorized_keys
fi
