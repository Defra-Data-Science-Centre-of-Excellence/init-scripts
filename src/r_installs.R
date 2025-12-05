install.packages("Rcpp", repos="https://cloud.r-project.org")
options(Ncpus = parallel::detectCores() - 2)
install.packages(c(
    "sparklyr",
    "rsconnect",
    "connectapi",
    "brickster"
), repos="https://cloud.r-project.org")
