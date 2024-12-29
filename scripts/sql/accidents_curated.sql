-- Set Hive to allow dynamic partitioning and disable strict checks for Cartesian products
set hive.strict.checks.cartesian.product=false;
set hive.mapred.mode=nonstrict;
set hive.exec.dynamic.partition.mode=nonstrict;

create database if not exists curated;

create table if not exists curated.accidents (
    `date` date,
    grip_conditions string,
    weather_conditions string,
    total_wounded int,
    total_deceased int,
    latitude float,
    longitude float
)
partitioned by (`year` int)
stored as parquet
location '/user/curated/accidents/parquet';

with cte as (
    select
        avg(latitudegps) as mean_latitude,
        avg(longitudegps) as mean_longitude
    from
        raw.accidents
    where
        concelho = 'Lisboa'
        and (latitudegps <> 0 or longitudegps <> 0)
)

insert overwrite table curated.accidents partition (`year`)
select
    to_date(from_unixtime(unix_timestamp(replace(substring(datahora, 1, 10), ':', '-'), 'yyyy-MM-dd'))) as `date`,
    case condaderencia
        when 'Com ·gua acumulada na faixa de rodagem' then 'Com água acumulada na faixa de rodagem'
        when 'Com Ûleo' then 'Com Óleo'
        when 'H˙mido' then 'Húmido'
        when 'N√O DEFINIDO' then 'Não Definido'
        else condaderencia
        end as grip_conditions,
    if(factoresatmosfericos = 'N√O DEFINIDO', 'Não Definido', factoresatmosfericos) as weather_conditions,
    numferidosgravesa30dias + numferidosligeirosa30dias as total_wounded,
    cast(nummortosa30dias as int) as total_deceased,
    cast(if(latitudegps <> 0, latitudegps, mean_latitude) as float) as latitude,
    cast(if(longitudegps <> 0, longitudegps, mean_longitude) as float) as longitude,
    cast(substring(datahora, 1, 4) as int) as `year`
from
    raw.accidents
cross join
    cte
where
    concelho = 'Lisboa';