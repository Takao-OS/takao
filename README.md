# Takao

![forthebadge](https://forthebadge.com/images/badges/contains-cat-gifs.svg)

A kernel, written in D with tons of love and cat pics.

## Building the source code

Make sure you have installed:

* `ldc`, a LLVM based D compiler.
* `lld`, the LLVM project linker.
* `nasm`.
* `make`.

To build the kernel, it is enough with a simple `make`, add flags as needed.
To test, run `make test`.

An example for a release build some appropiate flags would be
`make DFLAGS='-O -release -inline'`, while the default flags are suited for
debug/development builds, architecture target can also be chosen with the
`ARCH` variable.
