structure DBSetup =
struct

 fun setupDB () =
   let
     val conn = SQL.connect DBSchema.covidDBServer
     val {PrefectureCode, PopulationByPrefecture, CumulativePositive} = DataSource.import()
     val DataSource =
         [{PrefectureData = DataSource.PopulationByPrefectureUrl,
           PrefectureDataGetAt =
           #date (#RESULT  (#GET_STATS PopulationByPrefecture)),
           covid19 = DataSource.CumulativePositiveUrl,
           covid19UpdatedAt = #lastUpdate (hd CumulativePositive)
         }]
     val PrefecturesList: DBSchema.PrefecturesListTy list =
         map (fn {"@name" =n, "@regionCode" = c} =>
                 {prefectureName = n, code =c})
         (#CLASS
          (hd
           (#CLASS_OBJ
              (#CLASS_INF
                 (#METADATA_INF
                    (#GET_META_REGION_INF PrefectureCode)
         )))))

     val PopulationByPrefecture: DBSchema.PopulationByPrefectureTy list =
         map (fn {VALUE={"$"=p, "@regionCode" = r}} =>
                 {population = valOf (Real.fromString (p ^ ".0")), code = r})
             ((#DATA_OBJ o #DATA_INF o #STATISTICAL_DATA o #GET_STATS)
                  PopulationByPrefecture)

     val CumulativePositiveByPrefecture: DBSchema.CumulativePositiveByPrefectureTy list =
         map (fn {name_jp=n, npatients=p} =>
                 {prefectureName=n, cumulativePositive = Real.fromInt p})
             (#area (hd CumulativePositive))

     val _ = (_sql db => insert into #db.DataSource
                        (PrefectureData, PrefectureDataGetAt, covid19, covid19UpdatedAt)
                        values DataSource)
             conn
     val _ = (_sql db => insert into #db.PrefecturesList
                        (code, prefectureName)
                        values PrefecturesList)
             conn
     val _ = (_sql db => insert into #db.PopulationByPrefecture
                        (code, population)
                        values PopulationByPrefecture)
             conn
     val _ = (_sql db => insert into #db.CumulativePositiveByPrefecture
                        (prefectureName, cumulativePositive)
                        values CumulativePositiveByPrefecture)
             conn

   in
     SQL.closeConn conn
   end
end
