fun readBinStream inFile =
    let
        open TextIO;
        val inStreamNotStream = openIn inFile
                                handle E => IOErrHandler (E, fn () => ());
        val inStream = getInstream inStreamNotStream
                       handle E => IOErrHandler (E, fn () => closeIn inStreamNotStream);
        val resultInt = [];
        fun loop stream result =
            if StreamIO.endOfStream stream then result
            else
                case Int.scan StringCvt.BIN StreamIO.input1 stream
                 of SOME (i, s) => loop s (i :: result)
                  | NONE => result
    in
        (rev(loop inStream resultInt)
         handle E => IOErrHandler (E, fn () => (StreamIO.closeIn inStream; closeIn inStreamNotStream))
         before (StreamIO.closeIn inStream;
         closeIn inStreamNotStream)
         )
    end
