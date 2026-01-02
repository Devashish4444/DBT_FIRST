{{ config(materialized='table') }}

with trips as (

    select DISTINCT
    RIDE_ID,
    RIDEABLE_TYPE,
    DATE(TO_TIMESTAMP(STARTED_AT)) AS TRIP_DATE,
    START_STATIO_ID,
    END_STATION_ID,
    MEMBER_CSUAL,
    TIMESTAMPDIFF(SECOND , TO_TIMESTAMP(ENDED_AT) , TO_TIMESTAMP(STARTED_AT)) AS TRIP_DURATION

    from {{ source('demo', 'bike') }}
     where RIDE_ID <> 'ride_id'

)
select * from trips