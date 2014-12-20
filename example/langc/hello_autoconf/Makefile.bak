### Makefile -- The obnoxious hello world program

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

PROGRAM=		hello_world

SRCS=			hello_config.c
SRCS+=			hello_world.c


# The configure script will not fully expand variables in files
# processed by AC_CONFIG_FILES, this is why rely on the generic
# replacement mechanism provided by `bps.replace.mk' to perform this
# replacement.

REPLACESUBST=		${STDREPLACESUBST}
REPLACEFILE+=		hello_config.c.in


# The configure script will produce a `Makefile.config' file
# containing configured variables.  This file should be removed as
# part of the `realclean' target, which is accomplished by the
# following statement.

CONFIGURE=		Makefile.config.in


.include "langc.prog.mk"

### End of file `Makefile'
