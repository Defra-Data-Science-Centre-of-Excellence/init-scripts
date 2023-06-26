#!/bin/bash
set -ex
echo $DB_CLUSTER_NAME

URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/aw-dev/src

rootcert=/dbfs/databricks/init-scripts/rootcert.sh
if  [[ -f $rootcert ]]; then
  . $rootcert
fi
wget $URL/update.sh -O- | bash
wget $URL/base_libs.sh -O- | bash
if [[ "$DB_CLUSTER_NAME" == *"Geo"* ]]; then
  wget $URL/gis_libs.sh -O- | bash
fi
