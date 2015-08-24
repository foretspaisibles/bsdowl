(* Custom_library -- Our custom library

Author: Michael Grünewald
Date: Sat Jan  3 15:00:00 CET 2015

BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2005–2015 Michael Grünewald

This file must be used under the terms of the CeCILL-B.
This source file is licensed as described in the file COPYING, which
you should have received as part of this distribution. The terms
are also available at
http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt *)
module Thing : sig
  type t
  val make : unit -> t
  val format : Format.formatter -> t -> unit
end = struct
  type t = unit
  let make () = ()
  let format ppt () =
    Format.pp_print_string ppt "Something strange"
end
