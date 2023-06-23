#!/bin/bash
set -ex

URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/aw-dev

wget $URL/rootcert.sh -O- | bash
# . $DIR/update.sh
# . $DIR/base_libs.sh
# if [[ "$DB_CLUSTER_ID" == *"Geo"* ]]; then
#   . $DIR/gis_libs.sh
# fi
