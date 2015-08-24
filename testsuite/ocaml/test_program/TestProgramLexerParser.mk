### TestProgramLexerParser.mk -- Counting characters and lines in a file

# Author: Michael Grünewald
# Date: Sat Nov 29 08:21:58 CET 2014

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

SRCS=			basic_types.ml
SRCS+=			basic_parser.mly
SRCS+=			basic_lexer.mll
SRCS+=			wordcount.ml

.PATH:			${BSDOWLSRCDIR}/example/ocaml/minibasic

.include "TestProgram.mk"

### End of file `TestProgramLexerParser.mk'
