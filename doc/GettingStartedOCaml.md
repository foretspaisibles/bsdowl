# Getting started with an OCaml program

Here is how **BSD Owl Scripts** can help you to compile a simple OCaml
program `wordcount`, your own implementation of the UNIX `wc(1)`
utility.  After reading this page, you will know:

 - How to compile a simple OCaml program.
 - How to install that program.
 - How to clean compilation products.
 - How to compile a more complex OCaml program using ocamlfind

We first assume that the source code is a single file `wordcount.ml`
and then consider a more complex case.


## Compile a simple OCaml program

We create a directory to hold our files and put our source there.
Along the source, we create a `Makefile` with the following content:

```makefile
PROGRAM=		wordcount
.include "ocaml.prog.mk"
```

We can now `make` our program to produce a `wordcount` binary.  The
complete output of the make process looks like this:

```console
make configure
make depend
(cd /Users/michael/Workshop/bsdowl-ocaml && ocamldep wordcount.ml) | cat  > .depend
make build
ocamlc -c -o wordcount.cmo wordcount.ml
ocamlc -o wordcount.byte wordcount.cmo
cp wordcount.byte wordcount
make doc
make test
```

When we call `make` without argument it is the same thing as `make
all` which decomposes as `make configure`, `make depend`,
`make build`, `make doc` and `make test` as we see.  In this example,
the `make configure`, `make doc` and `make test` steps are not bound
to any recipe or shell command, but it would be the case in more
elaborated examples.

We can now test our program, edit it and re-`make` it as needed.


## Install a simple OCaml program

Once we are satisfied with the results, we can install it
with `make install`.  It will call `su` to gain root privileges
and install our program under `/usr/local/bin`,  a value deduced
from *PREFIX*

```console
% make install
===> Switching to root credentials for target (install)
Password:
/usr/bin/install -c -d /usr/local/bin
install -o root -g wheel -m 555 wordcount /usr/local/bin
```

We can examine the value of the *PREFIX* variable, as any other
variable, with `make -V`:

```console
% make -V PREFIX
/usr/local
```

If we want to install our program to another location like
`${HOME}/bin` we only need to change the *PREFIX*.  The prefix
selection is usually left to the `configure` script of a project,
but, for this simple example, we will only add a `PREFIX=${HOME}`
assignment to our `Makefile`:

```makefile
PROGRAM=		wordcount
PREFIX=			${HOME}
.include "ocaml.prog.mk"
```

The order of variable declarations is not important but they have to
come before the `.include` line.  While this step can sometimes be
skipped, it is a good habit to `make clean` after changing the
configuration of a package.


```console
% make clean install
…
/usr/bin/install -c -d /home/michael/bin
install -o michael -g michael -m 550 wordcount /home/michael/bin
```

Note that since we have write access to the *PREFIX* directory, it is
not necessary to gain root privileges for this installation.


## Clean compilation products

Once we are done, we can remove object code from the directory with

```console
% make clean
rm -f wordcount.cmo wordcount.cmi wordcount.cb wordcount
```

If we look closely, we will notice that the `.depend` file is not
removed:

```console
% ls -A
.depend      Makefile     wordcount.ml
```

This is on purpose, and if we also want to get rid of the `.depend`
file we can use the more powerful mantra

```console
% make realclean
rm -f wordcount.cmo wordcount.cmi wordcount.cb wordcount
rm -f .depend
```


## Compile a more complex OCaml program using ocamlfind

As a consequence _Zawinski's Law of Software Envelopment_ we decided
to build a mail reader in our `wordcount` program.  Our code source
now consists of our main file `wordcount.ml` and a library
`mailreader.ml` relying on the `lwt.unix` library.  Here is the
corresponding `Makefile`:

```makefile
PROGRAM=		wordcount
SRCS+=			mailreader.ml
SRCS+=			wordcount.ml

EXTERNAL=		ocaml.findlib:github.unix

.include "ocaml.prog.mk"
```

While dependencies between modules are computed with `ocamldep` so
that modules are compiled as needed, the order in which the files are
listed in *SRCS* is used by the linker.  It is thus important to list
files in an order suited to the linking phase.


## Features highlight

Here is a list of more advanced features that we may find useful when
developping OCaml projects:

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
