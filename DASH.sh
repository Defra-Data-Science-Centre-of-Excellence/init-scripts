#!/bin/bash
set -ex
echo $DB_CLUSTER_NAME

# Optional cscrootcerts.crt path
CERT_PATH=

URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/main/src
wget $URL/rootcert.sh -O- | bash -ex
wget $URL/update.sh -O- | bash  -ex
wget $URL/base_libs.sh -O- | bash  -ex
if [[ "$DB_CLUSTER_NAME" == *"RStu"* ]]; then  # If RStu in cluster name
  wget -qO- $URL/r_installs.R | Rscript -
fi
if [[ "$DB_CLUSTER_NAME" == *"Geo"* ]]; then  # If Geo in cluster name
  wget $URL/sedona.sh -O- | bash -ex
  wget $URL/mosaic.sh -O- | bash -ex
fi
