structure DBSchema =
struct
type PrefecturesListTy = {code: string, prefectureName: string}
type PopulationByPrefectureTy = {code: string, population: real}
type CumulativePositiveByPrefectureTy = {prefectureName: string, cumulativePositive: real}
type DataSourceTy = {
    PrefectureData: string,
    PrefectureDataGetAt: string,
    covid19: string,
    covid19UpdatedAt:string
}

type covidDB = {
    DataSource: DataSourceTy list,
    PrefecturesList: PrefecturesListTy list,
    PopulationByPrefecture: PopulationByPrefectureTy list,
    CumulativePositiveByPrefecture: CumulativePositiveByPrefectureTy list
};

val userAndPassStr = "user=" ^ myDBEnv.user ^ " password=" ^ myDBEnv.password;
val covidDBServer = _sqlserver (SQL.postgresql ("dbname=covidDB " ^ userAndPassStr)): covidDB

fun initDB() =
    let
        val _ = (OS.Process.system ("sudo -u " ^ myDBEnv.user ^ " dropdb covidDB");
                 OS.Process.system ("sudo -u " ^ myDBEnv.user ^ " createdb covidDB"))
        val conn = SQL.connectAndCreate covidDBServer
    in
        SQL.closeConn conn
    end

end
