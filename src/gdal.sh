#!/bin/bash
DIR=/databricks/miniconda
mkdir $DIR

wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O $DIR/miniconda_installer.sh
bash $DIR/miniconda_installer.sh -b -u -f -p $DIR

export PATH=$PATH:$DIR/bin

$DIR/bin/conda update --all
$DIR/bin/conda install -c conda-forge libgdal-arrow-parquet gdal
