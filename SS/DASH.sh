#!/bin/bash
set -ex
echo $DB_CLUSTER_NAME
URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/esd-init-scripts/main/src

wget $URL/rootcerts.sh -O- | bash
wget $URL/update.sh -O- | bash 
wget $URL/base_libs.sh -O- | bash
wget $URL/gis_libs.sh -O- | bash
