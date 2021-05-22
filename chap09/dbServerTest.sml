type myDBty = {persons: {age: int, name: string} list};

fun mkServer db = _sqlserver (db: SQL.backend) : myDBty; (* define database  *)

(* TODO: 環境変数を設定して、そこから読み取るようにする。*)
val userAndPassStr = "user=" ^ myDBEnv.user ^ " password=" ^ myDBEnv.password;
val pgsqlDB = SQL.postgresql ("dbname=myDB " ^ userAndPassStr);

val myDBserver = mkServer pgsqlDB;
(*    _sqlserver "dbname=myDB"
    : {persons: {name: string, age: int} list};*)
val myDBconn = SQL.connect myDBserver; (* connect and receive connetion handle *)


val Q = _sql db => select #p.name as name, #p.age as age
                                                  from #db.persons as p
                                                  where #p.age < 43;
val myDBcur = Q myDBconn; (* get t SQL.cursor  *)


(*
SQL.fetch myDBcur; (* fetch t option *)
SQL.fetchAll myDBcur; (* fetch t list. This closes SQL.cursor. *)
*)

SQL.closeCursor myDBcur; (* close cursor *)
(*
SQL.closeConn myDBconn; (* close connection of connection handle *)
*)

fun selectYoung n = _sql db => select #p.name, #p.age
                                                  from #db.persons as p
                                                  where #p.age > (n + 10);
(*
fun selectYoung n = _sql db => select #p.name as name, #p.age as age
                                                   from #db.persons as p
                                                   where #p.age > n + 10;
*)
val myResult = selectYoung 10 myDBconn;
