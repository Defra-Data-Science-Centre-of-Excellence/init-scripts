#!/bin/bash
# Sedona
## requires spark config:
### spark.kryo.registrator org.apache.sedona.core.serde.SedonaKryoRegistrator
### spark.serializer org.apache.spark.serializer.KryoSerializer
### spark.sql.extensions org.apache.sedona.viz.sql.SedonaVizExtensions,org.apache.sedona.sql.SedonaSqlExtensions
DIR=/databricks/jars
SPARK="3.4"
SCALA="2.12"
SEDONA="1.4.1"
wget --no-check-certificate -qNP $DIR "https://repo1.maven.org/maven2/org/datasyslab/geotools-wrapper/1.4.0-28.2/geotools-wrapper-1.4.0-28.2.jar"
wget --no-check-certificate -qNP $DIR "https://repo1.maven.org/maven2/org/apache/sedona/sedona-spark-shaded-${SPARK}_${SCALA}/$SEDONA/sedona-spark-shaded-${SPARK}_${SCALA}-$SEDONA.jar"
wget --no-check-certificate -qNP $DIR "https://repo1.maven.org/maven2/org/apache/sedona/sedona-viz-${SPARK}_${SCALA}/$SEDONA/sedona-viz-${SPARK}_${SCALA}-$SEDONA.jar"
pip install apache-sedona==$SEDONA

# Mosaic
pip install databricks-mosaic
