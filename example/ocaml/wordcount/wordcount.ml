(* Wordcount -- Count characters and words on stdin
BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.

This file must be used under the terms of the BSD license.
This source file is licensed as described in the file LICENSE, which
you should have received as part of this distribution. *)

let is_word c =
  (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z')

let rec loop chan wordflag nc nw nl =
  let next =
    try Some(input_char chan)
    with End_of_file -> None
  in
  match next with
  | Some '\n' -> loop chan false (succ nc) nw (succ nl)
  | Some c -> ( match is_word c, wordflag with
    | true, true
    | false, false -> loop chan wordflag (succ nc) nw nl
    | true, false -> loop chan true (succ nc) (succ nw) nl
    | false, true -> loop chan false (succ nc) nw nl
  )
  | None -> (nc, nw, nl)

let main () =
  let (nc, nw, nl) = loop stdin false 0 0 1 in
  Printf.printf "%d %d %d\n" nc nw nl

let () = main ()
