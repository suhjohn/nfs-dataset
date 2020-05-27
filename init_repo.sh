#!/bin/bash

git clone https://github.com/suhjohn/lrb ~/lrb
cd ~/lrb
./setup.sh
cd $WEBCACHESIM_ROOT
python3 /local/repository/update_nodes.py
