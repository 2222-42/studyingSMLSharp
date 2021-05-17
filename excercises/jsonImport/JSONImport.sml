structure JSONImport =
struct

fun downloadJson url =
    let
        val tmpFile = OS.FileSys.tmpName ();
        val cmd =
            "wget -o wget.log -O " ^ tmpFile ^ " " ^ "\"" ^ url ^ "\"";
        val _ = OS.Process.system cmd;
    in
        Dynamic.fromJsonFile tmpFile
        before OS.FileSys.remove tmpFile
    end;

fun 'a#reify castLike data (sample: 'a) =
    Dynamic.view (_dynamic data as 'a Dynamic.dyn);

fun 'a#reify import {url, sample : 'a, ...} =
    castLike (downloadJson url) sample;
end;

