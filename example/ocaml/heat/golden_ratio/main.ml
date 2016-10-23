(* Main -- Compute golden ratio approximations
BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.

This file must be used under the terms of the BSD license.
This source file is licensed as described in the file LICENSE, which
you should have received as part of this distribution. *)
open Printf

let rec loop iter n x =
  printf "%02d %12.8f %s\n" n x (Fibonacci.phi_string n);
  if n < iter then
    loop iter (succ n) (Newton.phi_iter x)

let () =
  loop 20 0 1.0
