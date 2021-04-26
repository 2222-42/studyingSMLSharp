val intRef = ref 0;
!intRef;
intRef := !intRef + 1;
!intRef;
(intRef := !intRef + 1; !intRef);