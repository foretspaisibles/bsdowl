### perl.lib.mk -- Install Perl modules

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
#  USES [not set]
#   The only supported option is perl
#
#
#  PERLVERSION [5]
#    The Perl version to install modules for
#
#
#  PERLPACKAGE [not set]
#   The name of the perl package to install
#
#   If set, this value is used as a prefix to install modules, with
#   the package separator :: replaced by a path separator /.
#
#
#  PERLLIBOWN, PERLLIBGRP, PERLLIBMODE, PERLLIBDIR, PERLLIBNAME
#   Parameters of the library installation
#
#   See `bps.files.mk` for a closer description of these variables.
#
#
# Uses:
#
#  perl: Must mention the Perl version used
#   Build for the given version of Perl


THISMODULE=		perl.lib

.if !defined(LIBRARY)||empty(LIBRARY)
.error The perl.lib.mk module expects you to set the LIBRARY variable to a sensible value.
.endif

PRODUCT=		${LIBRARY:C@\.pm$@@}
_PACKAGE_CANDIDATE=	${PRODUCT}
REPLACESUBST+=		${STDREPLACESUBST}


.include "perl.init.mk"

.if defined(LIBRARY)
PERLLIB+=			${LIBRARY}
.endif

PERLLIBMODE?=		${SHAREMODE}
PERLLIBOWN?=		${SHAREOWN}
PERLLIBGRP?=		${SHAREGRP}

FILESGROUPS+=		PERLLIB


#
# Maybe filter manual pages
#

.if defined(_SCRIPT_SED)&&!defined(MANFILTER)
MANFILTER=		${SED} ${_SCRIPT_SED}
.endif



.for product in ${PRODUCT}
_MAN_AUTO+=		${product}.3pm
_MAN_AUTO+=		${product}.8pm
.endfor

.include "bps.man.mk"
.include "bps.files.mk"
.include "bps.clean.mk"
.include "bps.usertarget.mk"

### End of file `perl.lib.mk'
