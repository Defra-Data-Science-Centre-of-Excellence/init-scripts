# https://sedona.apache.org/1.7.1/setup/databricks/
# works on Databricks runtime 15.4 LTS (includes Apache Spark 3.5.0, Scala 2.12)
DIR=/databricks/jars
SPARK="3.5"
SCALA="2.12"
SEDONA="1.7.2"
GEOTOOLS="28.5"
wget --no-check-certificate -NP  $DIR "https://repo1.maven.org/maven2/org/datasyslab/geotools-wrapper/${SEDONA}-${GEOTOOLS}/geotools-wrapper-${SEDONA}-${GEOTOOLS}.jar"
wget --no-check-certificate -NP  $DIR "https://repo1.maven.org/maven2/org/apache/sedona/sedona-spark-shaded-${SPARK}_${SCALA}/$SEDONA/sedona-spark-shaded-${SPARK}_${SCALA}-$SEDONA.jar"

pip install \
  apache-sedona==$SEDONA --extra-index-url https://pypi.org/simple/ \
  geopandas==1.0.1 \
  keplergl==0.3.7 \
  pydeck==0.9.1