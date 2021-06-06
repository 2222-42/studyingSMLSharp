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
                   order by #."cumulativePositiveRate(per 10k)" desc;

    fun selectPref (db:dbty) n =
        let
            fun display db =
                _sql select
                     #PrefecturesList.code as code,
                     #PrefecturesList.prefectureName as prefectureName;
            fun whereQ (db: dbty) n =
                _sql where
                     (#PopulationByPrefecture.population > n
                      and #PrefecturesList.code = #PopulationByPrefecture.code)
            fun fromQ (db: dbty) =
                _sql from #db.PrefecturesList,
                          #db.PopulationByPrefecture
        in
            _sql select ...(display db)
                   from ...(fromQ db)
                   where ...(whereQ db n)

        end
    (* Q9.3でDB接続テストのため  *)
    val sampleQ = _sql db : dbty => select ...(selectPref db 7500000.0)
end
