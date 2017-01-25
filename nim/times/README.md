# Nim time

- epochTime

```
$ ~/Nim/bin/nim -v                                                                          [d148161:test][git:master]
Nim Compiler Version 0.16.0 (2017-01-25) [Linux: amd64]
Copyright (c) 2006-2017 by Andreas Rumpf

git hash: c7e54eba91e31091a40dfa6d96a7a323db63b933
active boot switches: -d:release
$ cat epochTime.nim                                                                        [d148161:times][git:master]
import times

discard epochTime()
$ ~/Nim/bin/nim c epochTime.nim                                                            [d148161:times][git:master]
Hint: used config file '/home/hiroki.noda/Nim/config/nim.cfg' [Conf]
Hint: system [Processing]
Hint: epochTime [Processing]
Hint: times [Processing]
Hint: strutils [Processing]
Hint: parseutils [Processing]
Hint: math [Processing]
Hint: algorithm [Processing]
Hint:  [Link]
Hint: operation successful (15976 lines compiled; 0.360 sec total; 31.418MiB peekmem; Debug Build) [SuccessX]
$ ltrace -e gettimeofday ./epochTime                                                       [d148161:times][git:master]
epochTime->gettimeofday(0x7ffc9e501c60, nil)                             = 0
+++ exited (status 0) +++
$ ltrace -e clock_gettime ./epochTime                                                      [d148161:times][git:master]
+++ exited (status 0) +++
$                                                                                          [d148161:times][git:master]
```
