fun init64 () = 
    MT.init_genrand64 
    (Word64.fromLargeInt (Time.toSeconds (Time.now())));

val len = 10;
val init64 = init64();
val randInt63 = 
  List.tabulate (len, fn x => MT.genrand64_int63());
val randWord64 = 
  List.tabulate (len, fn x => MT.genrand64_int64());
val randReal1 = 
  List.tabulate (len, fn x => MT.genrand64_real1());
val randReal2 = 
  List.tabulate (len, fn x => MT.genrand64_real2());
val randReal3 = 
  List.tabulate (len, fn x => MT.genrand64_real3());
val _ = Dynamic.pp 
  {
    randInt63 = randInt63,
    randWord64 = randWord64,
    randReal1 = randReal1,
    randReal2 = randReal2,
    randReal3 = randReal3
  };

fun compare (p1, p2) =
  let
    val n1 = Pointer.load p1
    val n2 = Pointer.load p2
  in
    if n1 > n2 then 1 else if n1 < n2 then ~1 else 0
  end;
(* val compare = fn : ['a::{int, word, int8, word8, ...}. 'a ptr * 'a ptr -> int]
 *)

type size_t = word64;

fun 'a#unboxed qsort (array, compare) =
  let
    val qsort_c =
      _import "qsort" : ('a array, size_t, 'a size, ('a ptr, 'a ptr) -> int) -> ()
  in
    qsort_c (array,
            Word64.fromInt (Array.length array),
            _sizeof('a),
            compare)
  end;

val randInt63Array = Array.fromList randInt63;
val randReal1Array = Array.fromList randReal1;
val randReal2Array = Array.fromList randReal2;
val randReal3Array = Array.fromList randReal3;

val _ = qsort (randInt63Array, compare);
val _ = qsort (randReal1Array, compare);
val _ = qsort (randReal2Array, compare);
val _ = qsort (randReal3Array, compare);

Dynamic.pp
  {
    randInt63 = randInt63Array,
    randReal1 = randReal1Array,
    randReal2 = randReal2Array,
    randReal3 = randReal3Array
  };
