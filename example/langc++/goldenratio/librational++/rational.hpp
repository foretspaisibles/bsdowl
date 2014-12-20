#ifndef RATIONAL_HPP
#define RATIONAL_HPP

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

#include <iostream>


class rational
{
  enum status_t {
    SUCCESS,
    DIVISION_BY_ZERO
  };

  friend std::ostream& operator<< (std::ostream& cout, const rational& a);

 private:
  static bool trace;
  status_t status;

  int p;
  int q;

 public:
  rational(int p_ = 0, int q_ = 1):
    status(q_ == 0 ? DIVISION_BY_ZERO : SUCCESS),
    p(p_),
    q(q_)
    {};

  void print(std::ostream& cout = std::cout) const;
  void neg(const rational& a);
  void inv(const rational& a);
  void add(const rational& a, const rational& b);
  void sub(const rational& a, const rational& b);
  void mult(const rational& a, const rational& b);
  void div(const rational& a, const rational& b);

  rational operator+ (const rational& a) const;
  rational operator- (const rational& a) const;
  rational operator* (const rational& a) const;
  rational operator/ (const rational& a) const;
};

#endif
