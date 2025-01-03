create database if not exists raw;

create external table if not exists raw.weather (
    name string,
    `datetime` string,
    tempmax string,
    tempmin string,
    temp string,
    feelslikemax string,
    feelslikemin string,
    feelslike string,
    dew string,
    humidity string,
    precip string,
    precipprob string,
    precipcover string,
    preciptype string,
    snow string,
    snowdepth string,
    windgust string,
    windspeed string,
    winddir string,
    sealevelpressure string,
    cloudcover string,
    visibility string,
    solarradiation string,
    solarenergy string,
    uvindex string,
    severerisk string,
    sunrise string,
    sunset string,
    moonphase string,
    conditions string,
    description string,
    icon string,
    stations string
)
partitioned by (`year` int)
row format serde 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
stored as textfile
location '/user/raw/weather/csv'
tblproperties ('skip.header.line.count'='1');

msck repair table raw.weather;