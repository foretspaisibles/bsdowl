(* Main -- Test rational numbers

BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2002–2016 Michael Grünewald

This file must be used under the terms of the CeCILL-B.
This source file is licensed as described in the file COPYING, which
you should have received as part of this distribution. The terms
are also available at
http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt *)

let main () =
  let a = Rational.make 14 2 in
  let b = Rational.make 6 1 in
  Rational.print (Rational.mult a b);
  print_endline ""

let () = main ()
