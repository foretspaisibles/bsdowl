/* greeting.s -- Some greeting

Author: Michael Grünewald
Date: Thu Nov 20 11:59:02 CET 2014

BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2005–2014 Michael Grünewald

This file must be used under the terms of the CeCILL-B.
This source file is licensed as described in the file COPYING, which
you should have received as part of this distribution. The terms
are also available at
http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt */

		.globl _greeting, greeting
		.data
_greeting_text: .asciz "Hello, assembly!"
_greeting:
greeting:
		.quad _greeting_text
