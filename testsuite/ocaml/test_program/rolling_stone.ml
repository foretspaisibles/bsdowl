(* rolling_stone -- How does it feel?

BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2005–2014 Michael Grünewald

This file must be used under the terms of the CeCILL-B.
This source file is licensed as described in the file COPYING, which
you should have received as part of this distribution. The terms
are also available at
http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt *)

let is_without_a_home () =
  try (Unix.getenv "HOME" |> ignore; false)
  with Not_found -> true

let how_does_it_feel () =
  if is_without_a_home () then
    "Just like a rolling stone."
  else
    "There is no place like home."

let main () =
  how_does_it_feel ()
  |> print_endline

let () = main ()
