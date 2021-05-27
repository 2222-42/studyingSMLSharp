type personTy= {age: int, name: string};
type myDBty = {
    persons: personTy list,
    accounts: {balance: int, name: string} list
};
type resultTy = {name: string, age: int} list;
type fromTy = {p: personTy} list;
type whereTy = fromTy -> fromTy;

val F = fn db: (myDBty, _) SQL.db =>
           (_sql from #db.persons as p): (fromTy, _) SQL.from;
val W = fn db: (myDBty, _) SQL.db =>
           (_sql where #p.age < 43) : (whereTy, _) SQL.whr;
val S = fn db: (myDBty, _) SQL.db =>
           (_sql select #p.name as name, #p.age as age) : (fromTy, resultTy, _) SQL.select;

fun mkServer db = _sqlserver (db: SQL.backend) : myDBty; (* define database  *)

(* TODO: 環境変数を設定して、そこから読み取るようにする。*)
val userAndPassStr = "user=" ^ myDBEnv.user ^ " password=" ^ myDBEnv.password;
val pgsqlDB = SQL.postgresql ("dbname=myDB " ^ userAndPassStr);

val myDBserver = mkServer pgsqlDB;
(*    _sqlserver "dbname=myDB"
    : {persons: {name: string, age: int} list};*)
val myDBconn = SQL.connect myDBserver; (* connect and receive connetion handle *)

val Q = _sql db => select ...(S db)
                           from ...(F db)
                           where ...(W db);
val myDBcur = Q myDBconn;

val _ = Dynamic.pp (SQL.fetch myDBcur); (* fetch t option *)
val _ = Dynamic.pp (SQL.fetchAll myDBcur); (* fetch t list. This closes SQL.cursor. *)

fun selectYoung n = _sql db => select #p.name, #p.age
                                                  from #db.persons as p
                                                  where #p.age > (n + 10);
val youngResult = selectYoung 10 myDBconn;

val _ = Dynamic.pp (SQL.fetch youngResult);
SQL.closeCursor youngResult; (* close cursor *)

(* 9.8.1 insert *)
fun insertPersons L =
    _sql db => insert into #db.persons (name, age) values L;

fun myDBinsertPersons L =
    _sql db : (myDBty, _) SQL.db =>
    insert into #db.persons (name, age)
           values L;

(*
myDBinsertPersons [{name="father", age=75}, {name="son", age= 3}] myDBconn;

val myDBcur = Q myDBconn; (* get t SQL.cursor  *)
val _ = Dynamic.pp (SQL.fetchAll myDBcur); *)

(* 9.8.2 delete *)
fun retire n =
    _sql db => delete from #db.persons where #persons.age > n;

(*
retire 65 myDBconn;
val Q = _sql db => select #p.name as name, #p.age as age
                                                  from #db.persons as p
                                                  where #p.age > 43;
val myDBcur = Q myDBconn; (* get t SQL.cursor  *)
val _ = Dynamic.pp (SQL.fetchAll myDBcur);
*)


(* 9.8.3 update *)
val newAcademicYear =
    _sql db => update #db.persons set age = #persons.age + 1;
val myDBnewAcademicYear =
    _sql db : (myDBty, _) SQL.db => update #db.persons set age = #persons.age + 1;


(* 9.8.4 transaction *)
fun insertAccounts L =
    _sql db => insert into #db.accounts (name, balance) values L;

(* insertAccounts [{name="shanada", balance=10000}, {name="John Doe", balance=20000}] myDBconn;*)

fun atomicTransfer (amount: int) (payer: string) payee  =
    let
        val begin = _sql db => begin;
        val commit = _sql db => commit;
        fun debit db =
            _sql update #db.accounts
                 set balance = #accounts.balance - amount
                                                     where #accounts.name = payer;
        fun credit db =
            _sql update #db.accounts
                 set balance = #accounts.balance + amount
                                                     where #accounts.name = payee;
    in
        _sql db => (begin; ...(debit db); ...(credit db); commit)
    end;

(* atomicTransfer 100 "John Doe" "shanada" myDBconn;*)

val ShowAccounts = _sql db => select #p.name as name, #p.balance as balance
                                                                 from #db.accounts as p;
val accountsDBcur = ShowAccounts myDBconn; (* get t SQL.cursor  *)
val _ = Dynamic.pp (SQL.fetchAll accountsDBcur);
(*SQL.closeConn myDBconn; (* close connection of connection handle *)*)
