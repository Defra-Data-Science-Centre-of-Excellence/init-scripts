# init-scripts
Short shell scripts for initialising data science Linux environments.


## Environments
| Environment | Install Using | single line |
| ----------- | ------------- | ----------- |
| [SCE](SCE.sh) | run in terminal | <code>wget -O- https://raw.githubusercontent.com/aw-west-defra/init-scripts/main/SCE.sh \| bash</code> |
| [CDAP 1_RStudio](CDAP-1_RStudio.sh) | run in cell, add init script | <code>%sh wget -O /dbfs/databricks/scripts/1_rstudio.sh https://raw.githubusercontent.com/aw-west-defra/init-scripts/main/CDAP-1_RStudio.sh</code> |
| [CDAP 3_GeoVector](CDAP-3_GeoVector.sh) | run in cell, add init script, add spark config | <code>%sh wget -O /dbfs/databricks/scripts/3_geovector.sh https://raw.githubusercontent.com/aw-west-defra/init-scripts/main/CDAP-3_GeoVector.sh</code> |


## Libraries
| Library | in SCE | in CDAP 1_RStudio | in CDAP 3_GeoVector |
| ------- | ------ | ----------------- | ------------------- |
| [Update](src/update.sh) | ✔ | ✔ | ✔ |
| [Base Libraries](src/base_libs.sh) | ✔ | ✔ | ✔ |
| [Geospatial Libraries](src/gis_libs.sh) † | ❌ | ❌ | ✔ |
| [Crontab AutoUpdate](SCE.sh#L9) | ✔ | ❌ | ❌ |
| [nginx](src/nginx-server.sh) | ✔ | ❌ | ❌ |
| [RStudio Server](src/rstudio-server.sh) | ✔ | ❌ | ❌ |
| [Shiny Server](src/shiny-server.sh) | ✔ | ❌ | ❌ |
| [Jupyter Server](src/jupyter-server.sh) ‡ | ❌ | ❌ | ❌ |

> † [Sedona requires extra spark config](https://sedona.apache.org/setup/databricks/)  
> ‡ WIP  
> *Base Libraries were defined using requests from several users.  Their dependency tree was reduced.  [Here](rsc/Find_Missing_R_Libs.R) is that analysis.*  
> *Geospatial libraries currently include Sedona, Mosaic, and Pyspark-Vector-Files.*
