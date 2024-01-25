#!/bin/bash
set -ex
echo $DB_CLUSTER_NAME
URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/esd-init-scripts/main/src

wget $URL/rootcerts.sh -O- | bash
wget $URL/update.sh -O- | bash 
wget $URL/c_dependencies.sh -O- | bash
wget $URL/sedona_151.sh -O- | bash

# other libraries
pip install pyogrio==0.7.2