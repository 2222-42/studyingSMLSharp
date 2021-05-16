structure ReadIntStream =
struct

open TextIO;
fun getStreamFromFile inFile = openIn inFile
                               handle E => IOErrHandler (E, fn () => ());
fun getStreamFromInstream inStream = getInstream inStream
                                     handle E => IOErrHandler (E, fn () => closeIn inStream);
fun loop cvt stream result =
    if StreamIO.endOfStream stream then result
    else
        case Int.scan cvt StreamIO.input1 stream
         of SOME (i, s) => loop cvt s (i :: result)
          | NONE => result;

fun readBinStream inFile =
    let
        val inStreamNotStream = getStreamFromFile inFile;
        val inStream = getStreamFromInstream inStreamNotStream;
    in
        (rev(loop StringCvt.BIN inStream [])
         handle E => IOErrHandler (E, fn () => (StreamIO.closeIn inStream; closeIn inStreamNotStream))
         before (StreamIO.closeIn inStream;
         closeIn inStreamNotStream)
         )
    end;

fun readDecStream inFile =
    let
        val inStreamNotStream = getStreamFromFile inFile;
        val inStream = getStreamFromInstream inStreamNotStream;
    in
        (rev(loop StringCvt.DEC inStream [])
         handle E => IOErrHandler (E, fn () => (StreamIO.closeIn inStream; closeIn inStreamNotStream))
         before (StreamIO.closeIn inStream;
         closeIn inStreamNotStream)
         )
    end;

fun readOctStream inFile =
    let
        val inStreamNotStream = getStreamFromFile inFile;
        val inStream = getStreamFromInstream inStreamNotStream;
    in
        (rev(loop StringCvt.OCT inStream [])
         handle E => IOErrHandler (E, fn () => (StreamIO.closeIn inStream; closeIn inStreamNotStream))
         before (StreamIO.closeIn inStream;
         closeIn inStreamNotStream)
         )
    end;

fun readHexStream inFile =
    let
        val inStreamNotStream = getStreamFromFile inFile;
        val inStream = getStreamFromInstream inStreamNotStream;
    in
        (rev(loop StringCvt.HEX inStream [])
         handle E => IOErrHandler (E, fn () => (StreamIO.closeIn inStream; closeIn inStreamNotStream))
         before (StreamIO.closeIn inStream;
         closeIn inStreamNotStream)
         )
    end;


end
