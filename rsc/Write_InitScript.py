%py
# Create Init Scripts



filename = 'dbfs:/databricks/scripts/1_rstudio.sh'
script = '''#!/bin/bash
sudo rm -rf /var/lib/apt/lists/*

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
  r-cran-dt r-cran-shinyjs r-cran-shinydashboard r-cran-shinycssloaders \
  r-cran-sf r-cran-raster r-cran-leaflet \
  r-cran-arrow r-cran-plotly \
  r-cran-packrat r-cran-rsconnect

# Python
pip install \
  pandas matplotlib openpyxl \
  spatialite rtree pyproj geopandas geocube
'''

dbutils.fs.put(filename, script, overwrite=True)



filename = 'dbfs:/databricks/scripts/3_geovector.sh'
script = '''#!/bin/bash

# Sedona
## requires spark config:
### spark.sql.extensions org.apache.sedona.viz.sql.SedonaVizExtensions,org.apache.sedona.sql.SedonaSqlExtensions
### spark.serializer org.apache.spark.serializer.KryoSerializer
### spark.kryo.registrator org.apache.sedona.core.serde.SedonaKryoRegistrator
DIR="/dbfs/databricks/jars"
if [ ! -d $DIR ]
then
  mkdir -p $DIR
  curl -o $DIR/geotools-wrapper-1.1.0-25.2.jar "https://repo1.maven.org/maven2/org/datasyslab/geotools-wrapper/1.1.0-25.2/geotools-wrapper-1.1.0-25.2.jar"
  curl -o $DIR/sedona-python-adapter-3.0_2.12-1.1.1-incubating.jar "https://repo1.maven.org/maven2/org/apache/sedona/sedona-python-adapter-3.0_2.12/1.1.1-incubating/sedona-python-adapter-3.0_2.12-1.1.1-incubating.jar"
  curl -o $DIR/sedona-viz-3.0_2.12-1.1.1-incubating.jar "https://repo1.maven.org/maven2/org/apache/sedona/sedona-viz-3.0_2.12/1.1.1-incubating/sedona-viz-3.0_2.12-1.1.1-incubating.jar"
fi
cp $DIR/*.jar /databricks/jars
pip install \
  apache-sedona

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
  pyspark-vector-files
'''

dbutils.fs.put(filename, script, overwrite=True)



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
- 3_GeoVector Append to Spark config:
spark.sql.extensions org.apache.sedona.viz.sql.SedonaVizExtensions,org.apache.sedona.sql.SedonaSqlExtensions
spark.serializer org.apache.spark.serializer.KryoSerializer
spark.kryo.registrator org.apache.sedona.core.serde.SedonaKryoRegistrator
''')
