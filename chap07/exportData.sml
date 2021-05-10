val puts = _import "puts" : string -> int;
puts "SML#";
val modf = _import "modf" : (real, real ref) -> real;
val iptr = ref 0.0;
modf (3.14, iptr);
!iptr;