val i32 = 1234;
val minInt32 = ~0x7FFFFFFF;(* 0xyyy..yyで16進数表記の記述 *)
val iInf = 1234: intInf;
val iI = iInf * IntInf.fromInt i32;
val largeInt = iI * iI * iI * iI * iI;
val largeInt = largeInt * ~1;
(* 
structure IntInf =
  struct
    type int = intInf
    val toLarge = fn : int -> int
    val fromLarge = fn : int -> int
    val toInt = fn : int -> int
    val fromInt = fn : int -> int
    val precision = NONE : int option
    val minInt = NONE : int option
    val maxInt = NONE : int option
    val + = fn : int * int -> int
    val - = fn : int * int -> int
    val * = fn : int * int -> int
    val div = fn : int * int -> int
    val mod = fn : int * int -> int
    val quot = fn : int * int -> int
    val rem = fn : int * int -> int
    val compare = fn : int * int -> order
    val < = fn : int * int -> bool
    val <= = fn : int * int -> bool
    val > = fn : int * int -> bool
    val >= = fn : int * int -> bool
    val ~ = fn : int -> int
    val abs = fn : int -> int
    val min = fn : int * int -> int
    val max = fn : int * int -> int
    val sign = fn : int -> int
    val sameSign = fn : int * int -> bool
    val fmt = fn : StringCvt.radix -> int -> string
    val toString = fn : int -> string
    val scan =
      fn
      : ['a.
         StringCvt.radix
         -> ('a -> (char * 'a) option) -> 'a -> (int * 'a) option]
    val fromString = fn : string -> int option
    val divMod = fn : int * int -> int * int
    val quotRem = fn : int * int -> int * int
    val pow = fn : int * int -> int
    val log2 = fn : int -> int
    val orb = fn : int * int -> int
    val xorb = fn : int * int -> int
    val andb = fn : int * int -> int
    val notb = fn : int -> int
    val << = fn : int * word -> int
    val ~>> = fn : int * word -> int
  end

 *)
