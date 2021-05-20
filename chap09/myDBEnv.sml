structure myDBEnv =
struct
val user = "";
val password = "";

val dbPrivateSetting = {
    user = "",
    password = ""
};
fun 'a#reify castLike data (sample: 'a) =
    Dynamic.view (_dynamic data as 'a Dynamic.dyn);

val inFile = ".env"
fun readJson inFile =
    castLike (Dynamic.fromJsonFile inFile) dbPrivateSetting;
(*
uncaught exception PartialDynamic.RuntimeTypeError at (interactive):5.18
*)

(*open TextIO;
fun getStreamFromFile inFile = openIn inFile
                               handle E => IOErrHandler (E, fn () => ());
fun getStreamFromInstream inStream = getInstream inStream
                                     handle E => IOErrHandler (E, fn () => closeIn inStream);
fun loop cvt stream result =
    if StreamIO.endOfStream stream then result
    else
        case Int.scan cvt StreamIO.input1 stream
         of SOME (i, s) => loop cvt s (i :: result)
          | NONE => result;*)

end
