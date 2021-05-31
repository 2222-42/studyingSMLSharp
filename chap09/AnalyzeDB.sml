structure AnalyzeDB =
struct

    type dbty = (DBSchema.covidDB, _) SQL.db;
    type resultTy = {cumulativePositive: real,
                     prefectureName: string,
                     "population(10k)": real,
                     "cumulativePositiveRate(per 10k)": real};
    fun fromDB (db : dbty) =
        _sql from #db.PrefecturesList,
                  #db.PopulationByPrefecture,
                  #db.CumulativePositiveByPrefecture;

    fun whereDB (db: dbty) =
        _sql where
             (#PrefecturesList.prefectureName = #CumulativePositiveByPrefecture.prefectureName
              and #PrefecturesList.code = #PopulationByPrefecture.code)

    fun displayRatio (db: dbty) =
        _sql select
             #CumulativePositiveByPrefecture.cumulativePositive as cumulativePositive,
             #PrefecturesList.prefectureName as prefectureName,
             #PopulationByPrefecture.population / 10000.0 as "population(10k)",
             (#CumulativePositiveByPrefecture.cumulativePositive / #PopulationByPrefecture.population) * 10000.0 as "cumulativePositiveRate(per 10k)";

    val Q = _sql db : dbty =>
            select ...(displayRatio db)
                   from ...(fromDB db)
                   where ...(whereDB db)
                   order by #."cumulativePositiveRate(per 10k)" desc
end
