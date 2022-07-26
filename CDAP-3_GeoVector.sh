#!/bin/bash
URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/main
wget -O - $URL/src/update.sh | bash
wget -O - $URL/src/base_libs.sh" | bash
wget -O - $URL/src/geo_libs.sh | bash

echo """CDAP-3_GeoVector append to Spark config:
spark.sql.extensions org.apache.sedona.viz.sql.SedonaVizExtensions,org.apache.sedona.sql.SedonaSqlExtensions
spark.serializer org.apache.spark.serializer.KryoSerializer
spark.kryo.registrator org.apache.sedona.core.serde.SedonaKryoRegistrator
"""
