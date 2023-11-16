# Databricks notebook source
# MAGIC %md
# MAGIC Basic setup

# COMMAND ----------

import pandas as pd
my_postfix = "2402"
my_mountpoint_name = "sos_project"
pdf = pd.DataFrame({"a1":[2,3,4],"b2":[5,9,55]})
sdf = spark.createDataFrame(pdf)

# COMMAND ----------

# MAGIC %md
# MAGIC Notebook Test Cases Ref 1.1

# COMMAND ----------

try:
    path="dbfs:/mnt/base/unrestricted/source_defra_data_services_platform/dataset_ramsar"
    dbutils.fs.ls(path)
    print("Test 1.1 passed.")
except:
    print("An exception occurred")

# COMMAND ----------

# MAGIC %md
# MAGIC Notebook Test Case Ref 1.2

# COMMAND ----------

try:
    mount_point="dbfs:/mnt/base/unrestricted/"
    sdf.write.parquet(mount_point + "A_df_"+ my_postfix +".parquet", mode='overwrite') # This needs to fail!
    print("Test 1.2 passed.")
except:
    print("Writing failed, so test 1.2 has passed.")


# COMMAND ----------

# MAGIC %md
# MAGIC Notebook Test Case Ref 1.3

# COMMAND ----------

try:
    mount_point_r = "dbfs:/mnt/base/restricted/"
    sdf.write.parquet(mount_point + "B_df_"+ my_postfix +".parquet", mode='overwrite') # This needs to fail!
except:
    print("Writing failed, so test 1.3 has passed.")

# COMMAND ----------

# MAGIC %md
# MAGIC Notebook Test Case Ref 1.4

# COMMAND ----------

try:
    mount_point ="dbfs:/mnt/lab/unrestricted/share/"
    sdf.write.parquet(mount_point + "C_df_"+ my_postfix +".parquet", mode='overwrite')  
    print("Test 1.4 passed.")
except:
    print("Writing failed, so test 1.4 has failed.")

# COMMAND ----------

# MAGIC %md
# MAGIC Notebook Test Case Ref 1.5

# COMMAND ----------

try:
    mount_point ="dbfs:/mnt/lab/unrestricted/share/"
    sdf_  = spark.read.parquet(mount_point + "C_df_"+ my_postfix +".parquet") 
    print("Test 1.5 passed.")
except:
    print("Reading failed, so test 1.5 has failed.")
 
display(sdf_)

# COMMAND ----------

# MAGIC %md
# MAGIC Notebook Test Case Ref 1.6

# COMMAND ----------

try:
    mount_point ="dbfs:/mnt/lab/restricted/" + my_mountpoint_name + "/"
    sdf.write.parquet(mount_point + "D_df_"+ my_postfix +".parquet", mode='overwrite')  
    print("Test 1.6 passed.")
except:
    print("Writing failed, so test 1.6 has failed.")

# COMMAND ----------

# MAGIC %md
# MAGIC Notebook Test Case Ref 1.7

# COMMAND ----------

try:
    mount_point ="dbfs:/mnt/lab/restricted/" + my_mountpoint_name + "/"
    sdf_  = spark.read.parquet(mount_point + "D_df_"+ my_postfix +".parquet") 
    print("Test 1.7 passed.")
except:
    print("Reading failed, so test 1.7 has failed.")
 
display(sdf_)

# COMMAND ----------

# MAGIC %md
# MAGIC Notebook Test Case Ref 1.8

# COMMAND ----------

try:
    if my_mountpoint_name == "sos_project":
        mount_point ="dbfs:/mnt/lab/restricted/SMS-Project/"
    else:
        mount_point ="dbfs:/mnt/lab/restricted/sos_project/"
    sdf.write.parquet(mount_point + "E_df_"+ my_postfix +".parquet", mode='overwrite')  
    print("Test 1.8 appears to work when it should not.")
except:
    print("Writing failed, so test 1.8 has failed.")

# COMMAND ----------

# MAGIC %md
# MAGIC Notebook Test Case Ref 1.9

# COMMAND ----------

try:
    mount_point ="/dbfs/mnt/lab/restricted/sos_project/" + "rpa_sos_dashb_siti/"
    cars_  = pd.read_csv(mount_point  + "cars.csv") 
    if my_mountpoint_name == "sos_project":
        print("Test 1.9 passed as it should.")
    else: 
        print("Test 1.9 passed when it should not.")
except:
    if my_mountpoint_name == "sos_project":
        print("Reading failed, so 1.9 has failed.")
    else: 
        print("Reading failed, so test 1.9 has passed.")
