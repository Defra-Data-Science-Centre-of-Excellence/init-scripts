#!/bin/bash
FILE="/dbfs/databricks/scripts/cscrootcerts.crt"

# # Split up and add certs to SSL
# awk 'BEGIN {c=0;} /-----BEGIN CERTIFICATE-----/ {c++} { print > "/usr/local/share/ca-certificates/cscrootcert-" c ".crt"}' < $FILE
# update-ca-certificates
 
cp "$FILE" /usr/local/share/ca-certificates/cscrootcerts.crt
update-ca-certificates

# # Add certs to Java
# KEYSTORE=$JAVA_HOME"lib/security/cacerts"
# for ALIAS in $(ls /etc/ssl/certs/cscrootcert-*.pem); do
#   echo "Info: not adding $ALIAS using keytool, requires storepass >6chars"
#   # keytool -noprompt -import -trustcacerts -alias $ALIAS -keystore $KEYSTORE -storepass $PASSWORD
# done

# Append certs to worker nodes
echo "export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt" >> /databricks/spark/conf/spark-env.sh
/databricks/spark/scripts/restart_dbfs_fuse_daemon.sh
