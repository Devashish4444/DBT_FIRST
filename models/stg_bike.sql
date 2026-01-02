WITH BIKE AS (

SELECT 
* 
FROM {{ source('demo', 'bike') }}

where RIDE_ID <> 'ride_id'
)
select * from BIKE