structure PrintInterface = 
struct
  fun makePrintString structureName = "structure " ^ structureName ^ " = " ^ structureName ^ ";";

  fun execPrint structureName = 
      let
        val S = "smlsharp >"
          ^ "Results/" ^ structureName ^ ".txt"
          ^ " <<EOF\n"
          ^ makePrintString structureName
          ^ "\nEOF\n";
        val E = "echo \"$(tail -n +2 Results/" ^ structureName ^ ".txt)\" > Results/" ^ structureName ^ ".txt";
      in
        ((OS.Process.system S);(OS.Process.system E);())
      end;
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
