# BSD Owl Scripts

This collection of BSD Make directives aims at providing a highly
portable build system targetting modern UNIX systems and supporting
common or less command languages.  This is a build system, which means
that it can be used to organise fairly complex projects.

[![Build Status](https://travis-ci.org/michipili/bsdowl.svg?branch=master)](https://travis-ci.org/michipili/bsdowl?branch=master)


## Applicative level features

BSD Owl Scripts assists developers in the production, installation and
distribution of projects comprising the following types of products:

 - C programs, compiled for several targets
 - C libraries, static and shared, compiled for several targets
 - Shell scripts
 - Python scripts
 - OCaml programs
 - OCaml libraries, with **ocamldoc** documentation
 - OCaml plugins
 - TeX documents, prepared for several printing devices
 - METAPOST figures, with output as PDF, PS, SVG or PNG,
   either as part of a TeX document or as standalone documents

Each item is linked to a project example found in our extensive
testsuite.


## Build-system level features

BSD Owl Scripts offers developers a rich set of features easing
project management:

 - Support of compilation profiles
 - Support of the parallel mode (at the directory level)
 - Support of separate trees for sources and objects
 - Support of architecture-dependant compilation options
 - Support **GNU autoconf**
 - Production of GPG-signed tarballs
 - Developer subshell, empowered with project-specific scripts
 - Literate programming using **noweb**
 - Preprocessing with **m4**


## Compatibility list

It is well tested under:
 - Mac OS X, version 10.6.8 and above;
 - FreeBSD, version 9.0 and above;
 - Debian Jessie and newer.

We also want to support NetBSD and OpenBSD, as soon as they will
provide a modern version of BSD Make.

This means that projects managed with BSD Owl Scripts are easy to
develop and deploy in heterogeneous environment.


## Starting points

 - [Installation notes][start-install]
 - [Getting started with a LaTeX document][start-latex]
 - [Getting started with an OCaml program][start-ocaml]

If you are not at all familiar with makefiles you can quickly learn
the basics with de Boor's [classical tutorial][start-deboor].
It is also nice to feel confident while interacting with the shell, if
this is not the case [UNIX Power Tools][start-upt] could help you. The
[documentation index][start-index] provides an overview of the files
available in the [doc][start-doc] directory.

  [start-doc]:     ./doc
  [start-index]:   doc/Index.md
  [start-install]: INSTALL.md
  [start-latex]:   doc/GettingStartedLaTeX.md
  [start-ocaml]:   doc/GettingStartedOCaml.md
  [start-deboor]:  http://www.freebsd.org/doc/en/books/pmake/index.html
  [start-upt]:     http://docstore.mik.ua/orelly/unix/upt/


## Free software

BSD Owl Scripts is free software: copying it and redistributing it is
very much welcome under conditions of the BSD licence
agreement, found in the [LICENSE][licence-en] file of the
distribution.

  [licence-en]:  LICENSE


## Last words

This project started around 2002, it was hosted on a private CVS
server.  In 2006 it was reorganised, history was lost and it
moved to a private Subversion server.  In 2008 it was published for
the first time on GNA (gna.org).  One year later the history was
converted to git and subversion was only marginally used.  In 2013,
publication on the GNA server was abandoned and the project was
published on GitHub and BitBucket, then on GitHub only.

Pallàs Athéné is a Greek goddess of wisdom, mother of sciences and
arts.  This software is gently dedicated to her.


Michael Grünewald in Bonn, on January 20, 2014
