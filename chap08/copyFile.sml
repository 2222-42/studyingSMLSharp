
(*
opening TextIO
  type vector = string // the array of elements to input
  type elem = char // element to input.
  type instream
  type outstream
  val input : instream -> vector
  val input1 : instream -> elem option
  val inputN : instream * int -> vector
  val inputAll : instream -> vector
  val canInput : instream * int -> int option
  val lookahead : instream -> elem option
  val closeIn : instream -> unit
  val endOfStream : instream -> bool
  val output : outstream * vector -> unit
  val output1 : outstream * elem -> unit
  val flushOut : outstream -> unit
  val closeOut : outstream -> unit
  structure StreamIO :
    sig
      type vector = string  // the array of elements to input
      type elem = char // element to input
      type reader = reader
      type writer = writer
      type instream
      type outstream
      type pos = pos
      type out_pos
      val input : instream -> vector * instream
      val input1 : instream -> (elem * instream) option
      val inputN : instream * int -> vector * instream
      val inputAll : instream -> vector * instream
      val canInput : instream * int -> int option
      val closeIn : instream -> unit
      val endOfStream : instream -> bool
      val mkInstream : reader * vector -> instream
      val getReader : instream -> reader * vector
      val filePosIn : instream -> pos
      val output : outstream * vector -> unit
      val output1 : outstream * elem -> unit
      val flushOut : outstream -> unit
      val closeOut : outstream -> unit
      val setBufferMode : outstream * IO.buffer_mode -> unit
      val getBufferMode : outstream -> IO.buffer_mode
      val mkOutstream : writer * IO.buffer_mode -> outstream
      val getWriter : outstream -> writer * IO.buffer_mode
      val getPosOut : outstream -> out_pos
      val setPosOut : out_pos -> unit
      val filePosOut : out_pos -> pos
      val inputLine : instream -> (string * instream) option
      val outputSubstr : outstream * substring -> unit
    end
  val mkInstream : StreamIO.instream -> instream
  val getInstream : instream -> StreamIO.instream
  val setInstream : instream * StreamIO.instream -> unit
  val getPosOut : outstream -> StreamIO.out_pos
  val setPosOut : outstream * StreamIO.out_pos -> unit
  val mkOutstream : StreamIO.outstream -> outstream
  val getOutstream : outstream -> StreamIO.outstream
  val setOutstream : outstream * StreamIO.outstream -> unit
  val inputLine : instream -> string option
  val outputSubstr : outstream * substring -> unit
  val openIn : string -> instream
  val openString : string -> instream
  val openOut : string -> outstream
  val openAppend : string -> outstream
  val stdIn : instream
  val stdOut : outstream
  val stdErr : outstream
  val print : string -> unit
  val scanStream : ((elem,StreamIO.instream) StringCvt.reader
                    -> ('a,StreamIO.instream) StringCvt.reader)
                   -> instream -> 'a option
*)
(*
opening BinIO
  type vector = vector // the array of elements to input
  type elem = Word8.word // the array of elements to input
  type instream
  type outstream
  val input : instream -> vector
  val input1 : instream -> elem option
  val inputN : instream * int -> vector
  val inputAll : instream -> vector
  val canInput : instream * int -> int option
  val lookahead : instream -> elem option
  val closeIn : instream -> unit
  val endOfStream : instream -> bool
  val output : outstream * vector -> unit
  val output1 : outstream * elem -> unit
  val flushOut : outstream -> unit
  val closeOut : outstream -> unit
  structure StreamIO :
    sig
      type vector = vector // the array of elements to input
      type elem = Word8.word // the array of elements to input
      type reader = reader
      type writer = writer
      type instream
      type outstream
      type pos = int
      type out_pos
      val input : instream -> vector * instream
      val input1 : instream -> (elem * instream) option
      val inputN : instream * int -> vector * instream
      val inputAll : instream -> vector * instream
      val canInput : instream * int -> int option
      val closeIn : instream -> unit
      val endOfStream : instream -> bool
      val mkInstream : reader * vector -> instream
      val getReader : instream -> reader * vector
      val filePosIn : instream -> pos
      val output : outstream * vector -> unit
      val output1 : outstream * elem -> unit
      val flushOut : outstream -> unit
      val closeOut : outstream -> unit
      val setBufferMode : outstream * IO.buffer_mode -> unit
      val getBufferMode : outstream -> IO.buffer_mode
      val mkOutstream : writer * IO.buffer_mode -> outstream
      val getWriter : outstream -> writer * IO.buffer_mode
      val getPosOut : outstream -> out_pos
      val setPosOut : out_pos -> unit
      val filePosOut : out_pos -> pos
    end
  val mkInstream : StreamIO.instream -> instream
  val getInstream : instream -> StreamIO.instream
  val setInstream : instream * StreamIO.instream -> unit
  val getPosOut : outstream -> StreamIO.out_pos
  val setPosOut : outstream * StreamIO.out_pos -> unit
  val mkOutstream : StreamIO.outstream -> outstream
  val getOutstream : outstream -> StreamIO.outstream
  val setOutstream : outstream * StreamIO.outstream -> unit
  val openIn : string -> instream
  val openOut : string -> outstream
  val openAppend : string -> outstream
*)

fun copyFile inFile outFile =
    let
        open TextIO
        val inStream = TextIO.openIn inFile
                       handle E => IOErrHandler (E, fn () => ());
        val outStream = TextIO.openOut outFile
                        handle E => IOErrHandler (E, fn () => closeIn inStream);
        fun loop () =
            if endOfStream inStream then ()
            else
                case input1 inStream
                 of SOME c => (output1 (outStream, c); loop ())
                 |  NONE => loop()
    in
        (loop ()
         handle E => IOErrHandler (E, fn () => (closeIn inStream; closeOut outStream));
         closeIn inStream;
         closeOut outStream)
    end
  handle IOError => ();
