#!/bin/bash
# -- 
# This is for Ubuntu 22.04 (Jammy)
# [1] corresponds to DBR 13+
# [2] jammy offers GDAL 3.4.1 (default)
#     - optional: Ubuntugis offers GDAL 3.4.3,
#       with additional ppa added
# [3] see Mosaic functions (python) to configure
#     and pre-stage resources:
#     - setup_fuse_install(...) and
#     - setup_gdal(...)

MOSAIC_PIP_VERSION='==0.4.0'
WITH_MOSAIC=1
WITH_GDAL=1
WITH_UBUNTUGIS=0
GDAL_VERSION=3.4.1

if [ $WITH_GDAL == 1 ]
then
  echo '51.132.212.186   archive.ubuntu.com' | tee -a /etc/hosts
  # - refresh package info
  sudo apt-add-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc)-backports main universe multiverse restricted"
  sudo apt-add-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc)-updates main universe multiverse restricted"
  sudo apt-add-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc)-security main multiverse restricted universe"
  sudo apt-add-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) main multiverse restricted universe"
  if [ $WITH_UBUNTUGIS == 1 ]
  then
    sudo add-apt-repository ppa:ubuntugis/ppa
    GDAL_VERSION=3.4.3
  fi
  sudo apt-get update -y
  
  sudo apt-get install -y unixodbc libcurl3-gnutls libsnappy-dev libopenjp2-7
  sudo apt-get install -y gdal-bin libgdal-dev python3-numpy python3-gdal

  pip install --upgrade pip
  pip install gdal==$GDAL_VERSION
  
  GITHUB_REPO_PATH=databrickslabs/mosaic/main/resources/gdal/jammy
  sudo wget -nv -P /usr/lib -nc https://raw.githubusercontent.com/$GITHUB_REPO_PATH/libgdalalljni.so
  sudo wget -nv -P /usr/lib -nc https://raw.githubusercontent.com/$GITHUB_REPO_PATH/libgdalalljni.so.30
  sudo wget -nv -P /usr/lib -nc https://raw.githubusercontent.com/$GITHUB_REPO_PATH/libgdalalljni.so.30.0.3
fi


if [ $WITH_MOSAIC == 1 ]
then
  pip install --upgrade pip
  pip install "databricks-mosaic$MOSAIC_PIP_VERSION"
fi