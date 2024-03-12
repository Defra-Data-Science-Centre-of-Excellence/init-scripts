lib_list <- c(
    "rlang", "renv", "devtools", "rstudioapi", "reticulate", "packrat", "rsconnect",
    "openxlsx", "writexl", "here", "odbc", "RPostgres",
    "DT", "shinyjs", "shinydashboard", "shinycssloaders", "crosstalk",
    "plotly", "ggplot2", "cowplot", "viridis",
    "gdalBindings", "sf", "raster", "leaflet",
    "BiocManager", "janitor", "srvyr", "zoo", "BH", "cli", "lazyeval", "snakecase"
)
install.packages(lib_list, repos="https://cloud.r-project.org")
