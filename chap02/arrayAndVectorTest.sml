(* 
structure Array =
  struct
    type 'a array = 'a array
    type 'a vector = 'a vector
    val maxLen = 268435455 : int
    val array = fn : ['a. int * 'a -> 'a array]
    val fromList = fn : ['a. 'a list -> 'a array]
    val tabulate = fn : ['a. int * (int -> 'a) -> 'a array]
    val length = <builtin> : ['a. 'a array -> int]
    val sub = <builtin> : ['a. 'a array * int -> 'a]
    val update = <builtin> : ['a. 'a array * int * 'a -> unit]
    val vector = fn : ['a. 'a array -> 'a vector]
    val copy = <builtin> : ['a. {di: int, dst: 'a array, src: 'a array} -> unit]
    val copyVec = fn : ['a. {di: int, dst: 'a array, src: 'a vector} -> unit]
    val appi = fn : ['a. (int * 'a -> unit) -> 'a array -> unit]
    val app = fn : ['a. ('a -> unit) -> 'a array -> unit]
    val modifyi = fn : ['a. (int * 'a -> 'a) -> 'a array -> unit]
    val modify = fn : ['a. ('a -> 'a) -> 'a array -> unit]
    val foldli = fn : ['a, 'b. (int * 'a * 'b -> 'b) -> 'b -> 'a array -> 'b]
    val foldri = fn : ['a, 'b. (int * 'a * 'b -> 'b) -> 'b -> 'a array -> 'b]
    val foldl = fn : ['a, 'b. ('a * 'b -> 'b) -> 'b -> 'a array -> 'b]
    val foldr = fn : ['a, 'b. ('a * 'b -> 'b) -> 'b -> 'a array -> 'b]
    val findi = fn : ['a. (int * 'a -> bool) -> 'a array -> (int * 'a) option]
    val find = fn : ['a. ('a -> bool) -> 'a array -> 'a option]
    val exists = fn : ['a. ('a -> bool) -> 'a array -> bool]
    val all = fn : ['a. ('a -> bool) -> 'a array -> bool]
    val alli = fn : ['a. (int * 'a -> bool) -> 'a array -> bool]
    val collate = fn : ['a. ('a * 'a -> order) -> 'a array * 'a array -> order]
  end
*)
(* 
structure Vector =
  struct
    type 'a vector = 'a vector
    val maxLen = 268435455 : int
    val fromList = fn : ['a. 'a list -> 'a vector]
    val tabulate = fn : ['a. int * (int -> 'a) -> 'a vector]
    val length = <builtin> : ['a. 'a vector -> int]
    val sub = <builtin> : ['a. 'a vector * int -> 'a]
    val update = fn : ['a. 'a vector * int * 'a -> 'a vector]
    val concat = fn : ['a. 'a vector list -> 'a vector]
    val appi = fn : ['a. (int * 'a -> unit) -> 'a vector -> unit]
    val app = fn : ['a. ('a -> unit) -> 'a vector -> unit]
    val mapi = fn : ['a, 'b. (int * 'a -> 'b) -> 'a vector -> 'b vector]
    val map = fn : ['a, 'b. ('a -> 'b) -> 'a vector -> 'b vector]
    val foldli = fn : ['a, 'b. (int * 'a * 'b -> 'b) -> 'b -> 'a vector -> 'b]
    val foldri = fn : ['a, 'b. (int * 'a * 'b -> 'b) -> 'b -> 'a vector -> 'b]
    val foldl = fn : ['a, 'b. ('a * 'b -> 'b) -> 'b -> 'a vector -> 'b]
    val foldr = fn : ['a, 'b. ('a * 'b -> 'b) -> 'b -> 'a vector -> 'b]
    val findi = fn : ['a. (int * 'a -> bool) -> 'a vector -> (int * 'a) option]
    val find = fn : ['a. ('a -> bool) -> 'a vector -> 'a option]
    val exists = fn : ['a. ('a -> bool) -> 'a vector -> bool]
    val all = fn : ['a. ('a -> bool) -> 'a vector -> bool]
    val collate =
      fn : ['a. ('a * 'a -> order) -> 'a vector * 'a vector -> order]
  end
*)

val intArray = Array.array(10, 0);
val a = Array.sub(intArray, 0);
Array.update(intArray, 5, 1);
intArray;
val intVector = Vector.fromList [1,2,3];
val v = Vector.sub (intVector, 0);
val updatedV = Vector.update(intVector, 2, 5);
intVector;