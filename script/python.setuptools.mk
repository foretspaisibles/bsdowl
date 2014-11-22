### python.setuptools.mk -- Use setuptools to install libraries

# Author: Michael Grünewald
# Date: Sat Nov 22 12:29:33 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2005–2014 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

.warning It seems impossible to refrain setuptools from spamming our\
	  source directory with its temporary products and directories.  As\
	  such, support of setuptools is experimental only.


.if !defined(THISMODULE)
.error python.setuptools.mk cannot be included directly.
.endif

.if !target(__<python.setuptools.mk>__)
__<python.setuptools.mk>__:

.if !exists(setup.py)
.error Cannot read file setup.py.
.endif

.if ${LIBRARY:[#]} != 1
.error The LIBRARY variable must mention exactly one library name.
.endif

SETUPTOOL?=		python

_PYTHON_install_FLAGS+=	--prefix ${prefix}
_PYTHON_install_FLAGS+=	--exec-prefix ${exec_prefix}

.if defined(DESTDIR)
_PYTHON_install_FLAGS+=	--root ${DESTDIR}
.endif

.if "${.OBJDIR}" != "${.CURDIR}"
_PYTHON_build_FLAGS+=	-b ${.OBJDIR}
.endif

.for target in depend configure doc benchmark
do-${target}:
	${NOP}
.endfor

do-build: setup.py
	cd ${.CURDIR} && ${SETUPTOOL} ${.ALLSRC:M*setup.py}\
	  build ${_PYTHON_build_FLAGS}

do-install: setup.py
	cd ${.CURDIR} && ${SETUPTOOL} ${.ALLSRC:M*setup.py}\
	  build ${_PYTHON_build_FLAGS}\
	  install ${_PYTHON_install_FLAGS}

do-test: setup.py
	cd ${.CURDIR} && ${SETUPTOOL} ${.ALLSRC:M*setup.py}\
	  build ${_PYTHON_build_FLAGS}\
	  test ${_PYTHON_test_FLAGS}

CLEANDIRS+=		${.CURDIR}/build
CLEANDIRS+=		${.CURDIR}/${LIBRARY}.egg-info

.endif # !target(__<python.setuptools.mk>__)

### End of file `python.setuptools.mk'
