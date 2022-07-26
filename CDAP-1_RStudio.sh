#!/bin/bash
URL=https://raw.githubusercontent.com/https://github.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/main
wget -O - $URL/src/update.sh | bash
wget -O - $URL/src/base_libs.sh | bash
