(* Custom_bootstrap -- Bootstrap our custom toplevel

Author: Michael Grünewald
Date: Mon Dec 29 11:33:55 CET 2014

BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2005–2015 Michael Grünewald

This file must be used under the terms of the CeCILL-B.
This source file is licensed as described in the file COPYING, which
you should have received as part of this distribution. The terms
are also available at
http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt *)
let directory_list = [
  "+compiler-libs";
]

let install_printer_list = [
  [ "Custom_library"; "Thing" ];
]

let install_printer path =
  let rec loop p =
    match p with
    | [] -> invalid_arg "Custom_bootstrap.install_printer"
    | h :: [] -> Longident.Lident h
    | h :: t -> Longident.Ldot (loop t, h)
  in
  let longident = loop ("format" :: List.rev path) in
  let phrase = Parsetree.Ptop_dir(
    "install_printer", Parsetree.Pdir_ident longident
  )
  in
  ignore(Toploop.execute_phrase false Format.std_formatter phrase)

let bootstrap () =
  begin
    List.iter Topdirs.dir_directory directory_list;
    List.iter install_printer install_printer_list;
  end

let _ =
  Toploop.toplevel_startup_hook := bootstrap
