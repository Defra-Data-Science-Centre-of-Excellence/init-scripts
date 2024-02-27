# Databricks notebook source
# MAGIC %md # Test GeoVector Libraries
# MAGIC
# MAGIC > | Status | Test              | Checks                                                                     | Notes                     |
# MAGIC > |--------|-------------------|----------------------------------------------------------------------------|---------------------------|
# MAGIC > | ✔️ | osmnx             | `osmnx.geometries_from_place`, `geopandas.to_file`, `geopandas.to_parquet` | downloads data
# MAGIC > | ✔️ | osdatahub         | OS FeaturesAPI                                                             | downloads data, requires key
# MAGIC > | ❌ | R sf              | `sf::st_load`, `sf::plot`                                                  | sf install is broken for notebooks but works for tmux and rstudio server
# MAGIC > | ✔️ | contextily        | `contextily.add_basemap`, OS MapsAPI                                       | requires key and provider
# MAGIC > | ✔️ | folium            | `geopandas.explore`, OS MapsAPI                                            | requires key and provider
# MAGIC > | ✔️ | apache-sedona     | Register, `ST_GeomFromWKB`, `ST_Length`, `ST_Area`                         |
# MAGIC > | ✔️ | databricks-mosaic | `enable_mosaic`, `st_geomfromwkb`, `st_length`, `st_area`                  |
# MAGIC >
# MAGIC > Table of Tests
# MAGIC
# MAGIC > | Language | Package           | Status     | Purpose     | Notes           |
# MAGIC > |----------|-------------------|------------|-------------|-----------------|
# MAGIC > | R        | sf                | installed  |             | FAILED INSTALL  |
# MAGIC > | R        | sf                | to install |             | FAILED INSTALL  |
# MAGIC > | Python   | geopandas         | installed  | analysis    |                 |
# MAGIC > | Python   | apache-sedona     | installed  | analysis    | requires .jars  |
# MAGIC > | Python   | databricks-mosaic | installed  | analysis    |                 |
# MAGIC > | Python   | contextily        | to install | plotting    |                 |
# MAGIC > | Python   | folium            | to install | plotting    |                 |
# MAGIC > | Python   | osmnx             | to install | data source | OpenStreetMap   |
# MAGIC > | Python   | osdatahub         | to install | data source | Ordnance Survey |
# MAGIC >
# MAGIC > Table of Libraries
# MAGIC
# MAGIC
# MAGIC > | Source          | Product | Domain         | Format     | Filepath                      |
# MAGIC > |-----------------|---------|----------------|------------|-------------------------------|
# MAGIC > | OpenStreetMap   | Water   | Northumberland | geojson    | `dbfs:/tmp/osm_water.geojson` |
# MAGIC > | OpenStreetMap   | Water   | Northumberland | geoparquet | `dbfs:/tmp/osm_water.parquet` |
# MAGIC > | Ordnance Survey | Water   | Northumberland | geoparquet | `dbfs:/tmp/os_water.parquet`  |
# MAGIC >
# MAGIC > Table of Datasets

# COMMAND ----------

# MAGIC %pip install -q pyogrio folium contextily geopandas osmnx osdatahub

# COMMAND ----------

# MAGIC %r
# MAGIC # install.packages('sf', quiet=TRUE)  # SLOW!

# COMMAND ----------

# MAGIC %py
# MAGIC import osmnx as ox
# MAGIC ox.settings.cache_folder = '/dbfs/tmp/'
# MAGIC # ox.settings.requests_kwargs = {'verify': False}
# MAGIC
# MAGIC
# MAGIC place, tags = 'Northumberland', {'water':True,'waterway':True}
# MAGIC gdf = (ox.features_from_place(place, tags)
# MAGIC   .reset_index()
# MAGIC   .assign(gtype = lambda df: df.geom_type)
# MAGIC   [['osmid', *tags.keys(), 'gtype', 'geometry']]
# MAGIC   .to_crs(27700)
# MAGIC )
# MAGIC
# MAGIC gdf.to_file('/dbfs/tmp/osm_water.geojson')
# MAGIC gdf.to_parquet('/dbfs/tmp/osm_water.parquet')
# MAGIC
# MAGIC gdf

# COMMAND ----------

# MAGIC %py
# MAGIC import pandas as pd
# MAGIC import geopandas as gpd
# MAGIC from osdatahub.FeaturesAPI import FeaturesAPI
# MAGIC from osdatahub import Extent
# MAGIC
# MAGIC def os_geometries_from_bbox(key, product, bbox):
# MAGIC   extent = Extent.from_bbox(bbox, crs='EPSG:27700')
# MAGIC   features = FeaturesAPI(key, product, extent)
# MAGIC   results = features.query(100)
# MAGIC   return gpd.GeoDataFrame.from_features(results).set_crs(27700)
# MAGIC
# MAGIC
# MAGIC key = '1Um9wsyyAkyTbyeVoSJB1VrbSfNqoTGw'
# MAGIC bbox = [356180, 543074, 434582, 657600]  # Northumberland
# MAGIC gdf = pd.concat([
# MAGIC   os_geometries_from_bbox(key, 'Zoomstack_Surfacewater', bbox),
# MAGIC   os_geometries_from_bbox(key, 'Zoomstack_Waterlines', bbox),
# MAGIC ])
# MAGIC
# MAGIC gdf.to_parquet('/dbfs/tmp/os_water.parquet')
# MAGIC
# MAGIC gdf

# COMMAND ----------

# MAGIC %r
# MAGIC library('sf')
# MAGIC
# MAGIC f = '/dbfs/tmp/osm_water.geojson'
# MAGIC
# MAGIC df = st_read(f)
# MAGIC
# MAGIC plot(df)

# COMMAND ----------

# MAGIC %py
# MAGIC # Test Contextily
# MAGIC import contextily as ctx
# MAGIC import geopandas as gpd
# MAGIC
# MAGIC
# MAGIC f = '/dbfs/tmp/osm_water.parquet'
# MAGIC
# MAGIC gdf = gpd.read_parquet(f).to_crs(3857)
# MAGIC
# MAGIC ax = gdf.plot(figsize=[9,16], linewidth=.5, markersize=2)
# MAGIC ax.axis('off')
# MAGIC ctx.add_basemap(ax=ax)

# COMMAND ----------

# MAGIC %py
# MAGIC # Test Folium
# MAGIC import geopandas as gpd
# MAGIC
# MAGIC
# MAGIC f = '/dbfs/tmp/os_water.parquet'
# MAGIC
# MAGIC gdf = gpd.read_parquet(f)
# MAGIC gdf['id'] = gdf['GmlID']
# MAGIC gdf['length (m)'] = gdf['SHAPE_Length'].round()
# MAGIC gdf['area (sqm)'] = gdf['SHAPE_Area'].round()
# MAGIC gdf['gtype'] = gdf.geom_type
# MAGIC gdf = (gdf
# MAGIC   [['id', 'length (m)', 'area (sqm)', 'gtype', 'geometry']]
# MAGIC   .sort_values('length (m)')
# MAGIC   [-500:]
# MAGIC )
# MAGIC
# MAGIC gdf.explore(width=800, height=450, location=[55.178, -2.468], zoom_start=12, style_kwds={'weight':.5})

# COMMAND ----------

# MAGIC %sh
# MAGIC ls /databricks/jars/*geotools*.jar
# MAGIC ls /databricks/jars/*sedona*.jar
# MAGIC

# COMMAND ----------

# MAGIC %py
# MAGIC from pyspark.sql import functions as F
# MAGIC from sedona.register import SedonaRegistrator
# MAGIC SedonaRegistrator.registerAll(spark)
# MAGIC
# MAGIC sf = 'dbfs:/tmp/os_water.parquet'
# MAGIC
# MAGIC sdf = spark.read.parquet(sf).select(
# MAGIC   F.expr('ST_GeomFromWKB(geometry)').alias('geometry')
# MAGIC )
# MAGIC
# MAGIC display(sdf)

# COMMAND ----------

import mosaic
mosaic.enable_mosaic(spark)

sf = 'dbfs:/tmp/os_water.parquet'

sdf = spark.read.parquet(sf).select(
  mosaic.st_geomfromwkb('geometry').alias('geometry')
)

display(sdf)
