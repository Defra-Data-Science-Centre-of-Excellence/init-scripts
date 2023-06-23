#!/bin/bash
URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/main
FOLDER=/dbfs/databricks/scripts

#wget --no-check-certificate -NP $DIR $URL/src/rootcert.sh  # hidden
wget --no-check-certificate -NP $DIR $URL/src/update.sh
wget --no-check-certificate -NP $DIR $URL/src/base_libs.sh
wget --no-check-certificate -NP $DIR $URL/src/gis_libs.sh
