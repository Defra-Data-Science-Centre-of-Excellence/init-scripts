#!/bin/bash

INSTALLER_DBFS_PATH="/dbfs/mnt/lab/unrestricted/admin/apps/esa_snap_sentinel_linux_10_0_0.sh"
INSTALLER_TMP_PATH="/tmp/esa_snap_sentinel_linux_10_0_0.sh"
SNAP_INSTALL_DIR="/opt/esa-snap"

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

# Copying the installer file from the mounted Lab zone to local storage on the driver node. 
# I don't know if this is completely necessary, but it's a big file and running the install 
# straight from Lab might be less reliable. 
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
echo "Excellent! We found the Python executable at $PYTHON_EXEC"

# Run the installer with input redirection
"$INSTALLER_TMP_PATH" -c -q --skipBundledJre <<EOF
o
1
$SNAP_INSTALL_DIR
2,3,4
n
y
$PYTHON_EXEC
y
EOF
