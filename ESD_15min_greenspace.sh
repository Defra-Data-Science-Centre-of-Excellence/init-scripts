#!/bin/bash
set -ex
echo $DB_CLUSTER_NAME
URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/esd-init-scripts/main/src

wget $URL/rootcerts.sh -O- | bash
wget $URL/update.sh -O- | bash 
wget $URL/c_dependencies.sh -O- | bash 
wget $URL/sedona_150.sh -O- | bash 

pip install /Workspace/Shared/python_libraries/sds_dash_download-0.1.0-py3-none-any.whl

# other libraries
pip install pyogrio==0.7.2
pip install keplergl==0.3.2
pip install pydeck==0.8.0
pip install geopandas==0.14.2
pip install pandana==0.7
pip install shapely==2.0.2