### TestDotfile.mk -- Test support for dotfiles

# Author: Michael Grünewald
# Date: Sun Nov 23 15:51:24 CET 2014

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

TEST_DESCRIPTION=	User configuration files
TEST_SOURCEDIR=		example/config/dotfile
TEST_SEQUENCE=		preparatives all install

test:
	test -f ${DESTDIR}${HOME}/.cshrc
	test -f ${DESTDIR}${HOME}/.Xresources

### End of file `TestDotfile.mk'
