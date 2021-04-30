fun makePrintString structureName = "structure " ^ structureName ^ " = " ^ structureName ^ ";";

exception SystemFailure;

(* TODO:  *)

fun execPrint structureName = 
        let
            fun isSuccess 0 = ()
                | isSuccess _ = raise SystemFailure;
        in
            isSuccess (OS.Process.system
                ("cat >"
                    ^ "Results/"
                    ^ structureName
                    ^ ".txt"
                    ^ " <<EOF\n"
                    ^  makePrintString structureName
                    ^ "EOF\n"
                ))
        end

(* structure OSProcess =
  struct
    type status = int32
    val success = 0 : status
    val failure = 1 : status
    val isSuccess = fn : status -> bool
    val system = fn : string -> status
    val atExit = fn : (unit -> unit) -> unit
    val exit = fn : ['a. status -> 'a]
    val terminate = fn : ['a. status -> 'a]
    val getEnv = fn : string -> string option
    val sleep = fn : Time.time -> unit
  end *)


val libs = ["String", "Bool"] : string list;

List.app execPrint libs

(* OS.Process.system
("cat >"
    ^ "Results/"
    ^ structureName
    ^ ".txt"
    ^ " <<EOF\n"
    ^ "${structure String = String;}"
    ^ "EOF\n"
);

OS.Process.system
("smlsharp\n" ^ "structure String = String;"); *)