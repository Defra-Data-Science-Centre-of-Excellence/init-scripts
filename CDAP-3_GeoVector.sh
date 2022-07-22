#!/bin/bash
URL=https://raw.githubusercontent.com/aw-west-defra/init/main/src/
wget -O - $URL"update.sh" | bash
wget -O - $URL"base_libs.sh" | bash
wget -O - $URL"geo_libs.sh" | bash

echo """CDAP-3_GeoVector append to Spark config:
spark.sql.extensions org.apache.sedona.viz.sql.SedonaVizExtensions,org.apache.sedona.sql.SedonaSqlExtensions
spark.serializer org.apache.spark.serializer.KryoSerializer
spark.kryo.registrator org.apache.sedona.core.serde.SedonaKryoRegistrator
"""
