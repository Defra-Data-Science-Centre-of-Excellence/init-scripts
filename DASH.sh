#!/bin/bash

INIT_PATH="/Workspace/config/init_scripts/DASH.sh"
TIMEOUT=120
WAIT_INTERVAL=5
ELAPSED=0

echo "$(date '+%Y-%m-%d %H:%M:%S') - Starting FUSA layer wait loop for $INIT_PATH" >&2

while [ ! -f "$INIT_PATH" ]; do
  echo "$(date '+%Y-%m-%d %H:%M:%S') - File not found yet. Waited ${ELAPSED}s of ${TIMEOUT}s." >&2
  if [ $ELAPSED -ge $TIMEOUT ]; then
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Timeout reached. Exiting with failure." >&2
    exit 1
  fi
  sleep $WAIT_INTERVAL
  ELAPSED=$((ELAPSED + WAIT_INTERVAL))
done

echo "$(date '+%Y-%m-%d %H:%M:%S') - Found $INIT_PATH. Executing script." >&2
bash "$INIT_PATH"
RC=$?
echo "$(date '+%Y-%m-%d %H:%M:%S') - Script exited with code $RC" >&2
exit $RC

set -ex
echo $DB_CLUSTER_NAME

# Optional cscrootcerts.crt path
export CERT_PATH="/Volumes/prd_dash_config/common/init_scripts/src/cscrootcert.crt"

URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/uc-workspaces/src
wget $URL/rootcert.sh -O- | bash -ex
wget $URL/update.sh -O- | bash  -ex
wget $URL/base_libs.sh -O- | bash  -ex
if [[ "$DB_CLUSTER_NAME" == *"RStu"* ]]; then  # If RStu in cluster name
  wget -qO- $URL/r_installs.R | Rscript -
fi
if [[ "$DB_CLUSTER_NAME" == *"Geo"* ]]; then  # If Geo in cluster name
  wget $URL/sedona.sh -O- | bash -ex
  wget $URL/mosaic.sh -O- | bash -ex
fi
if [[ "$DB_CLUSTER_NAME" == *"ucanaccess"* ]]; then  # If ucanaccess in cluster name
  wget $URL/ucanaccess.sh -O- | bash -ex
fi