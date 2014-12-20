### generic.subdir.mk -- Generic aggregate

# Author: Michael Grünewald
# Date: Thu Dec  4 23:47:57 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

_MAKE_ALLSUBTARGET?=

.include "bps.init.mk"
.include "bps.credentials.mk"
.include "bps.subdir.mk"
.include "bps.clean.mk"

_SUBDIR_TARGET?=	obj depend build doc install clean distclean realclean test

obj: do-obj-subdir

.unexport SRCDIR
.unexport WRKDIR
.unexport PACKAGE
.unexport PACKAGEDIR
.unexport VERSION
.unexport OFFICER
.unexport MODULE
.unexport EXTERNAL

### End of file `generic.subdir.mk'
