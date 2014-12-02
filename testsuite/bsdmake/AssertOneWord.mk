### AssertOneWord.mk -- Test for a reliable way to detect one word

# Author: Michael Grünewald
# Date: Tue Dec  2 22:38:18 CET 2014

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

ASSERT_EMPTY=
ASSERT_ONE=		1
ASSERT_TWO=		1 2

.if ${ASSERT_ONE:[1]} != ${ASSERT_ONE}
.error The first word of a variable with only one word\
	  should match the value of the whole variable.
.endif

.if ${ASSERT_ONE:[#]} != 1
.error The number of words in a variable with only one word\
	  should be 1.
.endif

.if ${ASSERT_TWO:[2]} == ${ASSERT_TWO}
.error The first word of a variable with two words\
	  should not match the value of the whole variable.
.endif

.if ${ASSERT_TWO:[#]} != 2
.error The number of words in a variable with two words\
	  should be 2.
.endif

.include "bsdowl.assert.mk"

### End of file `AssertMakeOS.mk'
