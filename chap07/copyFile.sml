fun copyFile inFile outFile = 
    let
      val inFile = FileIO.fopen (inFile, "r")
      val outFile = FileIO.fopen (outFile, "w")
      fun loop () = 
          let
            val int = FileIO.fgetc inFile
          in
            if int = FileIO.EOF then ()
            else (FileIO.fputc (int, outFile); loop ())
          end
    in
      (loop(); FileIO.fclose inFile; FileIO.fclose outFile; ())
    end

(*
# OS.Process.system "ls test2.sml";
ls: 'test2.sml' にアクセスできません: そのようなファイルやディレクトリはありません
val it = 512 : int
# copyFile "FileIO.sml" "test2.sml";
val it = () : unit
# OS.Process.system "ls test2.sml";
test2.sml
val it = 0 : int
*)