# Sedona
## requires spark config:
### spark.kryo.registrator org.apache.sedona.core.serde.SedonaKryoRegistrator
### spark.serializer org.apache.spark.serializer.KryoSerializer
### spark.sql.extensions org.apache.sedona.viz.sql.SedonaVizExtensions,org.apache.sedona.sql.SedonaSqlExtensions
DIR=/dbfs/databricks/jars
mkdir -p $DIR
wget --no-check-certificate -NP $DIR "https://repo1.maven.org/maven2/org/datasyslab/geotools-wrapper/1.1.0-25.2/geotools-wrapper-1.1.0-25.2.jar"
wget --no-check-certificate -NP $DIR "https://repo1.maven.org/maven2/org/apache/sedona/sedona-python-adapter-3.0_2.12/1.1.1-incubating/sedona-python-adapter-3.0_2.12-1.1.1-incubating.jar"
wget --no-check-certificate -NP $DIR "https://repo1.maven.org/maven2/org/apache/sedona/sedona-viz-3.0_2.12/1.1.1-incubating/sedona-viz-3.0_2.12-1.1.1-incubating.jar"
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
  pyogrio \
  pyspark-vector-files
