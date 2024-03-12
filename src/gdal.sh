#!/bin/bash
export MINICONDA_DIR=/databricks/miniconda
mkdir -p $MINICONDA_DIR

wget -qNP $MINICONDA_DIR https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash $MINICONDA_DIR/Miniconda3-latest-Linux-x86_64.sh -b -u -f -p $MINICONDA_DIR

$MINICONDA_DIR/bin/conda update -y --all
$MINICONDA_DIR/bin/conda install -y -c conda-forge libgdal-arrow-parquet gdal

# ogr settings
export TMPDIR=/tmp
export PROJ_LIB=/databricks/miniconda/share/proj
export OGR_GEOMETRY_ACCEPT_UNCLOSED_RING=NO
