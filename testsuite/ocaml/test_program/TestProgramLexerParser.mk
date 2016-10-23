### TestProgramLexerParser.mk -- Counting characters and lines in a file

# Author: Michael Grünewald
# Date: Sat Nov 29 08:21:58 CET 2014

# BSD Owl Scripts (https://github.com/michipili/bsdowl)
# This file is part of BSD Owl Scripts
#
# Copyright © 2002–2016 Michael Grünewald. All Rights Reserved.
#
# This file must be used under the terms of the BSD license.
# This source file is licensed as described in the file LICENSE, which
# you should have received as part of this distribution.

TEST_DESCRIPTION=	OCaml lexers and parsers with ocamllex and ocamlyacc
TEST_SOURCEDIR=		example/ocaml/minibasic
TEST_SEQUENCE=		preparatives all install

test:
	test -x ${DESTDIR}${BINDIR}/minibasic

### End of file `TestProgramLexerParser.mk'
