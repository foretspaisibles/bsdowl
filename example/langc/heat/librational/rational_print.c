/* Rational numbers library

Author: Michael Grünewald
Date: Fri Nov  7 22:39:42 CET 2014
BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.

This file must be used under the terms of the BSD license.
This source file is licensed as described in the file LICENSE, which
you should have received as part of this distribution. */

#include "rational.h"
#include "rational_trace.h"

int
rational_print(const struct rational* a)
{
  rational_printf("rational_print");
  return printf("%d/%d", a->p, a->q);
}
