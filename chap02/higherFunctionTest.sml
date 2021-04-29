(* 2.3.1 *)

fun Power (m, n) = 
        let
            fun L(0, a) = a
                | L(m, a) = L(m - 1, a * n)
        in
            L(m, 1)
        end;

fun power m n = 
        let
            fun L(0, a) = a
                | L(m, a) = L(m - 1, a * n)
        in
            L(m, 1)
        end;

val square = power 2;
val cube = power 3;
(* val b = cube 2;
val c = square (cube 2); *)


(* 2.3.2 *)

fun Sigma f n = 
        let
            fun L (0, a) = a
                | L(n, a) = L (n-1, a + f n)
        in
            L (n, 0)
        end;
val S = Sigma(fn x => x);
val SS = Sigma square;
 