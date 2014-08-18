### Makefile -- Test OCaml support

# Author: Michael Grünewald
# Date: Fri Oct  4 20:54:55 CEST 2013

# BSD Owl Scripts (https://bitbucket.org/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2005–2014 Michael Grünewald
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
SUBDIR+=	basic-3
SUBDIR+=	basic-4
SUBDIR+=	ocamlfind
SUBDIR+=	golden_ratio
SUBDIR+=	miniproj-1
SUBDIR+=	miniproj-2
SUBDIR+=	miniproj-3

#
# Test setup
#

COMPILE?=	byte_code

TESTENV=	${ENVTOOL} -i "PATH=${PATH}" "COMPILE=${COMPILE}"
TESTENV+=	"MAKEFLAGS=${MAKEFLAGS:NPACKAGE*:NPROJECT*}"

test-clean:
	${TESTENV} ${MAKE} realclean

test-base:
	${TESTENV} ${MAKE} all
	${TESTENV} ${MAKE} realclean

test-doc:
	${TESTENV} ${MAKE} doc
	${TESTENV} ${MAKE} realclean

test-parallel:
	${TESTENV} ${MAKE} depend
	${TESTENV} ${MAKE} -j4 build
	${TESTENV} ${MAKE} realclean

test-objdir:
	${INSTALL_DIR} ${.CURDIR}/objdir
	${TESTENV} MAKEOBJDIRPREFIX=${.CURDIR}/objdir ${MAKE}
	test -r ${.CURDIR}/objdir/${.CURDIR}/basic-1/.depend
	test -r ${.CURDIR}/objdir/${.CURDIR}/basic-1/basic_lexer.ml
	test -r ${.CURDIR}/objdir/${.CURDIR}/basic-1/basic_parser.ml
	test -r ${.CURDIR}/objdir/${.CURDIR}/basic-1/basic_parser.mli
	test -x ${.CURDIR}/objdir/${.CURDIR}/golden_ratio/golden_ratio

test-compile:
	${TESTENV} COMPILE="byte_code" ${MAKE} test
	${TESTENV} COMPILE="native_code" ${MAKE} test
	${TESTENV} COMPILE="both" ${MAKE} test

CLEANDIRS+= ${.CURDIR}/objdir

test: test-clean
test: test-base
test: test-doc
test: test-parallel
test: test-objdir

.include "bps.subdir.mk"

### End of file `Makefile'
