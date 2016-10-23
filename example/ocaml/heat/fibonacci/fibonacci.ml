(* Fibonacci -- Compute Fibonacci numbers
BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.

This file must be used under the terms of the BSD license.
This source file is licensed as described in the file LICENSE, which
you should have received as part of this distribution. *)
open Num

let rec fibo_num n =
  match n with
  | 0 -> Int 1
  | 1 -> Int 1
  | n -> add_num (fibo_num (n-1)) (fibo_num(n-2))

let calc n =
  if n < 0 then
    invalid_arg "Fibonacci.calc"
  else
    fibo_num n

let phi_string n =
  let p, q = calc (n+1), calc n in
  let phi = div_num p q in
  approx_num_fix 8 phi
