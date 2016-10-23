(* Newton -- Newton's method
BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.

This file must be used under the terms of the BSD license.
This source file is licensed as described in the file LICENSE, which
you should have received as part of this distribution. *)

let iter dx f x0 =
  let y = f x0 in
  let dy= (f(x0 +. dx) -. y) in
  x0 -. dx *. y /. dy

let phi_iter x0 =
  (x0 *. x0 +. 1.0) /. (2.0 *. x0 -. 1.0)
