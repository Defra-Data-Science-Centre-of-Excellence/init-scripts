#!/bin/bash
set -ex
echo -e "\n\n\n--- conda and gdal ---"

# No SSL version of https://github.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/blob/main/src/gdal.sh
DIR=/databricks/miniconda
mkdir -p $DIR

wget --no-check-certificate --no-clobber -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $DIR/miniconda_installer.sh
bash $DIR/miniconda_installer.sh -b -u -f -p $DIR

$DIR/bin/conda config --set ssl_verify false 
$DIR/bin/conda update -y --all
$DIR/bin/conda install -y -c conda-forge libgdal-arrow-parquet proj gdal

echo export TMPDIR=/tmp >> /etc/environment
echo export PROJ_LIB=/databricks/miniconda/share/proj >> /etc/environment
echo export OGR_GEOMETRY_ACCEPT_UNCLOSED_RING=NO >> /etc/environment
