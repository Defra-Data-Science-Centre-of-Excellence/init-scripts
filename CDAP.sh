#!/bin/bash
URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/main

FILE=1_rstudio_test.sh
FOLDER=/dbfs/databricks/scripts/$FILE  # required for appending to /dbfs/
wget -O- --no-check-certificate $URL/src/update.sh > $FILE
wget -O- --no-check-certificate $URL/src/base_libs.sh >> $FILE
mv $FILE $FOLDER$FILE

FILE=/dbfs/databricks/scripts/3_geovector_test.sh
wget -O- --no-check-certificate $URL/src/gis_libs.sh > $FILE
