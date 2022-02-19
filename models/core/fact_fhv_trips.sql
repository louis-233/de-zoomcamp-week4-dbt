{{ config(materialized='table') }}

with fhv_data as (
    select *
    from {{ ref('stg_fhv_tripdata') }}
), 

dim_zones as (
    select * from {{ ref('dim_zones') }}
)

select 
    fhv_data.dispatching_base_num

    -- Pick up
    fhv_data.pickup_datetime
    pickup_zone.borough as pickup_borough, 
    pickup_zone.zone as pickup_zone, 
    fhv_data.PULocationID as pickup_locationid

    -- Drop off
    fhv_data.dropoff_datetime
    dropoff_zone.borough as dropoff_borough, 
    dropoff_zone.zone as dropoff_zone,  
    fhv_data.DOLocationID as dropoff_locationid

    fhv_data.SR_Flag

from fhv_data
    inner join dim_zones as pickup_zone
        on fhv_data.PULocationID = pickup_zone.locationid
    inner join dim_zones as dropoff_zone
        on fhv_data.DOLocationID = dropoff_zone.locationid
