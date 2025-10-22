#!/bin/bash
# Install UCanAccess 5.0.1 and dependencies in /databricks/jars

set -euo pipefail

TARGET_DIR="/databricks/jars"
mkdir -p "$TARGET_DIR"

# Declare dependency URLs
JARS=(
  "https://repo1.maven.org/maven2/net/sf/ucanaccess/ucanaccess/5.0.1/ucanaccess-5.0.1.jar"
  "https://repo1.maven.org/maven2/com/healthmarketscience/jackcess/jackcess/3.0.1/jackcess-3.0.1.jar"
  "https://repo1.maven.org/maven2/org/hsqldb/hsqldb/2.5.0/hsqldb-2.5.0.jar"
  "https://repo1.maven.org/maven2/org/apache/commons/commons-lang3/3.8.1/commons-lang3-3.8.1.jar"
  "https://repo1.maven.org/maven2/commons-logging/commons-logging/1.2/commons-logging-1.2.jar"
)

echo "Installing UCanAccess 5.0.1 and dependencies to $TARGET_DIR"

for url in "${JARS[@]}"; do
  file="${url##*/}"
  dest="${TARGET_DIR}/${file}"
  echo "Downloading ${file} ..."
  wget --quiet --timeout=30 -O "$dest" "$url"
  chmod 0644 "$dest"
done

# Create a simple symlink for convenience
ln -sf "${TARGET_DIR}/ucanaccess-5.0.1.jar" "${TARGET_DIR}/ucanaccess-uber.jar"

echo "All UCanAccess dependencies installed successfully:"
ls -1 "$TARGET_DIR"/{ucanaccess*,jackcess*,hsqldb*,commons-*}

# Log confirmation on driver
if [[ "${DB_IS_DRIVER:-false}" == "TRUE" ]]; then
  echo "UCanAccess 5.0.1 is available at: $TARGET_DIR"
fi
