#!/bin/bash
set -ex
echo $DB_CLUSTER_NAME
URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/esd-init-scripts/main/src

wget $URL/rootcerts.sh -O- | bash
wget $URL/update.sh -O- | bash 
wget $URL/c_dependencies.sh -O- | bash 
wget $URL/sedona_150.sh -O- | bash 

# pip install /Workspace/Shared/python_libraries/sds_dash_download-0.1.0-py3-none-any.whl /Workspace/Shared/python_libraries/sds_land_use_model-0.1.0-py3-none-any.whl
