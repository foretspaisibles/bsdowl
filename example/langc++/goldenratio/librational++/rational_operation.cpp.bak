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

#include "rational.hpp"

void
rational::neg(const rational& a)
{
  if(a.status == SUCCESS) {
    p = - a.p;
    q = a.q;
  }
  status = a.status;
}

void
rational::inv(const rational& a)
{
  if(a.p == 0 || a.status == DIVISION_BY_ZERO)
  {
    status = DIVISION_BY_ZERO;
  }
  else
  {
    (*this) = rational(a.q, a.p);
    status = SUCCESS;
  }
}

void
rational::add(const rational& a, const rational& b)
{
  if(a.status == SUCCESS && b.status == SUCCESS) {
    (*this) = rational(a.p * b.q + b.p * a.q, a.q * b.q);
    status = SUCCESS;
  } else {
    status = DIVISION_BY_ZERO;
  }
}

void
rational::sub(const rational& a, const rational& b)
{
  rational c;
  c.neg(b);
  add(a, c);
}

void
rational::mult(const rational& a, const rational& b)
{
  if(a.status == SUCCESS && b.status == SUCCESS) {
    p = a.p * b.p;
    q = a.q * b.q;
    status = SUCCESS;
  } else {
    status = DIVISION_BY_ZERO;
  }
}

void
rational::div(const rational& a, const rational& b)
{
  rational c;
  c.inv(b);
  mult(a, c);
}

rational
rational::operator+(const rational& a) const
{
  rational c;
  c.add(*this, a);
  return c;
}

rational
rational::operator-(const rational& a) const
{
  rational c;
  c.sub(*this, a);
  return c;
}

rational
rational::operator*(const rational& a) const
{
  rational c;
  c.mult(*this, a);
  return c;
}

rational
rational::operator/(const rational& a) const
{
  rational c;
  c.div(*this, a);
  return c;
}
