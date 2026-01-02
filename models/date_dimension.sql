{{ config(materialized='table') }}
WITH CTE AS (
SELECT 
--STARTED_AT, -- this was string initially so we change ts
TO_TIMESTAMP(STARTED_AT) AS STARTED_AT,
DATE(TO_TIMESTAMP(STARTED_AT)) AS DATE_STARTED_AS,
-- HOUR(TO_TIMESTAMP(STARTED_AT)) AS HOUR_STARTED_AS,
--  CASE WHEN DAYNAME(TO_TIMESTAMP(STARTED_AT)) IN ('Sat', 'Sun') 
--  then 'WEEKEND' ELSE 'BUSINESSDAY' 
--  END AS DAY_TYPE,

--  CASE WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) IN (12,1,2) 
--   THEN 'WINTER'
--   WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) IN (6,7,8)
--   THEN 'SUMMER'
--   ELSE 'AUTUMN'
--   END AS STATION_OF_YEAR

{{get_season('STARTED_AT')}} as STATION_OF_YEAR, --macro funct defined for upper case statement

{{day_type('STARTED_AT')}} AS DAY_TYPE

FROM {{ source('demo', 'bike') }}
where STARTED_AT <> 'started_at'
)
select * 
from CTE