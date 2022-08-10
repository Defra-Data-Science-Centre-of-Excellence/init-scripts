#!/bin/bash
echo "check_certificate = off" >> ~/.wgetrc

URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/main

FILE=1_rstudio_test.sh
FOLDER=/dbfs/databricks/scripts/$FILE  # required for appending to /dbfs/
wget $URL/src/update.sh -qO-> $FILE
wget $URL/src/base_libs.sh -qO->> $FILE
mv $FILE $FOLDER$FILE

FILE=/dbfs/databricks/scripts/3_geovector_test.sh
wget $URL/src/gis_libs.sh -qO-> $FILE
