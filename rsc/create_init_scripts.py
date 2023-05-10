%py
TEST_MODE = False
FOLDER = 'dbfs:/databricks/scripts/'



file_func = lambda filename:  FOLDER+filename if not TEST_MODE else FOLDER+filename.replace('.sh', '_test.sh')



filename = '1_rstudio.sh'
script = r'''#!/bin/bash
sudo rm -rf /var/lib/apt/lists/*
sudo apt-get update -y
sudo apt-get full-upgrade -y
sudo apt-get autoremove -y
sudo apt-get autopurge -y

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
  r-cran-renv r-cran-devtools r-cran-rstudioapi r-cran-reticulate r-cran-packrat r-cran-rsconnect \
  r-cran-dt r-cran-shinyjs r-cran-shinydashboard r-cran-shinycssloaders \
  r-cran-sf r-cran-raster r-cran-leaflet \
  r-cran-arrow r-cran-plotly \
  r-cran-biocmanager r-cran-janitor r-cran-odbc r-cran-rgdal r-cran-rpostgres r-cran-srvyr r-cran-zoo

# Python
pip install \
  black tokenize-rt \
  pandas openpyxl \
  folium matplotlib mapclassify \
  spatialite rtree pyproj geopandas geocube
'''
dbutils.fs.put(file_func(filename), script, overwrite=True)



filename = '3_geovector.sh'
script = r'''#!/bin/bash
# Sedona
## requires spark config:
### spark.kryo.registrator org.apache.sedona.core.serde.SedonaKryoRegistrator
### spark.serializer org.apache.spark.serializer.KryoSerializer
### spark.sql.extensions org.apache.sedona.viz.sql.SedonaVizExtensions,org.apache.sedona.sql.SedonaSqlExtensions
DIR=/dbfs/databricks/jars
mkdir -p $DIR
VERSION="1.3.1"
wget --no-check-certificate -NP $DIR "https://repo1.maven.org/maven2/org/datasyslab/geotools-wrapper/1.3.0-27.2/geotools-wrapper-1.3.0-27.2.jar"
wget --no-check-certificate -NP $DIR "https://repo1.maven.org/maven2/org/apache/sedona/sedona-python-adapter-3.0_2.12/$VERSION-incubating/sedona-python-adapter-3.0_2.12-$VERSION-incubating.jar"
wget --no-check-certificate -NP $DIR "https://repo1.maven.org/maven2/org/apache/sedona/sedona-viz-3.0_2.12/$VERSION-incubating/sedona-viz-3.0_2.12-$VERSION-incubating.jar"
cp $DIR/*.jar /databricks/jars
pip install \
  apache-sedona==$VERSION

# Mosaic
pip install \
  databricks-mosaic

# PySpark Vector Files
sudo add-apt-repository ppa:ubuntugis/ubuntugis-unstable
sudo apt-get update
sudo apt-get install -y \
  libudunits2-dev \
  libgdal-dev \
  libgeos-dev \
  libproj-dev \
  libspatialindex-dev
pip install \
  pyogrio \
  pyspark-vector-files
'''
dbutils.fs.put(file_func(filename), script, overwrite=True)



print('''TODO:
- Logging:
dbfs:/databricks/logs/0_support
dbfs:/databricks/logs/1_rstudio
dbfs:/databricks/logs/2_notebook
dbfs:/databricks/logs/3_geovector
dbfs:/databricks/logs/4_training
- Init Scripts:
dbfs:/databricks/scripts/1_rstudio.sh
dbfs:/databricks/scripts/3_geovector.sh
- Environment Variables for all clusters:
LD_LIBRARY_PATH=/usr/libs
- 3_GeoVector Append to Spark config:
spark.kryo.registrator org.apache.sedona.core.serde.SedonaKryoRegistrator
spark.serializer org.apache.spark.serializer.KryoSerializer
spark.sql.extensions org.apache.sedona.viz.sql.SedonaVizExtensions,org.apache.sedona.sql.SedonaSqlExtensions
''')
