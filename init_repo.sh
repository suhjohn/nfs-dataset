#!/bin/bash

git clone https://github.com/suhjohn/lrb ~/lrb
cd ~/lrb
git checkout daniel
./setup.sh
cd $WEBCACHESIM_ROOT
python3 /local/repository/update_nodes.py
python3 /local/repository/test_node_setup_correct.py