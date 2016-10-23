/* greeting_stub.c -- OCaml stubs to greet people

Author: Michael Grünewald
Date: Sat Jan  3 16:25:15 CET 2015
BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.

This file must be used under the terms of the BSD license.
This source file is licensed as described in the file LICENSE, which
you should have received as part of this distribution. */

#include <stdlib.h>
#include <stdio.h>
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/custom.h>

value hello_world(value unit)
{
  CAMLparam1 (unit);
  printf("Hello, world!\n");
  CAMLreturn (Val_unit);
}
