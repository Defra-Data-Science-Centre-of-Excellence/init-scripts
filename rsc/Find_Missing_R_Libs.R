# Install Libraries
installed = sort(row.names(data.frame(installed.packages())))
installed


# Requested Libraries
## Source:  Teams message from Sam Finlayson
Sam = c('survey', 'srvyr', 'DBI', 'RPostgres', 'knitr', 'testthat', 'config', 'rlang', 'readxl', 'progress', 'magrittr', 'fs', 'logger', 'withr', 'yaml', 'rmarkdown', 'pacman', 'janitor')
Cris = c('purrr', 'readr', 'shinydashboardPlus', 'shinyWidgets', 'bs4Dash', 'tidyr', 'devtools')
Mark = c('RSQLite', 'igraph', 'ggraph', 'graphlayouts', 'htmltools', 'xml2', 'usethis', 'pkgdown', 'odbc', 'progress', 'logger', 'R6', 'stringr', 'ggplot2')
FarmStats = c('shinycssloaders', 'scales', 'DT', 'treemap', 'highcharter', 'fuzzyjoin', 'lexicon', 'visNetwork', 'httr', 'rdrop2', 'lubridate')
## Source:  SCE script https://github.com/jtsmith275/RStudioShiny-nginx/
jtsmith = c('shiny', 'directlabels', 'shinydashboard', 'ggplot2', 'plotly', 'scales', 'forcats', 'stringr', 'DT', 'readxl', 'tidyr', 'zoo', 'lubridate', 'reshape2', 'lemon', 'RColorBrewer', 'networkD3', 'shinyWidgets', 'shinyjs', 'shinycssloaders', 'openxlsx', 'readr', 'gcookbook', 'ggrepel', 'readODS', 'doBy', 'rtweet', 'httpuv', 'purrr', 'tm', 'wordcloud', 'jsonlite', 'lda', 'LDAvis', 'udpipe', 'lattice', 'tidytext', 'knitr', 'rmarkdown', 'readxl', 'htmltools', 'bs4Dash', 'tidyverse', 'dplyr', 'devtools', 'formatR', 'remotes', 'selectr', 'caTools', 'BiocManager', 'RColorBrewer', 'RandomFields', 'RNetCDF', 'classInt', 'deldir', 'gstat', 'hdf5r', 'lidR', 'mapdata', 'maptools', 'mapview', 'ncdf4', 'proj4', 'raster', 'rgdal', 'rgeos', 'rlas', 'sf', 'sp', 'spacetime', 'spatstat', 'spdep', 'geoR', 'geosphere', 'forcats', 'shinycssloaders', 'odbc', 'fs', 'rlang', 'tibble', 'survey', 'stringr', 'survey', 'mosaic', 'DBI', 'fs', 'lubridate', 'magrittr', 'yaml', 'knitr', 'rmarkdown', 'testthat', 'chron', 'countrycode', 'geojsonio', 'shinythemes', 'shinyTime', 'colourpicker', 'leaflet.minicharts', 'janitor', 'polite', 'rworldmap', 'shinyAce', 'treemap', 'directlabels')
## Source:  ADB_Cluster_Libraries.xlsx by David Chan
lindsey = c('officer', 'flextable', 'data.table', 'shinydashboard', 'shinycssloaders', 'scales', 'reshape2', 'treemap', 'RODBC', 'wordcloud', 'SnowballC', 'tm', 'forcats', 'RColorBrewer')
awest = c('shinyWidgets', 'shinyjs', 'shiny', 'plotly', 'tidyverse', 'DT', 'openxlsx', 'sf', 'leaflet')

requested = sort(unique(c(Sam, Cris, Mark, FarmStats, jtsmith, lindsey, awest)))
requested


# Known Unneeded Libraries
use_remotes = c('pacman', 'devtools')

remove = sort(unique(use_remotes))
remove

 
# Difference
found = setdiff(setdiff(requested, remove), installed)
found


# Read RCran PPA to find available packages
"""
%sh
ls /var/lib/apt/lists/

%sh
sudo apt-get install -y liblz4-tool

%sh
lz4cat /var/lib/apt/lists/ppa.launchpad.net_c2d4u.team_c2d4u4.0+_ubuntu_dists_focal_main_binary-amd64_Packages.lz4 | grep 'Package:' | sort | uniq > /dbfs/databricks/scripts/rcran_packages.txt

%py
found = set(['BiocManager', 'bs4Dash', 'caTools', 'colourpicker', 'countrycode', 'deldir', 'directlabels', 'doBy', 'flextable', 'formatR', 'fuzzyjoin', 'gcookbook', 'geojsonio', 'geoR', 'geosphere', 'ggraph', 'ggrepel', 'graphlayouts', 'gstat', 'hdf5r', 'highcharter', 'igraph', 'janitor', 'lda', 'LDAvis', 'leaflet.minicharts', 'lemon', 'lexicon', 'lidR', 'logger', 'mapdata', 'maptools', 'mapview', 'mosaic', 'ncdf4', 'networkD3', 'odbc', 'officer', 'openxlsx', 'pkgdown', 'plotly', 'polite', 'proj4', 'RandomFields', 'rdrop2', 'readODS', 'rgdal', 'rgeos', 'rlas', 'RNetCDF', 'RPostgres', 'rtweet', 'rworldmap', 'shinyAce', 'shinydashboardPlus', 'shinythemes', 'shinyTime', 'shinyWidgets', 'SnowballC', 'spacetime', 'spatstat', 'spdep', 'srvyr', 'survey', 'tidytext', 'tm', 'treemap', 'udpipe', 'visNetwork', 'wordcloud', 'zoo'])

rcran = set(
  x \
    .split('r-cran-')[1] \
    .split('\nPackage:')[0]
  for x in open(
    '/dbfs/databricks/scripts/rcran_packages.txt', 'r'
  ).read().split(' ')
  if 'r-cran-' in x
)

not_in_cran = found.difference(rcran)
in_cran = found.intersection(rcran)
"""


# Outputs
found = c('BiocManager', 'bs4Dash', 'caTools', 'colourpicker', 'countrycode', 'deldir', 'directlabels', 'doBy', 'flextable', 'formatR', 'fuzzyjoin', 'gcookbook', 'geojsonio', 'geoR', 'geosphere', 'ggraph', 'ggrepel', 'graphlayouts', 'gstat', 'hdf5r', 'highcharter', 'igraph', 'janitor', 'lda', 'LDAvis', 'leaflet.minicharts', 'lemon', 'lexicon', 'lidR', 'logger', 'mapdata', 'maptools', 'mapview', 'mosaic', 'ncdf4', 'networkD3', 'odbc', 'officer', 'openxlsx', 'pkgdown', 'plotly', 'polite', 'proj4', 'RandomFields', 'rdrop2', 'readODS', 'rgdal', 'rgeos', 'rlas', 'RNetCDF', 'RPostgres', 'rtweet', 'rworldmap', 'shinyAce', 'shinydashboardPlus', 'shinythemes', 'shinyTime', 'shinyWidgets', 'SnowballC', 'spacetime', 'spatstat', 'spdep', 'srvyr', 'survey', 'tidytext', 'tm', 'treemap', 'udpipe', 'visNetwork', 'wordcloud', 'zoo')

not_in_rcran = c('BiocManager', 'LDAvis', 'RNetCDF', 'RPostgres', 'RandomFields', 'SnowballC', 'bs4Dash', 'caTools', 'doBy', 'formatR', 'gcookbook', 'geoR', 'leaflet.minicharts', 'lemon', 'lexicon', 'lidR', 'logger', 'networkD3', 'pkgdown', 'readODS', 'shinyAce', 'shinyTime', 'shinyWidgets', 'shinydashboardPlus', 'visNetwork')

in_rcran = c('colourpicker', 'countrycode', 'deldir', 'directlabels', 'flextable', 'fuzzyjoin', 'geojsonio', 'geosphere', 'ggraph', 'ggrepel', 'graphlayouts', 'gstat', 'hdf5r', 'highcharter', 'igraph', 'janitor', 'lda', 'mapdata', 'maptools', 'mapview', 'mosaic', 'ncdf4', 'odbc', 'officer', 'openxlsx', 'plotly', 'polite', 'proj4', 'rdrop2', 'rgdal', 'rgeos', 'rlas', 'rtweet', 'rworldmap', 'shinythemes', 'spacetime', 'spatstat', 'spdep', 'srvyr', 'survey', 'tidytext', 'tm', 'treemap', 'udpipe', 'wordcloud', 'zoo')


# Suggestion
'''
arrow
biocmanager
bs4dash
janitor
odbc
plotly
rgdal
rpostgres
srvyr
zoo
'''
