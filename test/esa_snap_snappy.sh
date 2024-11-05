#!/bin/bash

INSTALLER_DBFS_PATH="/dbfs/mnt/lab/unrestricted/admin/apps/esa_snap_sentinel_linux_10_0_0.sh"
INSTALLER_TMP_PATH="/tmp/esa_snap_sentinel_linux_10_0_0.sh"

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
o                          # OK to continue
1                          # Select installation type
$SNAP_INSTALL_DIR          # Specify installation directory
2,3,4                      # Select components
n                          # No symlinks
y                          # Confirm installation
$PYTHON_PATH               # Specify Python executable
y                          # Configure for Python
EOF

# Configure SNAP for the detected Python version
/opt/esa-snap/bin/snappy-conf $PYTHON_EXEC

# Copy the SNAP Python module
cp -r /root/.snap/snap-python/esa_snappy /local_disk0/.ephemeral_nfs/cluster_libraries/python/lib/python3.9/site-packages/
