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
  libcairo2-dev

# R
apt-get install -y \
  r-cran-renv r-cran-devtools r-cran-rstudioapi r-cran-reticulate r-cran-packrat r-cran-rsconnect \
  r-cran-dt r-cran-shinyjs r-cran-shinydashboard r-cran-shinycssloaders \
  r-cran-sf r-cran-raster r-cran-leaflet \
  r-cran-arrow r-cran-plotly \
  r-cran-biocmanager r-cran-janitor r-cran-odbc r-cran-rgdal r-cran-rpostgres r-cran-srvyr r-cran-zoo

# Python
python -m pip install \
  pandas openpyxl \
  folium matplotlib mapclassify \
  spatialite rtree pyproj geopandas geocube \
  numpy scipy scikit-learn \
  dash dash_core_components dash_html_components
