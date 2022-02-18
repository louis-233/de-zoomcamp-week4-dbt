{{ config(materialized='view') }}

/* select * from trips_data_all.yellow_tripdata; */

select * 
from {{ source('my_staging_gcp', 'yellow_tripdata_2019-01') }}
limit 100;
