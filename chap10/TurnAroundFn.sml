val r = ref (0, 0, 0);
fun t x y z =
    (r := (x, y, z);
     if x <= y then y
     else t (t (x - 1) y z) (t (y - 1) z x) (t (z - 1) x y));
val th = Pthread.Thread.create (fn () => t 15 5 0);
Dynamic.pp(r);
Dynamic.pp(r);
Dynamic.pp(r);
Dynamic.pp(r);
Pthread.Thread.join th;
