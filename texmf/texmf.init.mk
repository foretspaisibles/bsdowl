### texmf.init.mk -- Service d'initialisation

# Author: Michael Grünewald
# Date: Dim  4 oct 2009 11:59:26 CEST
# Cookie: SYNOPSIS TARGET VARIABLE EN DOCUMENTATION

# BSDMake Pallàs Scripts (http://home.gna.org/bsdmakepscripts/)
# This file is part of BSDMake Pallàs Scripts
#
# Copyright (C) 2006-2009, 2013 Michael Grünewald
#
# This file must be used under the terms of the CeCILL-B.
# This source file is licensed as described in the file COPYING, which
# you should have received as part of this distribution. The terms
# are also available at
# http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt

.if !target(__<texmf.init.mk>__)
__<texmf.init.mk>__:

TEXMFDIR?= ${PREFIX}/share/texmf
WEB2CDIR?= ${TEXMFDIR}/web2c

.endif #!target(__<texmf.init.mk>__)

### End of file `texmf.init.mk'
