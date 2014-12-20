/* goldenratio -- A heat generating program computing the golden ratio

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

rational
phi(int n)
{
  int i;
  rational phi(0, 1);
  const rational one(1, 1);

  for(i = 1; i <= n; ++i) {
    phi = one / ( one + phi);
  }
  return phi;
}

int
main()
{
  using std::cout;
  using std::endl;
  const int k = 36;
  cout << "After " << k << " iterations, phi = " << phi(k) << endl;
  return 0;
}
