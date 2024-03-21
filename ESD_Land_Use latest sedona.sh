#!/bin/bash
set -ex
echo $DB_CLUSTER_NAME
URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/esd-init-scripts/main/src

wget $URL/rootcert.sh -O- | bash -ex
wget $URL/update.sh -O- | bash -ex
wget $URL/c_dependencies.sh -O- | bash -ex
wget $URL/sedona_151.sh -O- | bash -ex

pip install /Workspace/Shared/python_libraries/sds_dash_download-0.1.0-py3-none-any.whl /Workspace/Shared/python_libraries/sds_land_use_model-0.1.0-py3-none-any.whl

# other libraries
pip install pyogrio==0.7.2 
pip install keplergl==0.3.2 
pip install pydeck==0.8.0 
pip install geopandas==0.14.2 
pip install pandana==0.7 
pip install shapely==2.0.2 
pip install matplotlib==3.8.3 
pip install mapclassify==2.6.1 
pip install folium==0.15.1
