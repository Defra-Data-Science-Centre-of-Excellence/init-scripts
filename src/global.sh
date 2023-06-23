DIR=/dbfs/databricks/scripts

. $DIR/rootcert.sh
. $DIR/update.sh
. $DIR/base_libs.sh
if [[ "$DB_CLUSTER_ID" == *"Geo"* ]]; then
  . $DIR/gis_libs.sh
fi
