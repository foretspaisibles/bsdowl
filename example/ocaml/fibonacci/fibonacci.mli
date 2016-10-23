(* Fibonacci -- Compute Fibonacci numbers
BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.

This file must be used under the terms of the BSD license.
This source file is licensed as described in the file LICENSE, which
you should have received as part of this distribution. *)

(** Compute Fibonacci numbers.

The 0-th and 1-st Fibonacci numbers [F_0] and [F_1] are 1, and then [F_n+2
= F_n + F_n+1]. *)
val calc : int -> Num.num

val phi_string : int -> string
