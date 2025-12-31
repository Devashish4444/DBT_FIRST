WITH daily_weather as (
select 
DATE(time) as date_weather,
WEATHER,
TEMP,
PRESSURE,
HUMIDITY,
CLOUDS


from {{ source('demo', 'weather') }}

),
daily_weather_agg as (
select
date_weather,
weather,
round(avg(TEMP),2) as avg_temp,
round(avg(pressure),2) as avg_pressure,
round(avg(humidity),2) as avg_humidity,
round(avg(clouds),2) as avg_clouds

from daily_weather 
group by date_weather,weather
QUALIFY ROW_NUMBER() OVER (PARTITION BY date_weather ORDER BY COUNT(WEATHER) DESC ) = 1
)

select * from daily_weather_agg
