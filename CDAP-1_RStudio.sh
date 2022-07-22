#!/bin/bash
URL=https://raw.githubusercontent.com/aw-west-defra/init/main/src/
wget -O - $URL"update.sh" | bash
wget -O - $URL"base_libs.sh" | bash
