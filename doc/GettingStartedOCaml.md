# Getting started with an OCaml program

Here is how BSD Owl Scripts can help you to compile a simple
OCaml program `wordcount`, your own implementation of the UNIX `wc(1)`
utility.

We first assume that the source code is a single file `wordcount.ml`
and then consider a more complex case.


## The first time

Create a directory to hold your files and put your source there.
Along the source, create a `Makefile` with the following content:

```makefile
PROGRAM=    wordcount
.include "ocaml.prog.mk"
```

## Building

You can now `make` your program and produce a `wordcount` binary.  The
complete output of the make process looks like this:

```console
% make
make depend
ocamldep  wordcount.ml > .depend
make build
ocamlc -c -o wordcount.cmo wordcount.ml
ocamlc -o wordcount.cb wordcount.cmo
cp wordcount.cb wordcount
make doc
```

When you call `make` without argument it is the same thing as
`make all` which decomposes as `make depend` and `make build` as you
see.  You can test your program, edit it and re-`make` it.


## Installing

Once you are satisfied with the results, you can install it with `make
install`.  It will call `su` to gain root privileges and install your
program under `/usr/local/bin` a value deduced from *PREFIX*

```console
% make install
===> Switching to root credentials for target (install)
Password:
/usr/bin/install -c -d /usr/local/bin
install -o root -g wheel -m 555 wordcount /usr/local/bin
```

You can check the value of the *PREFIX* variable, or any other
variable, with `make -V` as in

```console
% make -V PREFIX
/usr/local
```

If you want to install your program to another location like
`${HOME}/bin` you only need to change the *PREFIX*.  You can make the
change permanent by adding a `PREFIX=${HOME}` line to your `Makefile`:

```makefile
PROGRAM=    wordcount
PREFIX=     ${HOME}
.include "ocaml.prog.mk"
```

The order of variable declarations is not important but they have to
come before the `.include` line.  It is also possible to use
`PREFIX=${HOME}` just once by adding it on the command line without
editing the `Makefile`:

```console
% make PREFIX=${HOME} install
/usr/bin/install -c -d /home/michael/bin
install -o michael -g michael -m 550 wordcount /home/michael/bin
```

Note that since you have write access to the *PREFIX* directory, it is
not necessary to gain root privileges for this installation.


## Cleaning

Last you can remove object code from the directory with

```console
% make clean
rm -f  wordcount.cmo wordcount.cmi wordcount.cb wordcount
```

If you look closely, you will notice that the `.depend` file is not
removed:

```console
% ls -A
.depend      Makefile     wordcount.ml
```

This is on purpose, and if you also want to get rid of the `.depend`
file you can use the more powerful mantra

```console
% make realclean
rm -f  wordcount.cmo wordcount.cmi wordcount.cb wordcount
rm -f  .depend
```

## Several files and auxilary libraries

As a consequence _Zawinski's Law of Software Envelopment_ you decided
to build a mail reader in your `wordcount` program.  Your code source
now consists of your main file `wordcount.ml` a library
`mailreader.ml` relying on the `unix.cma` library.  Here is the
corresponding `Makefile`:

```makefile
PROGRAM=    wordcount
SRCS+=      mailreader.ml
SRCS+=      wordcount.ml
LIBS+=      unix
.include "ocaml.prog.mk"
```

While dependencies between modules are computed with `ocamldep` so
that modules are compiled as needed, the order in which the files are
listed in *SRCS* is used by the linker.  It is thus important to list
files in an order suited to the linking phase.


## Features highlight

Here is a list of more advanced features that you may find useful when
developping OCaml projects.

 - Compilation of bytecode and native executables;
 - Support of ocamlfind to link against 3rd party packages;
 - Support of ocamldoc to generate module documentation;
 - Support of ocamlprof to generate profiling information;
 - Support of debugging symbols;
 - Support of ocamllex and ocamlyacc to generate lexers and parsers;
 - Support parallel mode (at the directory level);
 - Support separate trees for sources and objects;
 - Support native and byte code;
 - Smart dependencies handling avoiding “inconsistant assumptions” over
   interfaces.

These features are described in the documentation.
