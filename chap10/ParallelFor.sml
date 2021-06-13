fun parallel_for {begin, last, size} (f: int -> unit) =
    (* sizeがlast-begin+1以上だったら分割しない  *)
    if (size >= last - begin + 1)  then
        f begin
    else
        let
            val w = (last - begin + 1) div 2
            (* 2分割で前半を扱う *)
            val t = Myth.Thread.create
                        (fn _ => (parallel_for {begin = begin, last = begin + w - 1, size = size} f; 0))
        in
            (* 2分割で後半を扱う *)
            parallel_for {begin = begin + w, last = last, size = size} f;
            Myth.Thread.join t;
            ()
        end;

(*val a = Array.array (64, 0);
val _ = parallel_for {begin = 0, last = 63, size = 8} (fn i => Array.update(a, i, i));
val _ = Dynamic.pp(a);**)
