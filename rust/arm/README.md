# Arm with Rust

```
$ rustup target add armv7-unknown-linux-gnueabihf
$ sudo apt install gcc-arm-linux-gnueabihf -y
$ cargo build --target=armv7-unknown-linux-gnueabihf
$ file target/armv7-unknown-linux-gnueabihf/debug/arm        [kubo39:arm][git:master]
target/armv7-unknown-linux-gnueabihf/debug/arm: ELF 32-bit LSB shared object, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-armhf.so.3, for GNU/Linux 3.2.0, BuildID[sha1]=2720c6899661ad73b6d5da06c604be3bfe5f5661, not stripped
```
