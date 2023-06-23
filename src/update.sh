#!/bin/bash
sudo rm -rf /var/lib/apt/lists/*
sudo apt-get update -y
sudo apt-get full-upgrade -y
sudo apt-get autoremove -y
sudo apt-get autopurge -y
sudo apt-get autoclean -y

# /databricks/python/bin/python -V
# . /databricks/conda/etc/profile.d/conda.sh
# conda activate /databricks/python

python -m pip install -U pip
pip list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1 | xargs -n1 python -m pip install -U 
