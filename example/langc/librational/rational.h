#ifndef RATIONAL_H
#define RATIONAL_H

/* Rational numbers library

Author: Michael Grünewald
Date: Fri Nov  7 22:39:42 CET 2014
BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.

This file must be used under the terms of the BSD license.
This source file is licensed as described in the file LICENSE, which
you should have received as part of this distribution. */

extern int rational_error;
extern int rational_trace;

#define	RATIONAL_SUCCESS		0
#define	RATIONAL_DIVISION_BY_ZERO	1

struct rational {
  int p;
  int q;
};

int rational_print(const struct rational*);
void rational_neg(struct rational*, const struct rational*);
int rational_inv(struct rational*, const struct rational*);
void rational_add(struct rational*, const struct rational*, const struct rational*);
void rational_sub(struct rational*, const struct rational*, const struct rational*);
void rational_mult(struct rational*, const struct rational*, const struct rational*);
int rational_div(struct rational*, const struct rational*, const struct rational*);
#endif
