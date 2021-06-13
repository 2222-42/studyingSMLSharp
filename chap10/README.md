実行記録

## ray

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

### ray with myth

``` markdown
time MYTH_NUM_WORKERS=2 ./ray
real    0m2.193s
user    0m4.339s
sys     0m0.008s
```

``` markdown
time MYTH_NUM_WORKERS=4 ./ray

real    0m1.426s
user    0m5.644s
sys     0m0.020s
```

``` markdown
time MYTH_NUM_WORKERS=8 ./ray

real    0m1.132s
user    0m8.899s
sys     0m0.045s
```

``` markdown
time MYTH_NUM_WORKERS=16 ./ray

real    0m13.935s
user    2m39.871s
sys     0m0.697s
```

それほど早くなっていないが、16スレッドの場合はかなり向上している。

### ray with parallel_for

``` markdown
time MYTH_NUM_WORKERS=1 ./ray

real	0m2.823s
user	0m2.804s
sys	0m0.000s

```

``` markdown
time MYTH_NUM_WORKERS=2 ./ray

real	0m1.465s
user	0m2.892s
sys	0m0.016s
```

``` markdown
time MYTH_NUM_WORKERS=4 ./ray

real	0m0.875s
user	0m3.461s
sys	0m0.016s

```

``` markdown
time MYTH_NUM_WORKERS=8 ./ray

real	0m0.688s
user	0m5.373s
sys	0m0.041s
```

``` markdown
time MYTH_NUM_WORKERS=16 ./ray

real	0m8.383s
user	1m36.674s
sys	0m0.329s
```


## pfib

``` markdown
MYTH_NUM_WORKERS=2 ./pfib
0.638398
```

``` markdown
MYTH_NUM_WORKERS=4 ./pfib
0.408988
```

``` markdown
 MYTH_NUM_WORKERS=8 ./pfib
0.329351
```

``` markdown
MYTH_NUM_WORKERS=16 ./pfib                                                                                                                                            
0.554931
```

``` markdown
MYTH_NUM_WORKERS=32 ./pfib
0.831525
```
