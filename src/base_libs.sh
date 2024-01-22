# Repos
sudo add-apt-repository ppa:c2d4u.team/c2d4u4.0+
sudo add-apt-repository ppa:ubuntugis/ppa

# C
sudo apt-get install -y \
  apt-utils \
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
  cmake \
  ffmpeg \
  parallel

# R
apt-get install -y \
  r-cran-renv r-cran-devtools r-cran-rstudioapi r-cran-reticulate r-cran-packrat r-cran-rsconnect \
  r-cran-dt r-cran-shinyjs r-cran-shinydashboard r-cran-shinycssloaders \
  r-cran-arrow r-cran-plotly \
  r-cran-sf r-cran-sfarrow r-cran-raster r-cran-leaflet \
  r-cran-biocmanager r-cran-janitor r-cran-odbc r-cran-rgdal r-cran-rpostgres r-cran-srvyr r-cran-zoo

# Python
pip install \
  pandas[all] \
  pyogrio spatialite rtree pyproj geopandas geocube \
  geodatasets contextily folium mapclassify

# Additional configs
echo 'message(r"(
    ____  ___   _____ __  __
   / __ \/   | / ___// / / /
  / / / / /| | \__ \/ /_/ /
 / /_/ / ___ |___/ / __  /
/_____/_/  |_/____/_/ /_/ Defra
https://github.com/Defra-Data-Science-Centre-of-Excellence/CDAP_training#r-and-rstudio-on-the-dash-platform
)")' >> /usr/lib/R/etc/Rprofile.site
