(* Newton -- Newton's method

BSD Owl Scripts (https://github.com/michipili/bsdowl)
This file is part of BSD Owl Scripts

Copyright © 2002–2016 Michael Grünewald

This file must be used under the terms of the CeCILL-B.
This source file is licensed as described in the file COPYING, which
you should have received as part of this distribution. The terms
are also available at
http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt *)

(** Newton's method. *)

val iter : float -> (float -> float) -> float -> float
(** [iter dx f x0] is the Newton iterate obtained by applying one time
Newton's method to [f] and [x0], using the infinitesimal [dx].

It assumes the function [f] is defined for every real number. *)

val phi_iter : float -> float
(** [phi_iter x0] is the Newton iterate following [x0] and converging
the golden ratio [phi]. *)
