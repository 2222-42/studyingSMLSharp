(* 
structure S =
  struct
    type string = string
    type char = char
    val maxSize = 268435454 : int
    val size = <builtin> : string -> int
    val explode = fn : string -> char list
    val concatWith = fn : string -> string list -> string
    val isPrefix = fn : string -> string -> bool
    val isSuffix = fn : string -> string -> bool
    val isSubstring = fn : string -> string -> bool
    val translate = fn : (char -> string) -> string -> string
    val sub = <builtin> : string * int -> char
    val extract = fn : string * int * int option -> string
    val substring = fn : string * int * int -> string
    val ^ = fn : string * string -> string
    val concat = fn : string list -> string
    val str = fn : char -> string
    val implode = fn : char list -> string
    val map = fn : (char -> char) -> string -> string
    val tokens = fn : (char -> bool) -> string -> string list
    val fields = fn : (char -> bool) -> string -> string list
    val compare = fn : string * string -> order
    val collate = fn : (char * char -> order) -> string * string -> order
    val < = fn : string * string -> bool
    val <= = fn : string * string -> bool
    val > = fn : string * string -> bool
    val >= = fn : string * string -> bool
    val toString = fn : string -> string
    val toRawString = fn : string -> string
    val scan =
      fn : ['a.  ('a -> (char * 'a) option) -> 'a -> (string * 'a) option]
    val fromString = fn : string -> string option
    val toCString = fn : string -> string
    val fromCString = fn : string -> string option
  end
*)

val s = "SML#\n";
val ss = "プログラミング言語" ^ s;
val prefectureCodeUrl = 
"https://dashboard.e-stat.go.jp\
\api/a.0/JSON/getRegionInfo\
\?Lang=JP\
    \&ParentRegionCode=00000";
(* stringTest.smi:5.4(90)-5.7(93) Error:
  (name evaluation "210v") duplicate variable name: size
 *)
val size_of_ss = String.size ss;