### Makefile -- Test OCaml support

# Author: Michael Grünewald
# Date: Fri Oct  4 20:54:55 CEST 2013

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) 2013 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

SUBDIR=		wordcount-1
SUBDIR+=	wordcount-2
SUBDIR+=	fibonacci
SUBDIR+=	newton
SUBDIR+=	newton-doc
SUBDIR+=	toplevel
SUBDIR+=	basic-1
SUBDIR+=	basic-2
SUBDIR+=	ocamlfind
SUBDIR+=	golden-ratio

test-clean:
	${MAKE} realclean

test-base:
	${MAKE} all
	${MAKE} realclean

test-doc:
	${MAKE} doc
	${MAKE} realclean

test-parallel:
	${MAKE} depend
	${MAKE} -j4 build

test-objdir:
	${INSTALL_DIR} ${.CURDIR}/objdir
	${ENVTOOL} MAKEOBJDIRPREFIX=${.CURDIR}/objdir ${MAKE}
	test -r ${.CURDIR}/objdir/${.CURDIR}/basic-1/.depend
	test -r ${.CURDIR}/objdir/${.CURDIR}/basic-1/basic_lexer.ml
	test -r ${.CURDIR}/objdir/${.CURDIR}/basic-1/basic_parser.ml
	test -r ${.CURDIR}/objdir/${.CURDIR}/basic-1/basic_parser.mli
	test -x ${.CURDIR}/objdir/${.CURDIR}/golden-ratio/golden-ratio

CLEANDIRS+= ${.CURDIR}/objdir

test: test-clean
test: test-base
test: test-doc
test: test-parallel
test: test-objdir

.include "bps.subdir.mk"

### End of file `Makefile'
