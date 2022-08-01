# Repos
sudo add-apt-repository ppa:c2d4u.team/c2d4u4.0+
sudo add-apt-repository ppa:ubuntugis/ppa

# Update
sudo apt-get update
pip install -U pip

# C
sudo apt-get install -y \
  libsqlite3-mod-spatialite

# R
apt-get install -y \
  r-cran-renv r-cran-rstudioapi r-cran-reticulate \
  r-cran-dt r-cran-shinyjs r-cran-shinydashboard r-cran-shinycssloaders \
  r-cran-sf r-cran-raster r-cran-leaflet \
  r-cran-arrow r-cran-plotly \
  r-cran-packrat r-cran-rsconnect \
  r-cran-biocmanager r-cran-bs4dash r-cran-janitor r-cran-odbc r-cran-rgdal r-cran-rpostgres r-cran-srvyr r-cran-zoo
if [[ "$(which python)" == *"databricks"* ]]; then
  export RETICULATE_PYTHON=$(which python)
fi

# Python
pip install \
  pandas matplotlib openpyxl \
  spatialite rtree pyproj geopandas geocube
