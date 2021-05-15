exception IOError;
fun IOErrHandler exn =
    (case exn
      of IO.Io {name, function, cause}
         => (print ("IO Error: "^ function ^ " failed.\n");
             case cause
              of OS.SysErr (s, e) => print (s ^ ": ")
               | _  => print (exnMessage cause ^ ": ");
             print (name ^ "\n")
            )
       | IO.BlockingNotSupported =>
         print "IO failed : blocking not supported.\n"
       | IO.NonblockingNotSupported =>
         print "IO failed : nonblocking not supported.\n"
       | IO.RandomAccessNotSupported =>
         print "IO failed : random access not supported.\n"
       | IO.ClosedStream =>
         print "IO failed : closed stream.\n"
       | exn => raise exn;
     raise IOError
    );
(*
val ins = TextIO.openIn "notAFile.sml"
          handle exn => IOErrHandler exn;
*)
