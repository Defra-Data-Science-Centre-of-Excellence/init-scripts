#!/bin/bash
RAW_FILE="/dbfs/databricks/scripts/cscrootcert.crt"
BUNDLE_FILE="/etc/ssl/certs/cscrootcert.crt"
 
cp $RAW_FILE $BUNDLE_FILE
update-ca-certificates

# PEM_FILE="/etc/ssl/certs/cscrootcert.pem"
# PASSWORD=""
# JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")
# KEYSTORE="$JAVA_HOME/lib/security/cacerts"
# CERTS=$(grep 'END CERTIFICATE' $PEM_FILE| wc -l)

# # To process multiple certs with keytool, you need to extract
# # each one from the PEM file and import it into the Java KeyStore.
# for N in $(seq 0 $(($CERTS - 1))); do
#   ALIAS="$(basename $PEM_FILE)-$N"
#   echo "Adding to keystore with alias:$ALIAS"
#   cat $PEM_FILE |
#     awk "n==$N { print }; /END CERTIFICATE/ { n++ }" |
#     keytool -noprompt -import -trustcacerts -alias $ALIAS -keystore $KEYSTORE -storepass $PASSWORD
# done

# Append certs to worker nodes
echo "export REQUESTS_CA_BUNDLE=$BUNDLE_FILE" >> /databricks/spark/conf/spark-env.sh
/databricks/spark/scripts/restart_dbfs_fuse_daemon.sh
