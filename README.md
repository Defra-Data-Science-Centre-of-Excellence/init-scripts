# init-scripts
Short shell scripts for initialising data science Linux environments.


## Environments
<table>
  <thead><tr>
    <th>Environment</th>
    <th>Install Guide</th>
    <th></th>
  </tr></thead>
  <tbody><tr>
    <td><a href="DASH.sh">DASH</a></td>
    <td>add repo, add init script, add environmental variables</td>
    <td><code>/Repos/USER/init-scripts/DASH.sh</code></td>
  </tr><tr>
    <td><a href="src/dbfs_clean.py">DBFS Clean</a></td>
    <td>schedule for weekends</td>
    <td></td>
  </tr><tr>
    <td>rootcert</td>
    <td>add manually</td>
    <td></td>
  </tr><tr>
    <td><a href="SCE.sh">SCE</a></td>
    <td>run in terminal</td>
    <td><code>wget -O- https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/main/SCE.sh | bash</code></td>
  </tr><tr>
    <td><a href="src/swapfile.sh">SwapFile</a></td>
    <td>run in terminal</td>
    <td><code>wget -O- https://raw.githubusercontent.com/Defra-Data-Science-Centre-of-Excellence/init-scripts/main/src/swapfile.sh | bash</code></td>
  </tr></tbody>
</table>


## Libraries
| Library | in SCE | in DASH 1_RStudio | in DASH 3_GeoVector |
| ------- | ------ | ----------------- | ------------------- |
| [Update](src/update.sh) | ✔ | ✔ | ✔ |
| [Base Libraries](src/base_libs.sh) | ✔ | ✔ | ✔ |
| [Geospatial Libraries](src/gis_libs.sh) † | ❌ | ❌ | ✔ |
| [Crontab AutoUpdate](SCE.sh#L9) | ✔ | ❌ | ❌ |
| [nginx](src/nginx-server.sh) | ✔ | ❌ | ❌ |
| [RStudio Server](src/rstudio-server.sh) | ✔ | ❌ | ❌ |
| [Shiny Server](src/shiny-server.sh) | ✔ | ❌ | ❌ |
| [Jupyter Server](src/jupyter-server.sh) ‡ | ❌ | ❌ | ❌ |

> † [Sedona requires extra spark config](https://sedona.apache.org/latest-snapshot/setup/databricks/)  
> ‡ WIP - help wanted

<details>
  <summary><h3>Libraries: in depth</h3></summary>

| Script | Lang | Library | Group |
| ------ | ---- | ------- | ----- |
| Runtime 12 | [Databricks Runtime](https://docs.databricks.com/release-notes/runtime/releases.html)
| Runtime 12 | [R]([https://docs.databricks.com/release-notes/runtime/12.2#--installed-r-libraries) |
| Runtime 12 | [py](https://docs.databricks.com//release-notes/runtime/12.2#installed-python-libraries) |
| Base | ppa | ppa:c2d4u.team/c2d4u4.0+ | R-Cran binary install |
| Base | ppa | ppa:ubuntugis/ppa | Geospatial |
| Base | bin | parallel | GNU |
| Base | R | renv | RStudio Connect |
| Base | R | devtools | RStudio Connect |
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
| Base | bin | libgdal-dev | Geospatial |
| Base | bin | libgeos-dev | Geospatial |
| Base | bin | libproj-dev | Geospatial |
| Base | bin | libspatialindex-dev | Geospatial |
| Base | bin | libsqlite3-mod-spatialite | Geospatial |
| Base | py | spatialite | Geospatial |
| Base | py | rtree | Geospatial |
| Base | py | pyproj | Geospatial |
| Base | py | pyogrio | Geospatial |
| Base | py | geopandas | Geospatial |
| Base | py | geocube | Geospatial |
| Geo | jar | geotools-wrapper | Sedona |
| Geo | jar | sedona-python-adapter | Sedona |
| Geo | jar | sedona-viz | Sedona |
| Geo | py | apache-sedona | Sedona |
| Geo | py | databricks-mosaic | Mosaic |

</details>
