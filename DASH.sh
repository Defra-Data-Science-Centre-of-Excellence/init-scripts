#!/bin/bash
set -ex
echo $DB_CLUSTER_NAME
URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/pantelisindefra-patch-1/src

wget $URL/rootcerts.sh -O- | bash
wget $URL/update.sh -O- | bash 
wget $URL/base_libs.sh -O- | bash 

if [[ "$DB_CLUSTER_NAME" == *"Rlang"* ]]; then  # If Rlang in cluster name
  wget -qO- $URL/r_installs.R | Rscript - 
fi

if [[ "$DB_CLUSTER_NAME" == *"Geo"* ]]; then  # If Geo in cluster name
  wget $URL/gis_libs.sh -O- | bash
fi
