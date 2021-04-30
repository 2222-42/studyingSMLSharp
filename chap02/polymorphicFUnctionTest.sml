(* 2.4.1 *)

fun fst (x, _) = x;
fun id x = x;

fun isNil nil = true
    | isNil (_ :: _) = false;

exception NilError;

fun last [x] = x
    | last (h::t) = last t
    | last nil = raise NilError;

(* 2.4.2 *)


fun age {name, age} = age;
(* val age = fn : ['a, 'b. {age: 'a, name: 'b} -> 'a] *)
fun name {name, ...} = name;
(* val name = fn : ['a#{name: 'b}, 'b. 'a -> 'b] *)
fun name' x = #name x;

fun incAge x = x # {age = #age x + 1};
fun incAge' (x as {age, ...}) = x # {age = age + 1};

val person = {name= "John Doe", age= 23};
val result1 = incAge(person);
result1;
val result2 = incAge'(result1);
result2;

val distiller = {age = 21, distiller = "Hart Brothers"};
val result = incAge(distiller);