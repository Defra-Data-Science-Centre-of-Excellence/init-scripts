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
  r-cran-renv r-cran-devtools r-cran-rstudioapi r-cran-reticulate \
  r-cran-dt r-cran-shinyjs r-cran-shinydashboard r-cran-shinycssloaders \
  r-cran-sf r-cran-raster r-cran-leaflet \
  r-cran-arrow r-cran-plotly \
  r-cran-packrat r-cran-rsconnect \
  r-cran-biocmanager r-cran-janitor r-cran-odbc r-cran-rgdal r-cran-rpostgres r-cran-srvyr r-cran-zoo

# Python
pip install \
  pandas matplotlib openpyxl \
  spatialite rtree pyproj geopandas geocube

# Quarto
## https://docs.rstudio.com/resources/install-quarto/
FILE=quarto-linux-amd64.deb
wget -O $FILE https://quarto.org/download/latest/$FILE
sudo apt-get install -y \
  gdebi-core
sudo gdebi -n $FILE
rm $FILE
/usr/local/bin/quarto check
