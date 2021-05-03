# studyingSMLSharp

## コマンド

### スイッチ

- `-c` : コンパイルするsmlファイルを指定(インターフェイスファイルsmiが準備されていること)
- `-o` : オブジェクトファイルに出力
- `-r` : オブジェクトファイルを対話型モードのSML#にリンクして実行する

> smlsharp -o main.o -c main.sml
> smlsharp -r main.smi

### make

> smlsharp -MMm main.smi > Makefile
> make
> ./main

## structure

`structure L = (LibraryName);` とストラクチャの別名を定義する宣言を対話型モードにいれれば、評価され、その型とその操作の型がわかる。

(e.g., `structure B = Bool;`)
