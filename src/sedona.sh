#!/bin/bash
# Sedona
#spark.sql.extensions org.apache.sedona.viz.sql.SedonaVizExtensions,org.apache.sedona.sql.SedonaSqlExtensions
#spark.serializer org.apache.spark.serializer.KryoSerializer
#spark.kryo.registrator org.apache.sedona.core.serde.SedonaKryoRegistrator
DIR=/databricks/jars
GEOTOOLS="28.2"
SPARK="3.5"
SCALA="2.12"
SEDONA="1.6.1"
wget --no-check-certificate --progress=dot:giga -NP $DIR "https://repo1.maven.org/maven2/org/datasyslab/geotools-wrapper/$SEDONA-$GEOTOOLS/geotools-wrapper-$SEDONA-$GEOTOOLS.jar"
wget --no-check-certificate --progress=dot:giga -NP $DIR "https://repo1.maven.org/maven2/org/apache/sedona/sedona-spark-shaded-${SPARK}_${SCALA}/$SEDONA/sedona-spark-shaded-${SPARK}_${SCALA}-$SEDONA.jar"
pip install apache-sedona==$SEDONA keplergl pydeck geopandas
