structure myDBEnv =
struct

val dbPrivateSetting = {
    user = "",
    password = ""
};
val inFile = ".env.json";

fun 'a#reify castLike data (sample: 'a) =
    Dynamic.view (_dynamic data as 'a Dynamic.dyn);
fun readJson inFile =
    castLike (Dynamic.fromJsonFile inFile) dbPrivateSetting;
(*
uncaught exception PartialDynamic.RuntimeTypeError at (interactive):5.18

the above error is occured by the mismatched of types.
*)

val (user, password) =
    let
        val json = readJson inFile
    in
        (#user json, #password json)
    end;

end
