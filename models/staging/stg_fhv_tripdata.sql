{{ config(materialized='view') }}

select *
--    dispatching_base_num	STRING	NULLABLE	
--    pickup_datetime	TIMESTAMP	NULLABLE	
--    dropoff_datetime	TIMESTAMP	NULLABLE	
--    PULocationID	INTEGER	NULLABLE	
--    DOLocationID	INTEGER	NULLABLE	
--    SR_Flag	INTEGER	NULLABLE	
from {{ source('my_staging_gcp', 'fhv_tripdata_partitioned') }}
{% if var('is_test_run', default=true) %}
limit 100
{% endif %}
