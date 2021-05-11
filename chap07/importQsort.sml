(* 
void qsort(void *base, size_t num, size_t size, 
           int (*compare)(const void*, const void*))

- void *base : 配列の先頭ポインタ(ソート対象データ)
- size_t nmemb : 配列の要素数
- size_t size : 配列要素の大きさ(バイト数)
- int (*compare)(const void*, const void*) : 排列要素比較関数へのポインタ

これらの要素の型をSML#で定義し、さらに、対応する値を使用どおりパラメータとして渡す必要がある。
*)


(* 
# fun 'a#unboxed f (x: 'a) = x;
val f = fn : ['a#unboxed. 'a -> 'a]
# f 1;
val it = 1 : int
# f "SML#";
(interactive):3.0-3.7(42) Error:
  (type inference 016) operator and operand don't agree
  operator domain: 'JFZ#unboxed
          operand: string

*)

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
(* val qsort = fn : ['a#unboxed. 'a array * ('a ptr * 'a ptr -> int) -> unit] *)
