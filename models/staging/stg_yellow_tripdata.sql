{{ config(materialized='view') }}

/* select * from trips_data_all.yellow_tripdata; */

select * 
from {{ source('my_staging_gcp', 'trips_data_all') }}
limit 100;
