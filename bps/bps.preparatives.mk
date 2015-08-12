### bps.preparatives.mk -- Preparatives

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


### SYNOPSIS

# .include "bps.preparatives.mk"


# Variables:
#
#  USE_OBJDIR [set by initialisation strategy]
#    Flag used to determine if object directories need to be built.
#
#  USE_AUTOCONF [set by initialisation strategy]
#    Flag used to determine if configure needs to be run.

# Targets:
#
#  pre-preparatives, do-preparatives, post-preparatives:
#    Steps of the preparatives targets
#
#  preparatives:
#    Prepare the build system, optionally running configure and
#    preparing object directories.

### IMPLEMENTATION

.if !target(__<bps.preparatives.mk>__)
__<bps.preparatives.mk>__:

.if "${USE_AUTOCONF}" == "yes"
do-preparatives:	configure
.endif

.if target(do-runconfigure)||target(runconfigure)
do-preparatives:	runconfigure
.endif

.if "${USE_OBJDIR}" == "yes"
do-preparatives:	obj
.endif

.endif # !target(__<bps.preparatives.mk>__)

### End of file `bps.init.mk'
