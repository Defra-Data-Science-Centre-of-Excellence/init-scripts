#!/bin/bash
set -x
echo $DB_CLUSTER_NAME
URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/main/src

wget $URL/rootcert.sh -O- | bash
wget $URL/update.sh -O- | bash 
wget $URL/base_libs.sh -O- | bash
wget $URL/gis_libs.sh -O- | bash
