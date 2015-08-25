(* Main -- A mini basic interpreter

BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2005–2014 Michael Grünewald

This file must be used under the terms of the CeCILL-B.
This source file is licensed as described in the file COPYING, which
you should have received as part of this distribution. The terms
are also available at
http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt *)
open Minibasic.Basic_types

module Binding =
  Map.Make(String)

module Program =
  Map.Make(struct type t = int let compare = Pervasives.compare end)

type env = {
  env_binding: expression Binding.t;
  env_program: ligne Program.t;
}

let rec eval_phrase env = function
  | Ligne ({ num; inst } as ligne) ->
      { env with env_program = Program.add num ligne env.env_program }
  | List -> failwith "Not implemented"
  | Run -> failwith "Not implemented"
  | End -> exit 0

let () =
  failwith "Not implemented"
