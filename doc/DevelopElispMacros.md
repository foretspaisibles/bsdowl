# Develop Elisp Macros

On this page, you will learn how to use **BSD Owl Scripts** to
byte-compile and install *elisp* macros to use with **Emacs**.


## Compile and install simple elisp macros

We assume we have a written a bunch of *elisp* macros called **emake**,
that are implemented in the files `emake1.el` and `emake2.el`.


### The first time

We create a directory to hold our files and put our source there.
Along the source, we prepare a `Makefile` with the following content:

```makefile
LIBRARY=		emake

SRCS=			emake1.el
SRCS+=			emake2.el

.include "elisp.lib.mk"
```


### Building

We can now `make` our project and produce a byte-code compiled version
of our files.

```console
% make
make depend
make build
/usr/local/bin/emacs -batch --eval '(progn (defun bsdowl-dest-file-function (filename) (let ((pwd (expand-file-name ".")) (basename (replace-regexp-in-string ".*/" "" filename))) (concat (file-name-as-directory pwd) basename "c"))) (setq byte-compile-dest-file-function (quote bsdowl-dest-file-function)) (batch-byte-compile))' /home/michael/bsdowl/example/elisp/emake1.el /home/michael/bsdowl/example/elisp/emake2.el
Wrote /home/michael/bsdowl/example/elisp/emake1.elc
Wrote /home/michael/bsdowl/example/elisp/emake2.elc
make doc
```

This does slightly more as running the `batch-byte-compile` function,
which actually compiles the sources.  The extra-work is a preparation
step needed to support having the sources and the objects in different
directories in conjunction with the use of *MAKEOBJDIR* or
*MAKEOBJDIRPREFIX* environment variables.

When we call `make` without argument it is the same thing as
`make all` which decomposes as the sequence:

    make configure
    make depend
    make build
    make doc

Some steps are not connected to any shell commands in the special case
taken as example, but they can have command attached to them in more
complicated projects.  We can test our macros, edit them and re-`make`
them.


### Installing

Once we are satisfied with the results, we can install the macros with
`make install`.  The program **make** will call **su** to gain root
privileges and install the macros under the appropriate subdirectory
of `/usr/local`, the value of *PREFIX*

```console
% make install
make install
===> Switching to root credentials for target (install)
install -d /usr/local/share/share/emacs/site-lisp
install -o root -g wheel -m 444 /home/michael/bsdowl/example/elisp/emake1.el /usr/local/share/share/emacs/site-lisp
install -o root -g wheel -m 444 /home/michael/bsdowl/example/elisp/emake2.el /usr/local/share/share/emacs/site-lisp
install -o root -g wheel -m 444 emake1.elc /usr/local/share/share/emacs/site-lisp
install -o root -g wheel -m 444 emake2.elc /usr/local/share/share/emacs/site-lisp
```

The actual directory used is determined by the *ELISPDIR* variable.
We can verify its value, or the value of any other
variable, with `make -V` as in

```console
% make -V ELISPDIR
${datarootdir}/emacs/site-lisp
```

If we want to install our program to another location like `${HOME}/`
we only need to change the *PREFIX*.  The prefix selection is usually
left to the `configure` script of a project, but, for this simple
example, we will only add a `PREFIX=${HOME}` declaration to our
command line. While this step can sometimes be skipped, it is a good
habit to `make clean` after changing the configuration of a package.

```console
% make PREFIX="${HOME}" clean install
…
```

Note that since we have write access to the *PREFIX* directory, it is
not necessary to gain root privileges for this installation.


### Cleaning

Once we are done, we can remove object code from the object directory
with

```console
% make clean
rm -f emake1.elc emake2.elc
```
