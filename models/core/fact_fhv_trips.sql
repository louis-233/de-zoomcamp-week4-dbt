{{ config(materialized='table') }}

with fhv_data as (
    select *
    from {{ ref('stg_fhv_tripdata') }}
), 

--yellow_data as (
--    select *, 
--        'Yellow' as service_type
--    from {{ ref('stg_yellow_tripdata') }}
--), 
--
--trips_unioned as (
--    select * from green_data
--    union all
--    select * from yellow_data
--), 

dim_zones as (
    select * from {{ ref('dim_zones') }}
    -- where borough != 'Unknown'
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



    -- trips_unioned.tripid, 
    -- trips_unioned.vendorid, 
    -- trips_unioned.service_type,
    -- trips_unioned.ratecodeid, 
    -- trips_unioned.pickup_locationid, 
    -- pickup_zone.borough as pickup_borough, 
    -- pickup_zone.zone as pickup_zone, 
    -- trips_unioned.dropoff_locationid,
    -- dropoff_zone.borough as dropoff_borough, 
    -- dropoff_zone.zone as dropoff_zone,  
    -- trips_unioned.pickup_datetime, 
    -- trips_unioned.dropoff_datetime, 
    -- trips_unioned.store_and_fwd_flag, 
    -- trips_unioned.passenger_count, 
    -- trips_unioned.trip_distance, 
    -- trips_unioned.trip_type, 
    -- trips_unioned.fare_amount, 
    -- trips_unioned.extra, 
    -- trips_unioned.mta_tax, 
    -- trips_unioned.tip_amount, 
    -- trips_unioned.tolls_amount, 
    -- trips_unioned.ehail_fee, 
    -- trips_unioned.improvement_surcharge, 
    -- trips_unioned.total_amount, 
    -- trips_unioned.payment_type, 
    -- trips_unioned.payment_type_description, 
    -- trips_unioned.congestion_surcharge
