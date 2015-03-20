### AssertMakeOS.mk -- Test for the .MAKE.OS variable

# Author: Michael Grünewald
# Date: Tue Dec  2 22:33:59 CET 2014

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

.include "bsdowl.assert.mk"

.if(!defined(.MAKE.OS)||empty(.MAKE.OS))\
	  &&(!defined(unix)||empty(unix))
.if !defined(.MAKE.OS)||empty(.MAKE.OS)
.warning .MAKE.OS: Undefined variable.
.endif
.if !defined(unix)||empty(unix)
.warning unix: Undefined variable.
.endif
.error Unknown UNIX variant.
.endif

### End of file `AssertMakeOS.mk'
