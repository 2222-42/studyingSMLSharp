type myDBty = {persons: {age: int, name: string} list};

fun mkServer db = _sqlserver (db: SQL.backend) : myDBty;

(* TODO: 環境変数を設定して、そこから読み取るようにする。*)
val userAndPassStr = "user=" ^ myDBEnv.user ^ " password=" ^ myDBEnv.password;
val pgsqlDB = SQL.postgresql ("dbname=myDB " ^ userAndPassStr);

val myDBserver = mkServer pgsqlDB;
(*    _sqlserver "dbname=myDB"
    : {persons: {name: string, age: int} list};*)
SQL.connect myDBserver;
