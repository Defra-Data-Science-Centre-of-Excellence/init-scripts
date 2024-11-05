#!/bin/bash

# Copy the SNAP installer to the temporary directory
cp /dbfs/FileStore/tomkdefra/esa_snap_sentinel_linux_10_0_0.sh /tmp/

# Run the installer with the required flags
/tmp/esa_snap_sentinel_linux_10_0_0.sh -c -q --skipBundledJre <<EOF
o
1
/opt/esa-snap
2,3,4
n
y
/local_disk0/.ephemeral_nfs/cluster_libraries/python/bin/python3
y
EOF

# Configure SNAP for the specified Python version
/opt/esa-snap/bin/snappy-conf /local_disk0/.ephemeral_nfs/cluster_libraries/python/bin/python3

# Copy the SNAP Python module to the Python site-packages directory
cp -r /root/.snap/snap-python/esa_snappy/ /local_disk0/.ephemeral_nfs/cluster_libraries/python/lib/python3.9/site-packages
