### python.lib.mk -- Install Python modules

# Author: Michael Grünewald
# Date: Sat Nov 22 11:12:21 CET 2014

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

# Variables:
#
#  LIBRARY [not set]
#   The name of the library to install
#
#
#  USES [not set]
#    Supported options are python, setuptools.
#
#
# Uses:
#
#  setuptools: No argument allowed
#   Delegate targets to Python setuptools
#
#  python: Must mention the Python version used
#   Build for the given version of Python


THISMODULE=		python.lib

.if !defined(LIBRARY)||empty(LIBRARY)
.error The python.lib.mk module expects you to set the LIBRARY variable to a sensible value.
.endif

PRODUCT=		${LIBRARY}
_PACKAGE_CANDIDATE=	${PRODUCT}

.include "python.init.mk"

.if !empty(_USES_OPTIONS:Msetuptools)
.include "python.setuptools.mk"
.else
.error "The only supported installation method is setuptools."
.endif

.for product in ${PRODUCT}
_MAN_AUTO+=		${product}.3
_MAN_AUTO+=		${product}.8
.endfor

.include "bps.man.mk"
.include "bps.files.mk"
.include "bps.clean.mk"
.include "bps.usertarget.mk"

### End of file `python.lib.mk'
