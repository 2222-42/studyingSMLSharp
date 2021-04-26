val P = (1, "1");
val P2 = (#2 P, #1 P, P);
val P3 = (String.size, "SML#");
val s = #1 P3 (#2 P3);
val (x, y) = P;