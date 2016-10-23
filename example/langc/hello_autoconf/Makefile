### Makefile -- The obnoxious hello world program

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

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
