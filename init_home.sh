
#!/bin/bash

USERNAME=$1
PROJECT_NAME=$(/bin/ls /proj)
NFS_SHARED_HOME_DIR=/proj/${PROJECT_NAME}/workspaces/
NEW_HOME=$NFS_SHARED_HOME_DIR/${USERNAME}

sudo /bin/cp /local/repository/.bashrc $NEW_HOME
sudo /bin/cp /local/repository/init_repo.sh $NEW_HOME

if [ $(hostname --short) == "nfs" ]
then
    usermod --move-home --home $NEW_HOME ${USERNAME}
else
    usermod --home $NEW_HOME ${USERNAME}
fi

# Setup password-less ssh between nodes
mkdir $$NEW_HOME/.ssh
sudo /bin/cp /local/repository/config $NEW_HOME/.ssh/

if [ $(hostname --short) == "nfs" ]
then
  ssh_dir=$NEW_HOME/.ssh
  /usr/bin/geni-get key > $ssh_dir/id_rsa
  chmod 600 $ssh_dir/id_rsa
  chown $USERNAME: $ssh_dir/id_rsa
  ssh-keygen -y -f $ssh_dir/id_rsa > $ssh_dir/id_rsa.pub
  cat $ssh_dir/id_rsa.pub >> $ssh_dir/authorized_keys
  chmod 644 $ssh_dir/authorized_keys
fi
