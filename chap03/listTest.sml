fun myLength l = 
        let
            fun L (nil, a) = a
                | L(hd::tl, a) = L(tl, a + 1)
        in
            L(l, 0)
        end;

exception Empty;

fun myHd nil = raise Empty
    | myHd (h::t) = h;

fun myHd' nil = NONE
    | myHd' (h::t) = SOME h;

val result = valOf (myHd' [1,2,3]);
(* valOf nil; *)

fun hdOrZero l = 
        case myHd' l of
            SOME x => x
        | NONE => 0;

fun myRev l = (List.foldl (fn (x, y) => x :: y) nil l);
fun myRev2 l = (List.foldl (op ::) nil l);
