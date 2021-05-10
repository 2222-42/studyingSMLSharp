(* 
void qsort(void *base, size_t num, size_t size, 
           int (*compare)(const void*, const void*))

- void *base : 配列の先頭ポインタ(ソート対象データ)
- size_t nmemb : 配列の要素数
- size_t size : 配列要素の大きさ(バイト数)
- int (*compare)(const void*, const void*) : 排列要素比較関数へのポインタ

これらの要素の型をSML#で定義し、さらに、対応する値を使用どおりパラメータとして渡す必要がある。
*)