val intList = [1,2,3];
val stringList = "S" :: "M" :: "L" :: "#" :: nil;
val h :: tl = intList;
(* (interactive):6.4-6.20(158) Warning: binding not exhaustive
      :: {1 = h, 2 = tl} => ... *)