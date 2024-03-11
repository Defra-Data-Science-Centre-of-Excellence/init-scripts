#!/bin/bash
echo $DB_CLUSTER_NAME


# - - - CSC Root Certificate - - -
# cscrootcert script must be run from local
RAW_FILE="/dbfs/databricks/scripts/cscrootcert.crt"
BUNDLE_FILE="/usr/local/share/ca-certificates/cscrootcert.crt"

cp $RAW_FILE $BUNDLE_FILE
 
update-ca-certificates

PEM_FILE="/etc/ssl/certs/cscrootcert.pem"
PASSWORD=""
JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::")
KEYSTORE="$JAVA_HOME/lib/security/cacerts"

CERTS=$(grep 'END CERTIFICATE' $PEM_FILE| wc -l)

# To process multiple certs with keytool, you need to extract
# each one from the PEM file and import it into the Java KeyStore.
for N in $(seq 0 $(($CERTS - 1))); do
  ALIAS="$(basename $PEM_FILE)-$N"
  echo "Adding to keystore with alias:$ALIAS"
  cat $PEM_FILE |
    awk "n==$N { print }; /END CERTIFICATE/ { n++ }" |
      keytool -noprompt -import -trustcacerts -alias $ALIAS -keystore $KEYSTORE -storepass $PASSWORD
done

echo "export REQUESTS_CA_BUNDLE=/etc/ssl/certs/ca-certificates.crt" >> /databricks/spark/conf/spark-env.sh

/databricks/spark/scripts/restart_dbfs_fuse_daemon.sh
# - - - CSC Root Certificate - - -


# - - - Install Scripts - - -
URL=https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/pantelisindefra-patch-1/src
wget $URL/update.sh -O- | bash
wget $URL/base_libs.sh -O- | bash
if [[ "$DB_CLUSTER_NAME" == *"RStu"* ]]; then  # If RStu in cluster name
  wget -qO- $URL/r_installs.R | Rscript -
fi
if [[ "$DB_CLUSTER_NAME" == *"Geo"* ]]; then  # If Geo in cluster name
  wget $URL/gis_libs.sh -O- | bash
fi
# - - - Install Scripts - - -
