"""
A `DataFrame` is already materialized, so this is a no-op.
"""
materialize(df::DataFrames.DataFrame) = df

"""
A `GroupedDataFrame` is already materialized, so this is a no-op.
"""
materialize(gdf::DataFrames.GroupedDataFrame) = gdf
