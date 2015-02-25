[![Stories in Ready](https://badge.waffle.io/michipili/bsdowl.png?label=ready&title=Ready)](https://waffle.io/michipili/bsdowl)
# BSD Owl Scripts

This collection of BSD Make directives aims at providing a highly
portable build system targetting modern UNIX systems and supporting
common or less command languages.

It can already be used to:
- Preparation and publication of TeX documents;
- Development of TeX macros with NOWEB;
- Development of OCaml software;
- Maintainance of a FreeBSD workstation configuration files;
- Preparation of a static website with ONSGMLS.

It is well tested under:
- Mac OS X, version 10.6.8 and above
- FreeBSD, version 9.0 and above
- Debian Jessie and newer

It is hoped to function well under several other operating systems
such as NetBSD, OpenBSD and other Linuces. See our
[compatibility list][wiki/Compatibility] on the wiki.

This README contains enough information to get you started. You
will find more details on the [wiki][wiki].

The _Highlights_ section emphasizes important features of BSD Make
Pallàs Scripts.  The _Installation_ details the installation procedure
using the sources.  Finally the _First Steps_ demonstrate the use of BSD
Make Pallàs Scripts to prepare TeX documents and OCaml programs.

If you are not at all familiar with makefiles you can quickly learn
the basics with de Boor's
[classical tutorial][4].
It is also nice to feel confident while interacting with the shell, if
this is not the case
[UNIX Power Tools][5]
could help you.


# Highlights

## Compatibility

We aim at providing a highly portable build system targetting modern
UNIX systems.  It is already well tested under:
- Mac OS X, version 10.6.8 and above
- FreeBSD, version 9.0 and above
- Debian Jessie and newer

It is hoped to function well under several other operating systems
such as NetBSD, OpenBSD or even Cygwin. See our
[compatibility list][wiki/Compatibility] on the wiki.

This means that projects managed with BSD Owl Scripts are easy to
develop and deploy in heterogeneous environment.


## Advanced features

Here is a short list of advanced features that will make you love
using BSD Owl Scripts for your papers written with TeX:

- Support TeX documents split in multiple directories;
- Support figure generation with METAPOST;
- Support bibtex bibliographies;
- Smart clean targets easing publication.

And for OCaml projects, this list is:

- Support parallel mode (at the directory level);
- Support separate trees for sources and objects;
- Support native and byte code;
- Smart dependencies handling avoiding “inconsistant assumptions” over
  interfaces.


## Free software

BSD Owl Scripts is free software: copying it and
redistributing it is very much welcome under conditions of the
[CeCILL-B][1] licence agreement, found in the [COPYING][2]
and [COPYING-FR][3] files
of the distribution.


# Installation

## Requirements

BSD Owl Scripts works at least in the following
environments:

- FreeBSD 9.0 and the base system program `make`;
- Mac OS X 10.5 and the base system program `bsdmake`;
- Mac OS X 10.4 and the base system program `bsdmake`;
- Debian 7.0 and the third-party program `bmake`.

Some special features require extra software being installed on the
system where BSD Owl Scripts is used.  This is advertised in
the corresponding documentation.


## Site-wide installation procedure

First of all, acquire the latest tarball `bsdowl-2.0.tar.bz2`
and its signature `bsdowl-2.0.tar.bz2.sig` that you should
verify—alternatively, download the tip of the
[development branch][branch/master]
Point a root shell to the directory containing the tarball:

    # tar xjf bsdowl-2.0.tar.bz2
    # cd bsdowl-2.0

You now have to choose an installation prefix, say `/usr/local`, where
the directives and a few helper scripts are installed:

    # ./configure --prefix=/usr/local
    # make -r all
    # make -r install

To let BSD Make know about bsdowl, you then need to
ensure that `/usr/local/bin` is listed in the path for each system
user and that `/usr/local/share/mk` is listed in the search path
for your compatible make program, this is usually done by adding the
line

    .MAKEFLAGS: -I /usr/local/share/mk

To the file `/etc/make.conf`.


## User-specific installation procedure

First of all, acquire the latest tarball `bsdowl-2.0.tar.bz2`
and its signature `bsdowl-2.0.tar.bz2.sig` that you should
verify—alternatively, download the tip of the
[development branch][branch/master]
Point a user shell to the directory containing the tarball:

    $ tar xjf bsdowl-2.0.tar.bz2
    $ cd bsdowl-2.0
    $ ./configure --prefix=${HOME}
    $ env MAKEFLAGS= make -r all
    $ env MAKEFLAGS= make -r install

To let BSD Make know about bsdowl, you then need to
ensure that `${HOME}/bin` is listed in your path and that the
`MAKEFLAGS` variable contains `-I ${HOME}/share/mk`.  If you
are using `bash` or `sh` you can achieve this by appending the lines

    PATH="${HOME}/bin:${PATH}"
    MAKEFLAGS="${MAKEFLAGS}${MAKEFLAGS:+ }-I ${HOME}/share/mk"
    export PATH
    export MAKEFLAGS

to your `~/.profile` or `~/.bashrc` file, depending on your
configuration.  If you are using tcsh you can achieve this by
appending the following lines

    set -f path = ( $path $HOME/bin )

    if ( $?MAKEFLAGS ) then
        set makeflags = ( $MAKEFLAGS )
    else
        set makeflags = ()
    endif

    set makeflags = ( $makeflags "-I ${HOME}/share/mk" )
    setenv MAKEFLAGS   "$makeflags"
    unset makeflags

to your `~/.cshrc` or `~/.tcshrc`, depending on your configuration.
These two suggestions will work in typical cases but some special
configuration will require arrangements.


# First steps

## Getting started with a LaTeX document

Here is how BSD Owl Scripts can help you to write your new
article.  First of all, create a directory to hold your files and put
your first version of your TeX source there.  We assume for this
example that you called it `mylastarticle.tex`. Along your file,
create a `Makefile` with the following contents:

    DOCS=       mylastarticle.tex
    TEXDEVICE=  pdf
    .include "latex.doc.mk"

Then you can `make` your document and `make clean` it.  The line
setting `TEXDEVICE` tells BSD Owl Scripts that you want to
actually use `pdflatex` but if you are happy with DVI output you can
leave this line aside.  If your document requires a bibliography
prepared by `bibtex` just set `USE_BIBTEX` to `yes` as in

    DOCS=       mylastarticle.tex
    USE_BIBTEX= yes
    TEXDEVICE=  pdf
    .include "latex.doc.mk"

This will automatically process your bibliography database with
`bibtex`.  If your bibliography database does not lie in the same
directory as your article, you should tell BSD Owl Scripts its
location:

    DOCS=       mylastarticle.tex
    USE_BIBTEX= yes
    BIBINPUTS=  ${HOME}/share/texmf/bib
    TEXDEVICE=  pdf
    .include "latex.doc.mk"

Note that `make clean` will not remove the compiled bibliography, so
that you can `clean` your directory before sending it to an editor or
the arXiv.  To get rid of the compiled bibliography, use the more
powerful `make realclean` mantra.

BSD Owl Scripts can also take care of your METAPOST figures,
If you use the `grahicx` package in LaTeX, all you need to do is to
list your metapost source files in the `FIGS` variable:

    DOCS=       mylastarticle.tex
    FIGS=       desargues.mp
    FIGS+=      conics.mp
    TEXDEVICE=  pdf
    .include "latex.doc.mk"

and METAPOST wil be called automatically the next time you `make` your
document.  Please be sure to set

    outputtemplate := "%j-%c.mps";

in your METAPOST sources.  As for bibliographies, making `clean` will
not remove your pictures but making `realclean` will.


## Getting started with an OCaml program

Here is how BSD Owl Scripts can help you to compile a simple
OCaml program `wordcount`, your own implementation of the UNIX `wc(1)`
utility.

We first assume that the source code is a single file `wordcount.ml`
and then consider a more complex case.


### The first time

Create a directory to hold your files and put your source there.
Along the source, create a `Makefile` with the following content:

    PROGRAM=    wordcount
    .include "ocaml.prog.mk"

### Building

You can now `make` your program and produce a `wordcount` binary.  The
complete output of the make process looks like this:

    $ make
    make depend
    ocamldep  wordcount.ml > .depend
    make build
    ocamlc -c -o wordcount.cmo wordcount.ml
    ocamlc -o wordcount.cb wordcount.cmo
    cp wordcount.cb wordcount
    make doc

When you call `make` without argument it is the same thing as
`make all` which decomposes as `make depend` and `make build` as you
see.  You can test your program, edit it and re-`make` it.


### Installing

Once you are satisfied with the results, you can install it with `make
install`.  It will call `su` to gain root privileges and install your
program under `/usr/local/bin` a value deduced from *PREFIX*

    $ make install
    ===> Switching to root credentials for target (install)
    Password:
    /usr/bin/install -c -d /usr/local/bin
    install -o root -g wheel -m 555 wordcount /usr/local/bin

You can check the value of the *PREFIX* variable, or any other
variable, with `make -V` as in

    $ make -V PREFIX
    /usr/local

If you want to install your program to another location like
`${HOME}/bin` you only need to change the *PREFIX*.  You can make the
change permanent by adding a `PREFIX=${HOME}` line to your `Makefile`:

    PROGRAM=    wordcount
    PREFIX=     ${HOME}
    .include "ocaml.prog.mk"

The order of variable declarations is not important but they have to
come before the `.include` line.  It is also possible to use
`PREFIX=${HOME}` just once by adding it on the command line without
editing the `Makefile`:

    make PREFIX=${HOME} install
    /usr/bin/install -c -d /home/michael/bin
    install -o michael -g michael -m 550 wordcount /home/michael/bin

Note that since you have write access to the *PREFIX* directory, it is
not necessary to gain root privileges for this installation.


### Cleaning

Last you can remove object code from the directory with

    $ make clean
    rm -f  wordcount.cmo wordcount.cmi wordcount.cb wordcount

If you look closely, you will notice that the `.depend` file is not
removed:

    $ ls -A
    .depend      Makefile     wordcount.ml

This is on purpose, and if you also want to get rid of the `.depend`
file you can use the more powerful mantra

    $ make realclean
    rm -f  wordcount.cmo wordcount.cmi wordcount.cb wordcount
    rm -f  .depend


### Several files and auxilary libraries

As a consequence _Zawinski's Law of Software Envelopment_ you decided
to build a mail reader in your `wordcount` program.  Your code source
now consists of your main file `wordcount.ml` a library
`mailreader.ml` relying on the `unix.cma` library.  Here is the
corresponding `Makefile`:


    PROGRAM=    wordcount
    SRCS+=      mailreader.ml
    SRCS+=      wordcount.ml
    LIBS+=      unix
    .include "ocaml.prog.mk"

While dependencies between modules are computed with `ocamldep` so
that modules are compiled as needed, the order in which the files are
listed in *SRCS* is used by the linker.  It is thus important to list
files in an order suited to the linking phase.


### Features highlight

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


## Last words

This project started around 2002, it was hosted on a private CVS
server.  In 2006 it was reorganised, history was lost and it
moved to a private Subversion server.  In 2008 it was published for
the first time on GNA (gna.org).  One year later the history was
converted to git and subversion was only marginally used.  In 2013,
publication on the GNA server was abandoned and the project was
published on GitHub and BitBucket.

Pallàs Athéné is a Greek goddess of wisdom, mother of sciences and
arts.  This software is gently dedicated to her.


Michael Grünewald in Bonn, on January 20, 2014

   [1]: http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.html
   [2]: COPYING
   [3]: COPYING-FR
   [4]: http://www.freebsd.org/doc/en/books/pmake/index.html
   [5]: http://docstore.mik.ua/orelly/unix/upt/

   [wiki]: https://github.com/michipili/bsdowl/wiki
   [wiki/Compatibility]: https://github.com/michipili/bsdowl/wiki/Compatibility

   [branch/master]: https://github.com/michipili/bsdowl/tree/master
