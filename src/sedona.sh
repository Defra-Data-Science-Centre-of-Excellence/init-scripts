#!/bin/bash
# Sedona
#spark.sql.extensions org.apache.sedona.viz.sql.SedonaVizExtensions,org.apache.sedona.sql.SedonaSqlExtensions
#spark.serializer org.apache.spark.serializer.KryoSerializer
#spark.kryo.registrator org.apache.sedona.core.serde.SedonaKryoRegistrator
DIR=/databricks/jars
SPARK="3.4"
SCALA="2.12"
SEDONA="1.6.1"
GEOTOOLS="1.6.1-28.2"
wget --no-check-certificate -qNP $DIR "https://repo1.maven.org/maven2/org/datasyslab/geotools-wrapper/${GEOTOOLS}/geotools-wrapper-${GEOTOOLS}.jar"
wget --no-check-certificate -qNP $DIR "https://repo1.maven.org/maven2/org/apache/sedona/sedona-spark-shaded-${SPARK}_${SCALA}/$SEDONA/sedona-spark-shaded-${SPARK}_${SCALA}-$SEDONA.jar"
wget --no-check-certificate -qNP $DIR "https://repo1.maven.org/maven2/org/apache/sedona/sedona-viz-${SPARK}_${SCALA}/$SEDONA/sedona-viz-${SPARK}_${SCALA}-$SEDONA.jar"
pip install apache-sedona==$SEDONA keplergl==0.3.2 pydeck==0.8.0 geopandas==0.11.1
