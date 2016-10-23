/* greeting.s -- Some greeting

Author: Michael Grünewald
Date: Thu Nov 20 11:59:02 CET 2014
BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.

This file must be used under the terms of the BSD license.
This source file is licensed as described in the file LICENSE, which
you should have received as part of this distribution. */

		.globl _greeting, greeting
		.data
_greeting_text: .asciz "Hello, assembly!"
_greeting:
greeting:
		.quad _greeting_text
