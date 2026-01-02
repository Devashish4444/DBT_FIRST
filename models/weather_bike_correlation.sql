{{ config(materialized='table') }}
WITH CTE AS (

SELECT 
t.*,
w.* 
FROM {{ ref('trip_fact') }} t
left join {{ ref('daily_weather') }} w 
on t.TRIP_DATE = w.DATE_WEATHER
LIMIT 10
)
SELECT * FROM CTE