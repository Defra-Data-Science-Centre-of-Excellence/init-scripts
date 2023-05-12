#!/bin/bash
# Repos
sudo add-apt-repository ppa:c2d4u.team/c2d4u4.0+
sudo add-apt-repository ppa:ubuntugis/ppa

# Update
sudo apt-get update -y
sudo apt-get full-upgrade -y
sudo apt-get autoremove -y
sudo apt-get autopurge -y
sudo apt-get autoclean -y
python3 -m pip install -U pip

# C
sudo apt-get install -y \
  libsqlite3-mod-spatialite \
  libudunits2-dev \
  libgdal-dev \
  libgeos-dev \
  libproj-dev \
  libspatialindex-dev \
  libtiff5-dev \
  libfreetype6-dev \
  libpng-dev \
  libjpeg-dev \
  libfribidi-dev \
  libharfbuzz-dev \
  libfontconfig1-dev \
  libcairo2-dev \
  cmake

# R
apt-get install -y \
  r-cran-renv r-cran-devtools r-cran-rstudioapi r-cran-reticulate r-cran-packrat r-cran-rsconnect \
  r-cran-dt r-cran-shinyjs r-cran-shinydashboard r-cran-shinycssloaders \
  r-cran-sf r-cran-raster r-cran-leaflet \
  r-cran-arrow r-cran-plotly \
  r-cran-biocmanager r-cran-janitor r-cran-odbc r-cran-rgdal r-cran-rpostgres r-cran-srvyr r-cran-zoo

# Python
python -m pip install \
  pandas==1.5.3 \
  openpyxl==3.1.2 \
  folium==0.14.0 \
  matplotlib==3.7.1 \
  mapclassify==2.5.0 \
  spatialite==0.0.3 \
  rtree==1.0.1 \
  pyproj==3.5.0 \
  geopandas==0.13.0 \
  geocube==0.4.0 \
  numpy==1.24.2 \
  scipy==1.10.1 \
  scikit-learn==1.2.2 \
  dash==2.9.3 \
  flask==2.3.2 \
  black==23.3.0 \
  tokenize-rt==5.0.0
