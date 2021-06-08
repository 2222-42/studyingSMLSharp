type 'a queue = {
    buf : 'a option array,  (* バッファ  *)
    begin : int ref, (* データの開始位置 *)
    numData : int ref, (* データの長さ *)
    mutex : Pthread.mutex, (* ミューテックス *)
    condNotFull : Pthread.cond, (* 条件変数 *)
    condNotEmpty : Pthread.cond  (*  条件変数 *)
}

(* バッファの大きさnのキューを作る *)
fun create n : 'a queue = {
    buf = Array.array(n, NONE),
    begin = ref 0,
    numData = ref 0,
    mutex = Pthread.Mutex.create (),
    condNotFull =  Pthread.Cond.create (),
    condNotEmpty = Pthread.Cond.create ()
};

fun enqueue ({buf, begin, numData, mutex, condNotFull, condNotEmpty}, item) = (
    Pthread.Mutex.lock mutex;
    while not (!numData < Array.length buf)
          do Pthread.Cond.wait (condNotFull, mutex);
    Array.update
        (buf, (!begin + !numData) mod Array.length buf, SOME item);
    numData := !numData + 1;
    Pthread.Cond.signal condNotEmpty;
    Pthread.Mutex.unlock mutex
);

fun dequeue {buf, begin, numData, mutex, condNotFull, condNotEmpty} = (
    Pthread.Mutex.lock mutex;
    while not (!numData > 0)
          do Pthread.Cond.wait (condNotEmpty, mutex);
    let
        val i = valOf (Array.sub (buf, !begin))
    in
        Array.update (buf, !begin, NONE);
        numData := !numData - 1;
        begin := (!begin + 1) mod Array.length buf;
        Pthread.Cond.signal condNotFull;
        Pthread.Mutex.unlock mutex;
        i
    end
);


fun destroy (q : 'a queue) =
    (
      Pthread.Mutex.destroy (#mutex q);
      Pthread.Cond.destroy (#condNotFull q);
      Pthread.Cond.destroy (#condNotEmpty q)
    );
