### langc.module.mk -- Take in account other modules of the project

# Author: Michael Grünewald
# Date: Fri Nov  7 14:58:12 CET 2014

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

### DESCRIPTION

.if !defined(THISMODULE)
.error langc.module.mk cannot be included directly.
.endif

.if !target(__<langc.module.mk>__)
__<langc.module.mk>__:

.for module_path in ${_MODULE_langc.prog_ARGS}
DIRS+=			${SRCDIR}/${module_path}
.endfor

.for module_path in ${_MODULE_langc.lib_ARGS}
DIRS+=			${SRCDIR}/${module_path}
LIBS+=			UnknownLibrary(${module_path})
.endfor

.endif # !target(__<langc.module.mk>__)

### End of file `langc.module.mk'
