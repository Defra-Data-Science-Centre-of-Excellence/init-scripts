#!/bin/bash
set -ex
echo $DB_CLUSTER_NAME
URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/main/src

wget $URL/rootcert.sh -O- | bash
wget $URL/update.sh -O- | bash 
if [[ "$DB_CLUSTER_NAME" == *"RStu"* ]]; then  # If RStu in cluster name
  wget $URL/base_libs.sh -O- | bash
fi
if [[ "$DB_CLUSTER_NAME" == *"Geo"* ]]; then  # If Geo in cluster name
  wget $URL/gis_libs.sh -O- | bash
fi
