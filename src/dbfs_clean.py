# Databricks notebook source
# MAGIC %sh
# MAGIC # Clear extra folders
# MAGIC find /dbfs/ -mindepth 1 -maxdepth 1 -type d \
# MAGIC   ! -name databricks \
# MAGIC   ! -name databricks-datasets \
# MAGIC   ! -name databricks-results \
# MAGIC   ! -name FileStore \
# MAGIC   ! -name mnt \
# MAGIC   ! -name tmp \
# MAGIC   ! -name user \
# MAGIC   | rm -r
# MAGIC
# MAGIC # Clear 30 days old FileStore
# MAGIC find /dbfs/FileStore/* -atime 30 | xargs rm 
# MAGIC find /dbfs/FileStore/ -type d -empty | xargs rm
# MAGIC
# MAGIC # Clear 30 days old tmp
# MAGIC find /dbfs/tmp/* -atime 30 | xargs rm
# MAGIC find /dbfs/tmp/ -type d -empty | xargs rm
# MAGIC
