実行記録

CPU: Intel(R) Core(TM) i7-8750H CPU @ 2.20GHz

```markdown 
time NTHREADS=1 ./ray
NTHREADS=1 ./ray  3.01s user 0.03s system 107% cpu 2.832 total

real    0m2.921s
user    0m3.109s
sys     0m0.108s
```

``` markdown
NTHREADS=4 ./ray  3.55s user 0.04s system 406% cpu 0.884 total

real    0m0.878s
user    0m3.531s
sys     0m0.037s
```

``` markdown 
NTHREADS=8 ./ray  5.71s user 0.07s system 804% cpu 0.718 total

real    0m0.793s
user    0m6.296s
sys     0m0.061s
```

``` markdown
NTHREADS=16 ./ray  345.59s user 0.61s system 1173% cpu 29.499 total

real    0m35.270s
user    7m0.572s
sys     0m0.408s
```

16スレッドにしたら実際にかかる時間がめっちゃ増えた。

CPU性能の差なのだろうか？
