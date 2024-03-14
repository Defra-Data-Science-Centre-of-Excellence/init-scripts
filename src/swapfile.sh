#!/bin/bash
# Allow extra memory via a swapfile
# https://www.digitalocean.com/community/tutorials/how-to-add-swap-space-on-ubuntu-20-04
SIZE=16G
FILE=/swapfile
sudo fallocate -l $SIZE $FILE
sudo chmod 600 $FILE
sudo mkswap $FILE
sudo swapon $FILE
sudo cp /etc/fstab /etc/fstab.bak
echo "$FILE none swap sw 0 0" | sudo tee -a /etc/fstab
sudo sysctl vm.swappiness=10
echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.conf
sudo sysctl vm.vfs_cache_pressure=50
echo 'vm.vfs_cache_pressure=50' | sudo tee -a /etc/sysctl.conf
