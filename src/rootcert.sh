#!/bin/bash
# SSL
#awk 'BEGIN {c=0;} /-----BEGIN CERTIFICATE-----/ {c++} { print > "/usr/local/share/ca-certificates/cscrootcert-" c ".pem"}' < "/dbfs/databricks/scripts/cscrootcerts.crt"
cp "/dbfs/databricks/scripts/cscrootcerts.crt" "/usr/local/share/ca-certificates/cscrootcerts.crt"
update-ca-certificates

# Java
#keytool -noprompt -import -trustcacerts -alias $ALIAS -keystore $KEYSTORE -storepass $PASSWORD

# Spark
echo "export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt" >> /databricks/spark/conf/spark-env.sh
/databricks/spark/scripts/restart_dbfs_fuse_daemon.sh
