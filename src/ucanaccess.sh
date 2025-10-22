#!/bin/bash
# Installs the UCanAccess "uber" JAR on all cluster nodes.
# Places the jar in /databricks/jars so Spark/Java code can use it immediately.

set -euo pipefail

set -euo pipefail
VERSIONS=("5.0.1")
BASE_URL=https://repo1.maven.org/maven2/io/github/spannm/ucanaccess
TARGET_DIR=/databricks/jars
mkdir -p "$TARGET_DIR"

for ver in "${VERSIONS[@]}"; do
  jar="ucanaccess-${ver}-uber.jar"
  url="${BASE_URL}/${ver}/${jar}"
  echo "Attempting to download ${url} ..."
  if wget --quiet --timeout=10 -O "${TARGET_DIR}/${jar}" "${url}"; then
    ln -sf "${TARGET_DIR}/${jar}" "${TARGET_DIR}/ucanaccess-uber.jar"
    echo "Downloaded ${jar} to ${TARGET_DIR}"
    chmod 0644 "${TARGET_DIR}/${jar}" "${TARGET_DIR}/ucanaccess-uber.jar"
    break
  fi
done
if [[ -z "${downloaded}" ]]; then
  echo "ERROR: Could not download UCanAccess uber JAR from Maven Central." >&2
  exit 1
fi

chmod 0644 "${downloaded}" "${TARGET_DIR}/ucanaccess-uber.jar"

# Log on driver for visibility
if [[ "${DB_IS_DRIVER:-false}" == "TRUE" ]]; then
  echo "UCanAccess uber JAR is installed at: ${TARGET_DIR}/ucanaccess-uber.jar"
fi
