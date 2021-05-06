type pos = int * int;
datatype color = BLACK | WHITE;
type board = (pos * color) list;
fun get nil _ = NONE
    | get ((p, c) :: t) pos = 
        if p = pos then SOME c else get t pos;
fun put nil pos c = [(pos, c)]
    | put ((p, c) :: t) pos color = 
        if p = pos then (p, color) :: t 
        else (p, c) :: (put t pos color);
val initBoard =  [((3,3), WHITE), ((4,3), BLACK), ((3,4), BLACK), ((4,4), WHITE)]
type game = {board : board, next : color option};
val init = {board = initBoard, next = SOME BLACK};

val flip = raise Fail "unimplemented"; (* 未実装 *)
val move = raise Fail "unimplemented"; (* 未実装 *)
val next = raise Fail "unimplemented"; (* 未実装 *)

fun step {next = NONE, ...} pos =  NONE
    | step {board, next = SOME color} pos = 
        case flip board color pos of
            nil => NONE
        | posisitions => 
            let
                val b  = move board color (pos :: posisitions);
            in
                SOME {board = b, next = next b color}
            end ; 

fun play moves = 
        foldl 
        (fn (pos, NONE) => NONE (* posが不正な場合、NONEが返ってくるので *)
            | (pos, SOME game) => step game pos)
        (SOME init)
        moves;
