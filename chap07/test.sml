val sqrInt16 = _import "sqrShort" : int16 -> int16;
sqrInt16 16;
val sqrReal = _import "sqrDouble" : real -> real; 
sqrReal 64.0;
val pow = _import "pow" : (real, real) -> real;
pow (2.0, 2.0);