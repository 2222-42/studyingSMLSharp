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

### c 連携

動的リンクライブラリの作成

> gcc -shared -fPIC -o libsqr.so libsqr.c

現在のディレクトリにある`so`ファイルを使用する

> smlsharp -L. -lsqr

- `-L`: ライブラリパス
    - もちろん、共有ライブラリパスを指定しておかないといけない
        - `export LD_LIBRARY_PATH=/home/user/lib/`
- `-l`: ライブラリ名
    - ライブラリ名の指定はC言語の習慣で、`"lib"`と`".so"`を除いて指定する。

## structure

`structure L = (LibraryName);` とストラクチャの別名を定義する宣言を対話型モードにいれれば、評価され、その型とその操作の型がわかる。

(e.g., `structure B = Bool;`)
