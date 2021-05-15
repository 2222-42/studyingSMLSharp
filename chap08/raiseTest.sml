fun prodList L =
    let
        exception Zero
    in
        foldl(fn (x, A) => if x = 0 then raise Zero
                           else x * A) 1 L
        handle Zero => 0
    end;

fun find (P, L) =
    let
        exception Found of 'a
    in
        (app (fn x => if P x then raise Found x
                      else ()
             ) L; NONE)
        handle Found x => SOME x
    end;

(*
find ((fn x => x = "test2"), ["test1", "test2", "test3"]);
find ((fn x => x = "test2"), ["test1", "test", "test3"]);
*)
