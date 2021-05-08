structure Game =
struct
  type pos = int * int;
  datatype color = BLACK | WHITE;
  type board = (pos * color) list;

  val boardSize = 8;
  val allPos = 
    List.tabulate 
    (boardSize * boardSize, fn i => (i mod boardSize, i div boardSize));

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

  val directions = 
    [
      (~1, ~1), (0, ~1), (1, ~1), (~1, 0),
      (1, 0), (~1, 1), (0, 1), (1,1)
    ];


  fun flipDir' board color (x, y) (dir as (dx, dy)) = 
      let
        val pos = (x + dx, y + dy)
      in
        case get board pos of
          NONE => NONE
        | SOME c => 
          if c = color then SOME nil
          else case flipDir' board color pos dir of
              NONE => NONE
            | SOME t => SOME (pos :: t)
      end;

  fun flipDir board color pos (dir as (dx, dy)) = 
      getOpt (flipDir' board color pos dir, nil);

  fun flip board color pos= 
      case get board pos of
        SOME _ => nil (* すでに石がある場合はおけないので *)
      | NONE => List.concat (map (flipDir board color pos) directions); (* 8方向で挟まれた相手の石の座標のリスト *)
  fun move board color posisitions = 
      foldl (fn (pos, board) => put board pos color) board posisitions;

  fun opponent BLACK = WHITE 
    | opponent WHITE = BLACK;
  fun possible board color= 
      List.filter
      (fn pos => not (null (flip board color pos)))
      allPos;

  fun next board color = 
      case possible board (opponent color) of
        _ :: _ => SOME (opponent color)
      | nil => 
        case possible board color of
          _ :: _ => SOME color
        | nil => NONE; 

  fun step {next = NONE, ...} pos = NONE
    | step {board, next = SOME color} pos = 
      case flip board color pos of
        nil => SOME {board = board, next = SOME color}
      | posisitions => 
        let
          val b  = move board color (pos :: posisitions);
        in
          SOME {board = b, next = next b color}
        end;

  fun play moves = 
      foldl 
      (fn (pos, NONE) => NONE (* posが不正な場合、NONEが返ってくるので *)
        | (pos, SOME game) => step game pos)
      (SOME init)
      moves;

end