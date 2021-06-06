structure Analyze =
struct
    val conn = SQL.connect DBSchema.covidDBServer;
    val r = SQL.fetchAll (AnalyzeDB.Q conn);
    val _ = Dynamic.pp r;
    (* Q9.3でDB接続テストのため  *)
    val s = SQL.fetchAll (AnalyzeDB.sampleQ conn);
    val _ = Dynamic.pp s;
    val _ = SQL.closeConn conn;
end
