#!/bin/bash
echo "check_certificate = off" >> ~/.wgetrc

URL=http://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/main
wget -O- $URL/src/update.sh | bash
wget -O- $URL/src/base_libs.sh | bash
(sudo crontab -l | sed '/^#/d'; echo "@monthly wget -qO- $URL/src/update.sh | bash") | uniq | sudo crontab -
