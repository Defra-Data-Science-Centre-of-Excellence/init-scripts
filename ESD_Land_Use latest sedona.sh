#!/bin/bash
set -ex
echo $DB_CLUSTER_NAME
URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/esd-init-scripts/main/src

wget $URL/rootcert.sh -O- | bash -ex
wget $URL/update.sh -O- | bash -ex
wget $URL/c_dependencies.sh -O- | bash -ex
wget $URL/sedona_151.sh -O- | bash -ex

pip install /Workspace/Shared/python_libraries/sds_dash_download-0.1.0-py3-none-any.whl
