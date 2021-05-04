(* Q4.1 *)


structure Tree = 
struct
    datatype 'a tree = EmptyTree | Node of 'a * 'a tree * 'a tree;
    fun copyTree tree = 
            case tree of
                EmptyTree => EmptyTree
            | Node (a, L, R) => Node (a, copyTree L, copyTree R);

    fun height tree = 
            case tree of
                EmptyTree => 0
            | Node (a, L, R) => 
                let
                    val heightOfL = height L
                    val heightOfR = height R
                in
                    if heightOfL >= heightOfR then 1 +  height L
                    else 1 + heightOfR
                end;

    (* (name evaluation "210v") duplicate variable name: size *)
    fun size tree = 
            case tree of
                EmptyTree => 0
            | Node (a, L, R) => 1 + size L + size R;

    fun sum (tree : int tree) = 
            case tree of
                EmptyTree => 0
            | Node (a, L, R) => a + sum L + sum R;

    fun traverse tree = 
            case tree of
                EmptyTree => nil
            | Node (a, L, R) => a :: traverse L @ traverse R;

    (* Q4.2 *)

    fun mkTree (n:int) = 
            case n of 
                0 => EmptyTree
            | m => Node (m, mkTree (m - 1), mkTree (m - 1));
end
