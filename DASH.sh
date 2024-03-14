#!/bin/bash
set -x
echo $DB_CLUSTER_NAME

URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/aw-fixes/src
wget $URL/rootcert.sh -O- | bash -ex
wget $URL/update.sh -O- | bash -ex
wget $URL/base_libs.sh -O- | bash -ex

# works but very slow
#wget -qO- $URL/r_installs.R | Rscript -

# not installing with ssl
wget $URL/gis_libs.sh -O- | bash -ex

# with ssl this causes the detatch bug: "Failure starting repl."
wget $URL/gdal.sh -qO- | bash -ex

# conflicts for some libs, causing set -e exit
pip install -Ur https://gist.githubusercontent.com/aw-west-defra/99ef9bb208ddb85e7f29381937d78cea/raw/1e340d4c4ed46031f08a6d5edb44c75602a80bb9/requirements.txt
