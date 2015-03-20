(* Application -- Count characters and words on stdin

BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2005–2014 Michael Grünewald

This file must be used under the terms of the CeCILL-B.
This source file is licensed as described in the file COPYING, which
you should have received as part of this distribution. The terms
are also available at
http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt *)

let main () =
  let (nc, nw, nl) = Ancillary.wc stdin false 0 0 1 in
  Printf.printf "%d %d %d\n" nc nw nl

let () = main ()
