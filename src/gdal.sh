#!/bin/bash
export MINICONDA_DIR=/databricks/miniconda
mkdir -p $MINICONDA_DIR

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $MINICONDA_DIR/miniconda_installer.sh
bash $MINICONDA_DIR/miniconda_installer.sh -b -u -f -p $MINICONDA_DIR

$MINICONDA_DIR/bin/conda update --all
$MINICONDA_DIR/bin/conda install -c conda-forge libgdal-arrow-parquet gdal

# ogr settings
export TMPDIR=/tmp
export PROJ_LIB=/databricks/miniconda/share/proj
export OGR_GEOMETRY_ACCEPT_UNCLOSED_RING=NO
