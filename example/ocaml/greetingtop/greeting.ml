(* Greeting -- Say hello

Author: Michael Grünewald
Date: Sat Jan  3 16:31:02 CET 2015
BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2002–2017 Michael Grünewald. All Rights Reserved.

This file must be used under the terms of the BSD license.
This source file is licensed as described in the file LICENSE, which
you should have received as part of this distribution. *)

external hello_world : unit -> unit = "hello_world"

let () = hello_world ()
