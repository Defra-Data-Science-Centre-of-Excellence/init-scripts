#!/bin/bash
# Installs the UCanAccess JAR on all cluster nodes.
# Places the jar in /databricks/jars for Spark and Java use.

set -euo pipefail

URL="https://repo1.maven.org/maven2/net/sf/ucanaccess/ucanaccess/5.0.1/ucanaccess-5.0.1.jar"
TARGET_DIR="/databricks/jars"
JAR_NAME="ucanaccess-5.0.1.jar"

mkdir -p "$TARGET_DIR"

echo "Downloading ${URL} ..."
wget -q -O "${TARGET_DIR}/${JAR_NAME}" "${URL}"

ln -sf "${TARGET_DIR}/${JAR_NAME}" "${TARGET_DIR}/ucanaccess-uber.jar"
chmod 0644 "${TARGET_DIR}/${JAR_NAME}" "${TARGET_DIR}/ucanaccess-uber.jar"

if [[ "${DB_IS_DRIVER:-false}" == "TRUE" ]]; then
  echo "UCanAccess JAR installed at: ${TARGET_DIR}/ucanaccess-uber.jar"
fi
