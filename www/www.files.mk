### www.files.mk -- A bps.files.mk wrapper for my www

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.


### DESCRIPTION

.if !defined(THISMODULE)
THISMODULE=		www.files
.endif

.if !defined(WWW)||empty(WWW)
.error The www.files.mk module expects you to set the WWW\
	  variable to a list of files to install.
.endif

_PACKAGE_CANDIDATE=	${FILES}
PRODUCT=		${FILES}

.if !empty(DOC)
PRODUCT+=		${DOC}
.endif

FILESGROUPS+=		WWW

.if !defined(WWWDIR) && (!defined(SUBDIR) || empty(SUBDIR))
.error Proper use needs one of the variables WWWDIR or SUBDIR to have a value
.endif

.if defined(WWWBASE)&&!empty(WWWBASE)
.export WWWBASE
.endif

.include "bps.init.mk"
.include "bps.man.mk"
.include "bps.files.mk"
.include "bps.clean.mk"
.include "bps.usertarget.mk"

### End of file `www.files.mk'
