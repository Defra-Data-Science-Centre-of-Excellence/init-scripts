#!/bin/bash
set -ex
echo $DB_CLUSTER_NAME


rootcert=/dbfs/databricks/scripts/rootcert.sh
if  [[ -f $rootcert ]]; then  # If file exists
  . $rootcert  # Run file
fi


URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/main/src
wget $URL/update.sh -O- | bash  # Run URL script
wget $URL/base_libs.sh -O- | bash
if [[ "$DB_CLUSTER_NAME" == *"Geo"* ]]; then  # If Geo in cluster name
  wget $URL/gis_libs.sh -O- | bash
fi
