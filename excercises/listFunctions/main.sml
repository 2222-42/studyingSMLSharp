

val N = 6;
val L1 = [1,2,3,4,5,6];
val L2 = [6, 5, 4, 3, 2, 1];

val L1L2 = ListFunctions.append (L1, L2);
val L2L1List = L2 :: L1 :: nil;
val L2L1ListConcat = ListFunctions.concat L2L1List;
val L1L2Zip = ListFunctions.zip (L1, L2);
val L1L2ZipFilter = ListFunctions.filter (fn (x, y) => x < y) L1L2Zip;
val listPair = ListFunctions.unzip L1L2ZipFilter;
val resultRecord = {
        1_n = N,
        2_L1 = L1,
        3_L2 = L2,
        4_L1L2 = L1L2, 
        5_L2L1List = L2L1List, 
        6_L2L1ListConcat = L2L1ListConcat, 
        7_L1L2Zip = L1L2Zip, 
        8_L1L2ZipFilter = L1L2ZipFilter, 
        9_listPair = listPair
    };
Dynamic.pp resultRecord;