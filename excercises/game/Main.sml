structure Main =
struct

  fun stringToPos s = (* string -> pos option *)
      case map Int.fromString (String.tokens Char.isSpace s) of
        [SOME x, SOME y] => SOME(x, y)
      | _ => NONE;
  fun readPos () = 
      case TextIO.inputLine TextIO.stdIn of
        NONE => NONE
      | SOME s => stringToPos s;

  fun colorToString Game.BLACK = "X"
    | colorToString Game.WHITE = "Y";
  fun rowToString board y = 
      Int.toString y
      ^ String.concat(
        (List.tabulate (Game.boardSize, fn x => case Game.get board (x, y) of
                SOME c => colorToString c
              | NONE => "_")))
      ^ "\n";

  fun boardToString board = 
      " " 
      ^ String.concat(
        List.tabulate (Game.boardSize, fn x => Int.toString x)) 
      ^ "\n"
      ^ String.concat(List.tabulate (Game.boardSize, rowToString board));

  fun possibleToString board color = 
      String.concatWith ", " (map (fn (x, y) => Int.toString x ^ " " ^ Int.toString y) (Game.possible board color));
  
  fun gameToString {board, next = SOME c} = (* game -> string *)
      boardToString board ^ colorToString c ^ "の手番です\n" 
      ^ "可能な手は以下の通りです: \n"
      ^ possibleToString board c ^ "\n"
    | gameToString {board, next = NONE} = 
      boardToString board ^ "終局\n";

  fun input () = (* unit -> pos list*)
      case readPos () of
        NONE => nil
      | SOME pos => pos :: input ();
  fun output NONE = ()(* game option ->  unit *)
    | output (SOME board) = print (gameToString board);
  
  fun main () = output (Game.play (input()));

  fun mainLoop game = 
      (print (gameToString game);
        case readPos() of
          NONE => mainLoop game (* 何も入力しない場合も終わらせない *)
        | SOME pos => 
          case Game.step game pos of
            NONE => ()
          | SOME game => mainLoop game);
end

val _ = Main.mainLoop Game.init;