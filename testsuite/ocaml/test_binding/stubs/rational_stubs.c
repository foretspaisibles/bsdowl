/* rational_stubs.c -- Stubs for our rational library

Author: Michael Grünewald
Date: Fri Jan  9 11:38:57 CET 2015

BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2002–2016 Michael Grünewald

This file must be used under the terms of the CeCILL-B.
This source file is licensed as described in the file COPYING, which
you should have received as part of this distribution. The terms
are also available at
http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt */

#include <stdlib.h>
#include <stdio.h>
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/custom.h>
#include <caml/fail.h>

#include "rational.h"


/* Encapsulation of opaque window handles (of type struct rational*)
   as OCaml custom blocks. */

static struct custom_operations rational_ops = {
  "com.github.michipili.rational",
  custom_finalize_default,
  custom_compare_default,
  custom_hash_default,
  custom_serialize_default,
  custom_deserialize_default
};

#define Rational_val(v) ((struct rational *) Data_custom_val(v))

/* Allocating an OCaml custom block to hold the given struct rational* */
static value
rational_make(int p, int q)
{
  CAMLparam0();
  CAMLlocal1(result);
  if(q == 0) {
    caml_raise_zero_divide();
  } else {
    result = caml_alloc_custom(&rational_ops, sizeof(struct rational), 0, 1);
    Rational_val(result)->p = p;
    Rational_val(result)->q = q;
  }
  CAMLreturn(result);
}


CAMLprim value
caml_rational_make(value p, value q)
{
  CAMLparam2(p, q);
  CAMLlocal1(result);
  result = rational_make(Int_val(p), Int_val(q));
  CAMLreturn(result);
}


CAMLprim value
caml_rational_print(value r)
{
  CAMLparam1(r);
  rational_print(Rational_val(r));
  fflush(stdout);
  CAMLreturn(Val_unit);
}


CAMLprim value
caml_rational_neg(value r)
{
  CAMLparam1(r);
  CAMLlocal1(result);
  result = rational_make(0, 1);
  rational_neg(Rational_val(result), Rational_val(r));
  CAMLreturn(result);
}


CAMLprim value
caml_rational_inv(value r)
{
  CAMLparam1(r);
  CAMLlocal1(result);
  result = rational_make(0, 1);
  if(! rational_inv(Rational_val(result), Rational_val(r))) {
    caml_raise_zero_divide();
  };
  CAMLreturn(result);
}


CAMLprim value
caml_rational_add(value a, value b)
{
  CAMLparam2(a, b);
  CAMLlocal1(result);
  result = rational_make(0, 1);
  rational_add(Rational_val(result), Rational_val(a), Rational_val(b));
  CAMLreturn(result);
}


CAMLprim value
caml_rational_sub(value a, value b)
{
  CAMLparam2(a, b);
  CAMLlocal1(result);
  result = rational_make(0, 1);
  rational_sub(Rational_val(result), Rational_val(a), Rational_val(b));
  CAMLreturn(result);
}


CAMLprim value
caml_rational_mult(value a, value b)
{
  CAMLparam2(a, b);
  CAMLlocal1(result);
  result = rational_make(0, 1);
  rational_mult(Rational_val(result), Rational_val(a), Rational_val(b));
  CAMLreturn(result);
}


CAMLprim value
caml_rational_div(value a, value b)
{
  CAMLparam2(a, b);
  CAMLlocal1(result);
  result = rational_make(0, 1);
  if(! rational_div(Rational_val(result), Rational_val(a), Rational_val(b))){
    caml_raise_zero_divide();
  };
  CAMLreturn(result);
}
