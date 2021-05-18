type myDBty = {persons: {age: int, name: string} list};

fun mkServer db = _sqlserver (db: SQL.backend) : myDBty;

(* TODO: 環境変数を設定して、そこから読み取るようにする。*)
val pgsqlDB = SQL.postgresql "dbname=myDB user= password=";

val myDBserver = mkServer pgsqlDB;
(*    _sqlserver "dbname=myDB"
    : {persons: {name: string, age: int} list};*)
SQL.connect myDBserver;
