(* 2.2.1 *)
fun g 0 = 0
    | g x = x + 1;

(* functionTest.sml:4.0(33)-5.12(58) Warning: match nonexhaustive
      0 => ...
      1 => ...
 *)
fun h 0 = 0 
    | h 1 = 1;
(* 
# h 2;
uncaught exception Match at functionTest.sml:8.0(133)
*)

fun g' n = case n of 0 => 0 | n => n + 1;

fun prod(0, _) = 0
    | prod(_, 0) = 0
    | prod(x, y) = x * y;


(* 2.2.2 *)
fun S 0 = 0
    | S n = n + S(n - 1);
(* 
#  S 100000000;
[1]    25239 segmentation fault (core dumped)  smlsharp -r functionTest.smi
*)

fun L (0, a) = a
    | L (i, a) = L(i - 1, a + i);

fun S' n = 
        let
            fun L' (0, a) = a
                | L' (i, a) = L'(i - 1, a + i);
        in
            L'(n, 0)
        end

(* 
# S' 100000000;
val it = 5000000050000000 : int64
*)


(* 2.2.3 *)
val f = fn x => x + 1;
val id = fn x => x;
val S'' = fn n => L(n, 0)