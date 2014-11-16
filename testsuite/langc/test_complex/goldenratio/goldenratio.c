/* goldenratio -- A heat generating program computing the golden ratio

Author: Michael Grünewald
Date: Sat Nov 15 15:56:19 CET 2014

BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2005–2014 Michael Grünewald

This file must be used under the terms of the CeCILL-B.
This source file is licensed as described in the file COPYING, which
you should have received as part of this distribution. The terms
are also available at
http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt */

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

#include "rational.h"
#include "fibonacci.h"

void
goldenratio_rational(int n)
{
  int i;
  struct rational phi = { 0, 1 };
  for(i = 1; i <= n; ++i) {
    phi.q = phi.p + phi.q;
    phi.p = phi.q - phi.p;
  }
  rational_print(&phi);
  putchar('\n');
}

void
goldenratio_fibonacci(int n)
{
  struct rational phi = { 0, 1 };
  phi.p = fibonacci(n-1);
  phi.q = fibonacci(n);
  rational_print(&phi);
  putchar('\n');
}

#define	MODE_RATIONAL	0
#define	MODE_FIBONACCI	1

int
main(int argc, char * const *argv)
{
  int opt;
  int mode = MODE_RATIONAL;
  int rank = -1;
  while((opt = getopt(argc, argv, "rfn:")) != -1) {
    switch(opt) {
    case 'r':
      mode = MODE_RATIONAL;
      break;
    case 'f':
      mode = MODE_FIBONACCI;
      break;
    case 'n':
      rank = atoi(optarg);
      if(rank < 0) {
	exit(64);
      }
      break;
    default:
      exit(64);
      break;
    }
  }
  switch(mode){
  case MODE_RATIONAL:
    goldenratio_rational(rank);
    break;
  case MODE_FIBONACCI:
    goldenratio_fibonacci(rank);
    break;
  default:
    exit(70);
  }
  return EXIT_SUCCESS;
}
