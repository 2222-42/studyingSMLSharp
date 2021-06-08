structure Analyze =
struct
    val conn = SQL.connect DBSchema.covidDBServer;
(*    val r = SQL.fetchAll (AnalyzeDB.Q conn);
    val _ = Dynamic.pp r;*)
    val s = SQL.fetchAll (AnalyzeDB.makeAnalyze conn);
    val _ = Dynamic.pp s;
    val _ = SQL.closeConn conn;
end
