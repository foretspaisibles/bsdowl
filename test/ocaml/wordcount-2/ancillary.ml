(* Ancillary -- Count characters and words on stdin

BSD Owl Scripts (https://bitbucket.org/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2005–2014 Michael Grünewald

This file must be used under the terms of the CeCILL-B.
This source file is licensed as described in the file COPYING, which
you should have received as part of this distribution. The terms
are also available at
http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt *)

let is_word c =
  (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')

let rec wc chan wordflag nc nw nl =
  let next =
    try Some(input_char chan)
    with End_of_file -> None
  in
  match next with
  | Some '\n' -> wc chan false (succ nc) nw (succ nl)
  | Some c -> ( match is_word c, wordflag with
    | true, true
    | false, false -> wc chan wordflag (succ nc) nw nl
    | true, false -> wc chan true (succ nc) (succ nw) nl
    | false, true -> wc chan false (succ nc) nw nl
  )
  | None -> (nc, nw, nl)
