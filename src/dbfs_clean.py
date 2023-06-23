# Databricks notebook source
# MAGIC %sh
# MAGIC # Clear extra folders
# MAGIC ls /dbfs/ | awk \
# MAGIC   '!/databricks/ && !/databricks-datasets/ && !/databricks-results/ && !/FileStore/ && !/mnt/ && !/tmp/ && !/user/ ' \
# MAGIC   | xargs rm
# MAGIC
# MAGIC # Clear 30 days old FileStore
# MAGIC find /dbfs/FileStore/* -atime 30 | xargs rm 
# MAGIC find /dbfs/FileStore/ -type d -empty | xargs rm
# MAGIC
# MAGIC # Clear 30 days old tmp
# MAGIC find /dbfs/tmp/* -atime 30 | xargs rm
# MAGIC find /dbfs/tmp/ -type d -empty | xargs rm
# MAGIC
