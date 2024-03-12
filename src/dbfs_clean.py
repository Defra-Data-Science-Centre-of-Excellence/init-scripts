# Clear extra folders
find /dbfs/ -mindepth 1 -maxdepth 1 -type d \
  ! -name databricks \
  ! -name databricks-datasets \
  ! -name databricks-results \
  ! -name FileStore \
  ! -name mnt \
  ! -name tmp \
  ! -name user \
  | rm -r
# Clear 30 days old FileStore
find /dbfs/FileStore/* -atime 30 | xargs rm 
find /dbfs/FileStore/ -type d -empty | xargs rm
# Clear 30 days old tmp
find /dbfs/tmp/* -atime 30 | xargs rm
find /dbfs/tmp/ -type d -empty | xargs rm
