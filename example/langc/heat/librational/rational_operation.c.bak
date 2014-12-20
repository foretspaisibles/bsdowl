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

#include "rational.h"
#include "rational_trace.h"

int rational_error = RATIONAL_SUCCESS;
int rational_trace = 0;

void
rational_neg(struct rational* a, const struct rational* b)
{
  rational_printf("rational_neg");
  a->p = - b->p;
  a->q = b->q;
  rational_error = RATIONAL_SUCCESS;
}

int
rational_inv(struct rational* a, const struct rational* b)
{
  rational_printf("rational_inv");
  if(b->q == 0)
  {
    rational_error = RATIONAL_DIVISION_BY_ZERO;
  }
  else
  {
    a->p = b->q;
    a->q = b->p;
    rational_error = RATIONAL_SUCCESS;
  }
  return (rational_error == RATIONAL_SUCCESS);
}

void
rational_add(struct rational* a, const struct rational* b, const struct rational* c)
{
  rational_printf("rational_add");
  a->p = (b->p)*(c->q) + (c->p)*(b->q);
  a->q = (b->q)*(c->q);
  rational_error = RATIONAL_SUCCESS;
}
void
rational_sub(struct rational* a, const struct rational* b, const struct rational* c)
{
  struct rational d;
  rational_printf("rational_sub");
  rational_neg(&d, c);
  rational_add(a, b, &d);
}

void
rational_mult(struct rational* a, const struct rational* b, const struct rational* c)
{
  rational_printf("rational_mult");
  a->p = (b->p)*(c->p);
  a->q = (b->q)*(c->q);
  rational_error = RATIONAL_SUCCESS;
}

int
rational_div(struct rational* a, const struct rational* b, const struct rational* c)
{
  rational_printf("rational_div");
  struct rational d;
  return rational_inv(&d, c) && (rational_mult(a, b, &d), 1);
}
