ORR
# Introducing Make

Work on Unix systems has a strong emphasis on files, and a typical work
session with such a system involves the creation of files
_(sources)_ and the invocation of many data processing
procedures _(recipes)_ yielding intermediary and final files
_(objects)_ as output of their work.  Most of the work is
usually performed through the use of a shell.

The Make program is a utility whose input is a workflow declaring
tasks (_targets_ in Make's parlance) and means to achieve them,
and whose invocation yields execution of the given tasks.

This presentation emphasizes that Make is a day-to-day companion of
the UNIX operator, as it can be used to systematize a large part of
its work. You can read more about the Make program and
especially on the FreeBSD Make program by reading the
[paragraphs dedicated to Make](http://www.freebsd.org/doc/en_US.ISO8859-1/books/developers-handbook/tools-make.html)
in the
[FreeBSD Developer's Handbook](http://www.freebsd.org/doc/en_US.ISO8859-1/books/developers-handbook/index.html),
and the
[PMake tutorial](http://www.freebsd.org/doc/en_US.ISO8859-1/books/pmake/index.html)
(the PMake program is the venerable ancestor of FreeBSD Make).


# Make scripts

Make's input is usually not a static specification of the workflow graph,
but instead a parametrized specification of the graph, it is then
possible to generalize specifications in order to manage many similar
situations with the same specification. We call these generic
specifications _Make scripts,_ it is possible to gather them in
libraries of scripts solving problems occuring in related
situations.

BSD Owl Scripts is a collection of such
libraries. They can be used to ease the development of OCaml
software, the production of TeX and LaTeX documents, and a couple of
other things.


# BSD Make

Make is not the name of a well defined program, but rather the
name of a large brotherhood. Each of the brother has its own strengths
and weaknesses, and also its own dialect used to prepare its input
specification. BSD Make Pallàs scripts can be used with three of these
brothers, all of them being descendants of the make program in
BSD4.4. These programs are:

- FreeBSD's make;
- MAC OS-X's bsdmake;
- NetBSD's bmake.

Users of Linux based system are likely to be equipped with GNU
Make. This version of Make is a piece of a larger puzzle, the
autotools; without these autotools, it is not so useful. However,
NetBSD's bmake works fine under many Linux based systems. You can get
source files for it at
[Simon J. Gerraty's](http://void.crufty.net/ftp/pub/sjg/).
