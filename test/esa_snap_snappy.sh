#!/bin/bash

INSTALLER_DBFS_PATH="/dbfs/mnt/lab/unrestricted/admin/apps/esa_snap_sentinel_linux_10_0_0.sh"
INSTALLER_TMP_PATH="/tmp/esa_snap_sentinel_linux_10_0_0.sh"
SNAPPY_CONFIG_FILE="/opt/esa-snap/bin/snappy-conf"
SNAPPY_MODULE="/root/.snap/snap-python/esa_snappy"

# Wait until mount is accessible
# Trying to get the install script from the lab zone fails without this wait process, possibly because
# the driver node needs a few seconds to have its coffee or something.
TIMEOUT=120
WAIT_INTERVAL=5
ELAPSED=0
while [ ! -f "$INSTALLER_DBFS_PATH" ]; do
  if [ $ELAPSED -ge $TIMEOUT ]; then
    exit 1
  fi
  sleep $WAIT_INTERVAL
  ELAPSED=$((ELAPSED + WAIT_INTERVAL))
done

cp "$INSTALLER_DBFS_PATH" "$INSTALLER_TMP_PATH"
if [ $? -ne 0 ]; then
  echo "Error: Failed to copy installer script to $INSTALLER_TMP_PATH."
  exit 1
fi

# Detect the Python executable dynamically
PYTHON_EXEC=$(which python3)
if [ -z "$PYTHON_EXEC" ]; then
  echo "Error: Failed to detect the Python executable."
  exit 1
fi

# Run the installer with input redirection
"$INSTALLER_TMP_PATH" -c -q --skipBundledJre <<EOF
o
1
$SNAP_INSTALL_DIR
2,3,4
n
y
$PYTHON_PATH
y
EOF

# Try the wait loop on the snappy config file before running
TIMEOUT=120
WAIT_INTERVAL=5
ELAPSED=0
while [ ! -f "$SNAPPY_CONFIG_FILE" ]; do
  if [ $ELAPSED -ge $TIMEOUT ]; then
    exit 1
  fi
  sleep $WAIT_INTERVAL
  ELAPSED=$((ELAPSED + WAIT_INTERVAL))
done
# Configure SNAP for the detected Python version
$SNAPPY_CONFIG_FILE $PYTHON_EXEC

# Try the wait loop on the esa snappy module before copying it to site-packages
TIMEOUT=120
WAIT_INTERVAL=5
ELAPSED=0
while [ ! -f "$SNAPPY_MODULE" ]; do
  if [ $ELAPSED -ge $TIMEOUT ]; then
    exit 1
  fi
  sleep $WAIT_INTERVAL
  ELAPSED=$((ELAPSED + WAIT_INTERVAL))
done

# Copy the SNAP Python module
cp -r $SNAPPY_MODULE /local_disk0/.ephemeral_nfs/cluster_libraries/python/lib/python3.9/site-packages/
