(* Q4.2 *)

val T = Tree.mkTree 3;

val result = {
        heightT = Tree.height T,
        sizeT = Tree.size T,
        sumT = Tree.sum T,
        traverseT = Tree.traverse T
    };

Dynamic.pp result