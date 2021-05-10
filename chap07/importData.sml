(*
structure Pointer =
  struct
    val advance = <builtin> : ['a. 'a ptr * int -> 'a ptr]
    val load = <builtin> : ['a. 'a ptr -> 'a]
    val store = <builtin> : ['a. 'a ptr * 'a -> unit]
    val isNull = fn : ['a. 'a ptr -> bool]
    val NULL = <builtin> : ['a. unit -> 'a ptr]
    val importBytes = fn : word8 ptr * int -> word8 vector
    val importString = fn : char ptr -> string
    val importString' = fn : char ptr * int -> string
  end 
*)

val getenv = _import "getenv": string -> char ptr;

fun findEnv s = 
let
  val cptr = getenv s
in
  if Pointer.isNull cptr then NONE
  else SOME (Pointer.importString cptr)
end;

findEnv "PATH";