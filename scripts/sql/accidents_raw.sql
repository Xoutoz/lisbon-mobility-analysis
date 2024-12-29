create database if not exists raw;

create external table if not exists raw.accidents (
    IdAcidente string,
    Datahora string,
    Dia string,
    Mes string,
    Hora string,
    EntidadesFiscalizadoras string,
    Velocidadelocal string,
    Velocidadegeral string,
    DiadaSemana string,
    LatitudeGPS string,
    LongitudeGPS string,
    NumMortosa30dias string,
    NumFeridosgravesa30dias string,
    NumFeridosligeirosa30dias string,
    CaracteristicasTecnicas1 string,
    CondAderencia string,
    Distrito string,
    Concelho string,
    Freguesia string,
    PovProxima string,
    NomeArruamento string,
    TiposVias string,
    CodVia string,
    EstadoConservacao string,
    Km string,
    FactoresAtmosfericos string,
    RegCirculacao1 string,
    InterseccaoVias string,
    Localizacao string,
    Luminosidade string,
    MarcaVia string,
    Natureza string,
    ObrasArte string,
    Obstaculos string,
    Sentidos string,
    Sinais string,
    SinaisLuminosos string,
    TipoPiso string,
    Tracado1 string,
    Tracado2 string,
    Tracado3 string,
    Tracado4 string,
    ViaTransito string
)
partitioned by (`year` int)
stored as parquet
location '/user/raw/accidents/parquet';

msck repair table raw.accidents;