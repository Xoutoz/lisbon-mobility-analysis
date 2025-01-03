create database if not exists curated;

create table if not exists curated.weather (
    `date` date,
    temperature float,
    humidity float,
    precipitation float,
    snow boolean,
    wind_speed float
)
partitioned by (`year` int)
stored as parquet
location '/user/curated/weather/parquet';

insert overwrite table curated.weather partition (`year`)
select
    to_date(`datetime`) as `date`,
    cast(temp as float) as temperature,
    cast(humidity as float) as humidity,
    cast(precip as float) as precipitation,
    if(snow <> '' and snow > 0, true, false) as snow,
    cast(windspeed as float) as wind_speed,
    year(to_date(`datetime`)) as `year`
from raw.weather;