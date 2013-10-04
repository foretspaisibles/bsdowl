### pallas -- Fichier de directives principal

# Author: Michael Grünewald
# Date: Dim 13 avr 2008 23:56:07 CEST
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


### SYNOPSIS

### DESCRIPTION

.if !target(__<pallas>__)
__<pallas>__:

do-publish:
	cd Website; make all install PREFIX='${HOME}' WWWBASE='${HOME}/Workshop/Pages/bsdmakepscripts'

.include "subdir.mk"
.include "../../bps/bps.project.mk"

.endif # !target(__<pallas>__)

### End of file `pallas'
