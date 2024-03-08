# Sedona https://sedona.apache.org/
## requires spark config:
### spark.kryo.registrator org.apache.sedona.core.serde.SedonaKryoRegistrator
### spark.serializer org.apache.spark.serializer.KryoSerializer
### spark.sql.extensions org.apache.sedona.viz.sql.SedonaVizExtensions,org.apache.sedona.sql.SedonaSqlExtensions
DIR=/databricks/jars
SPARK="3.5"
SCALA="2.12"
SEDONA="1.5.1"
wget --no-check-certificate -NP $DIR "https://repo1.maven.org/maven2/org/datasyslab/geotools-wrapper/1.5.1-28.2/geotools-wrapper-1.5.1-28.2.jar"#"https://repo1.maven.org/maven2/org/datasyslab/geotools-wrapper/1.4.0-28.2/geotools-wrapper-1.4.0-28.2.jar"
wget --no-check-certificate -NP $DIR "https://repo1.maven.org/maven2/org/apache/sedona/sedona-spark-shaded-${SPARK}_${SCALA}/$SEDONA/sedona-spark-shaded-${SPARK}_${SCALA}-$SEDONA.jar"
wget --no-check-certificate -NP $DIR "https://repo1.maven.org/maven2/org/apache/sedona/sedona-viz-${SPARK}_${SCALA}/$SEDONA/sedona-viz-${SPARK}_${SCALA}-$SEDONA.jar"

# Libraries required for python support 
pip install \
  apache-sedona==$SEDONA \
  geopandas==0.11.1 \
  keplergl==0.3.2 \
  pydeck==0.8.0 
