### Elisp.mk -- Test Elisp Macros

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

TEST_DESCRIPTION=	Elisp macros
TEST_SOURCEDIR=		example/elisp

.if "${WITH_TESTSUITE_EMACS}" == "yes"
TEST_SEQUENCE=		preparatives all install
.else
TEST_SEQUENCE=		IGNORE
.endif

test:
	test -f ${DESTDIR}${datarootdir}/emacs/site-lisp/emake1.el
	test -f ${DESTDIR}${datarootdir}/emacs/site-lisp/emake2.el
	test -f ${DESTDIR}${datarootdir}/emacs/site-lisp/emake1.elc
	test -f ${DESTDIR}${datarootdir}/emacs/site-lisp/emake2.elc

### End of file `TestElisp.mk'
