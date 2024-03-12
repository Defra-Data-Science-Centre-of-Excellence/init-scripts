# Repos
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
Rscript -e 'install.packages(c(
  "rlang", "renv",  "devtools", "rstudioapi",  "reticulate", "packrat", "rsconnect",
  "openxlsx", "writexl", "odbc", "RPostgres", "here",  # removed: arrow, added: here, writexl
  "DT", "shinyjs", "shinydashboard", "shinycssloaders", "crosstalk",
  "plotly", "ggplot2", "cowplot", "viridis",
  "gdalBindings", "sf", "raster", "leaflet",  # removed: rgdal, sfarrow, added: gdalbindings
  "BiocManager", "janitor", "srvyr", "zoo", "BH", "cli", "lazyeval", "snakecase"
), repos="https://cloud.r-project.org")'

# Python
pip install \
  "pandas[all]<2" \
  "ruff<0.2" pip-tools pytest \
  pyogrio spatialite rtree pyproj geopandas geocube \
  geodatasets contextily folium mapclassify

# Additional configs
echo 'message(r"(
    ____  ___   _____ __  __
   / __ \/   | / ___// / / /
  / / / / /| | \__ \/ /_/ /
 / /_/ / ___ |___/ / __  /
/_____/_/  |_/____/_/ /_/ Defra
https://didactic-doodle-58b6846e.pages.github.io/
)")' >> /usr/lib/R/etc/Rprofile.site
