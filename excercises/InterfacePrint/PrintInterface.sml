fun makePrintString structureName = "structure " ^ structureName ^ " = " ^ structureName ^ ";";

exception SystemFailure;

fun execPrint structureName = 
        let
            fun isSuccess 0 = ()
                | isSuccess _ = raise SystemFailure;
            val S = "smlsharp >"
                ^ "Results/"
                ^ structureName
                ^ ".txt"
                ^ " <<EOF\n"
                ^ makePrintString structureName
                ^ "EOF\n"
        in
            isSuccess (OS.Process.system S)
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


val libs = ["String", "Int", "Int8", "Int16", "Int32", "Int64", "IntInf", "Word", "Word8", "Word16", "Word32", "Word64", "Real", "Real32", "Char", "Bool", "List"];

List.app execPrint libs;
