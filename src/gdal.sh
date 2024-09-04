#!/bin/bash
DIR=/databricks/miniconda
mkdir -p $DIR

# Install Conda
wget --no-check-certificate -qNP $DIR https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash $DIR/Miniconda3-latest-Linux-x86_64.sh -bufp $DIR

# Use Conda Forge
$DIR/bin/conda config --set ssl_verify false
$DIR/bin/conda config --add channels conda-forge
$DIR/bin/conda config --set channel_priority strict
$DIR/bin/conda update -y --all
$DIR/bin/conda install -y -c conda-forge libgdal-arrow-parquet

# ogr settings
export TMPDIR=/tmp
export PROJ_LIB=/databricks/miniconda/share/proj
export OGR_GEOMETRY_ACCEPT_UNCLOSED_RING=NO
