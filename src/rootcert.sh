#!/bin/bash
f0="/dbfs/databricks/scripts/cscrootcerts.crt"
f1="/etc/ssl/certs/cscrootcert.crt"
cp $f0 $f1
update-ca-certificates
echo "export REQUESTS_CA_BUNDLE=$f1" >> /databricks/spark/conf/spark-env.sh
/databricks/spark/scripts/restart_dbfs_fuse_daemon.sh
