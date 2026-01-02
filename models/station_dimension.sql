{{ config(materialized='table') }}
with bikes as (

    select DISTINCT
    START_STATIO_ID,
    START_STATION_NAME,
    START_LAT,
    START_LNG
    from {{ source('demo', 'bike') }}
     where RIDE_ID <> 'ride_id'

)
select * from bikes