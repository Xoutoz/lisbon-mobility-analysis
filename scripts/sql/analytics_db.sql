create database if not exists analysis;

drop view if exists analysis.weather;
drop view if exists analysis.accidents;

create view analysis.weather as
select * from curated.weather
where `year` > 2015;

create view analysis.accidents as
select * from curated.accidents
where `year` > 2015;