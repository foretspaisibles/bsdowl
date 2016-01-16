(* Main -- Compute golden ratio approximations

BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2002–2016 Michael Grünewald

This file must be used under the terms of the CeCILL-B.
This source file is licensed as described in the file COPYING, which
you should have received as part of this distribution. The terms
are also available at
http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt *)
open Printf

let rec loop iter n x =
  printf "%02d %12.8f %s\n" n x (Fibonacci.phi_string n);
  if n < iter then
    loop iter (succ n) (Newton.phi_iter x)

let () =
  loop 20 0 1.0
