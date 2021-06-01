structure DataSource =
struct

val PrefectureCodeUrl =
    "https://dashboard.e-stat.go.jp/api/1.0/Json/getRegionInfo?Lang=JP&ParentRegionCode=00000";
val PopulationByPrefectureUrl =
    "https://dashboard.e-stat.go.jp/\
  \api/1.0/Json/getData\
  \?Lang=JP\
  \&IndicatorCode=0201020000000010000\
  \&RegionalRank=3\
  \&Time=2019CY00";
val CumulativePositiveUrl =
    "https://data.corona.go.jp/\
  \converted-json/covid19japan-all.json";

val prefectureCodeSample =
    {GET_META_REGION_INF =
     {METADATA_INF=
      {CLASS_INF=
       {CLASS_OBJ=
        [{"@name"="全国",
          CLASS= [{"@regionCode"="04000", "@name"="宮城県"}]}]}}}};
val populationByPrefectureSample =
    {GET_STATS =
     {RESULT = {status="0", errorMsg="", date=""},
      STATISTICAL_DATA =
      {RESULT_INF = {TOTAL_NUMBER = "0"},
       DATA_INF =
       {DATA_OBJ = [{VALUE = {"@regionCode"="","$"=""}}]}}}};
val cumulativePositiveSample =
    [{lastUpdate = "", area= [{name_jp= "", npatients= 0}]}];

val prefectureCodeSrc =
    {url = PrefectureCodeUrl, sample = prefectureCodeSample};
val populationByPrefectureSrc =
    {url = PopulationByPrefectureUrl, sample = populationByPrefectureSample};
val cumulativePositiveSrc =
    {url = CumulativePositiveUrl, sample = cumulativePositiveSample};

type PrefectureCodeTy =
     {GET_META_REGION_INF:
      {METADATA_INF:
       {CLASS_INF:
        {CLASS_OBJ:
         {"@name":string,
          CLASS:{"@regionCode":string,"@name":string} list} list }}}}
type PopulationByPrefectureTy =
     {GET_STATS:
      {RESULT:{status:string, errorMsg:string, date:string},
       STATISTICAL_DATA:
       {RESULT_INF:{TOTAL_NUMBER:string},
        DATA_INF:{DATA_OBJ:{VALUE:{"@regionCode":string,"$":string}} list}}}}
type CumulativePositiveTy =
     {lastUpdate:string, area: {name_jp:string, npatients: int}list}list
fun import () = {
    PrefectureCode = JSONImport.import prefectureCodeSrc,
    PopulationByPrefecture = JSONImport.import populationByPrefectureSrc,
    CumulativePositive = JSONImport.import cumulativePositiveSrc
}

end
