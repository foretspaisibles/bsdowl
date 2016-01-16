/* Rational numbers library

Author: Michael Grünewald
Date: Fri Nov  7 22:39:42 CET 2014

BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2002–2016 Michael Grünewald

This file must be used under the terms of the CeCILL-B.
This source file is licensed as described in the file COPYING, which
you should have received as part of this distribution. The terms
are also available at
http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt */

#include <stdarg.h>
#include <stdio.h>
#include "rational.h"
#include "rational_trace.h"

int
rational_printf(const char *format, ...)
{
  int status = 0;
  va_list args;
  if(rational_trace)
  {
    va_start(args, format);
    status = printf("Trace: rational: ");
    status+= vprintf(format, args);
    va_end(args);
  }
  return status;
}
