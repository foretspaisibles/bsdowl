### AssertMakeOS.mk -- Test for the .MAKE.OS variable

# Author: Michael Grünewald
# Date: Tue Dec  2 22:33:59 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

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
