# init-scripts
Short shell scripts for initialising data science Linux environments.


## Environments
| Environment | Install Using | single line |
| ----------- | ------------- | ----------- |
| [SCE](SCE.sh) | run in terminal | <code>wget -O- https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/main/SCE.sh \| bash</code> |
| [CDAP 1_RStudio](CDAP-1_RStudio.sh) | run in cell, add init script | <code>%sh echo 'wget -O- --no-check-certificate https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/main/CDAP-1_RStudio.sh \| bash' > /dbfs/databricks/scripts/1_rstudio.sh</code> |
| [CDAP 3_GeoVector](CDAP-3_GeoVector.sh) | run in cell, add init script, add spark config | <code>%sh echo 'wget -O- --no-check-certificate https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/main/CDAP-3_GeoVector.sh \| bash' > /dbfs/databricks/scripts/3_geovector.sh</code> |



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

<details>
  <summary><h3>Libraries: in depth</h3></summary>

| Script | Lang | Library | Group |
| ------ | ---- | ------- | ----- |
| Runtime 10.4 | [R](https://docs.microsoft.com/en-us/azure/databricks/release-notes/runtime/10.4#--installed-r-libraries) |
| Runtime 10.4 | [py](https://docs.microsoft.com/en-us/azure/databricks/release-notes/runtime/10.4#installed-python-libraries) |
| Base | ppa | ppa:c2d4u.team/c2d4u4.0+ | R-Cran binary install |
| Base | ppa | ppa:ubuntugis/ppa | Geospatial |
| Base | R | renv | RStudio Connect |
| Base | R | rstudioapi | RStudio Connect |
| Base | R | packrat | RStudio Connect |
| Base | R | rsconnect | RStudio Connect |
| Base | R | dt | Shiny |
| Base | R | shinyjs | Shiny |
| Base | R | shinydashboard | Shiny |
| Base | R | shinycssloaders | Shiny |
| Base | R | sf | Geospatial |
| Base | R | raster | Geospatial |
| Base | R | leaflet | Geospatial |
| Base | R | arrow |
| Base | R | plotly |
| Base | R | biocmanager | Farm Stats | 
| Base | R | bs4dash | Farm Stats |
| Base | R | janitor | Farm Stats |
| Base | R | odbc | Farm Stats |
| Base | R | rgdal | Farm Stats |
| Base | R | rpostgres | Farm Stats |
| Base | R | srvyr | Farm Stats |
| Base | R | zoo | Farm Stats |
| Base | py | pandas |
| Base | py | matplotlib |
| Base | py | openpyxl |
| Base | bin | libsqlite3-mod-spatialite | Geospatial |
| Base | py | spatialite | Geospatial |
| Base | py | rtree | Geospatial |
| Base | py | pyproj | Geospatial |
| Base | py | geopandas | Geospatial |
| Base | py | geocube | Geospatial |
| Geo | jar | geotools-wrapper | Sedona |
| Geo | jar | sedona-python-adapter | Sedona |
| Geo | jar | sedona-viz | Sedona |
| Geo | py | apache-sedona | Sedona |
| Geo | py | databricks-mosaic | Mosaic |
| Geo | ppa | ppa:ubuntugis/ubuntugis-unstable | pyspark-vector-files |
| Geo | bin | libudunits-dev | pyspark-vector-files |
| Geo | bin | libgdal-dev | pyspark-vector-files |
| Geo | bin | libgeos-dev | pyspark-vector-files |
| Geo | bin | libproj-dev | pyspark-vector-files |
| Geo | bin | libspatialindex-dev | pyspark-vector-files |
| Geo | py | pyspark-vector-files | pyspark-vector-files |

</details>
