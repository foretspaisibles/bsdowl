/* Fibonacci numbers library

Author: Michael Grünewald
Date: Fri Nov  7 22:39:42 CET 2014

BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2005–2014 Michael Grünewald

This file must be used under the terms of the CeCILL-B.
This source file is licensed as described in the file COPYING, which
you should have received as part of this distribution. The terms
are also available at
http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt */

#include "fibonacci.h"

int
fibonacci(int n)
{
  if(n < 0) {
    return 0;
  } else if(n == 0 || n == 1) {
    return 1;
  } else {
    return fibonacci(n-1) + fibonacci(n-2);
  }
}
