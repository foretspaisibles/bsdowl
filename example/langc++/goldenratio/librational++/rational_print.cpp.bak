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
#include "rational.hpp"

void
rational::print(std::ostream& cout) const
{
  if(status == SUCCESS) {
    cout << p << "/" << q;
  } else {
    cout << "DIVISION-BY-ZERO";
  }
}

std::ostream& operator<< (std::ostream& cout, const rational& a)
{
  a.print(cout);
  return cout;
}
