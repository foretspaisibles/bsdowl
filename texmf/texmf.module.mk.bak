### texmf.module.mk -- Take in account other modules in the project

# Author: Michael Grünewald
# Date: Mon Nov 24 14:01:15 CET 2014

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

.if !defined(THISMODULE)
.error texmf.module.mk cannot be included directly.
.endif

.if !target(__<texmf.module.mk>__)
__<texmf.module.mk>__:

.for module_name in mpost.files mpost.doc\
	  tex.files tex.doc latex.files latex.doc
.for path in MPINPUTS TEXINPUTS

.for module_path in ${_MODULE_${module_name}_ARGS}
.if empty(${module_path}:M${SRCDIR}/${module_path})
${path}+=		${SRCDIR}/${module_path}
.endif
.if empty(${module_path}:M${WRKDIR}/${module_path})
${path}+=		${WRKDIR}/${module_path}
.endif
.endfor

.endfor
.endfor

.endif # !target(__<texmf.module.mk>__)

### End of file `texmf.module.mk'
