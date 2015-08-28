#load "newton.cma";;
open Printf;;

let rec loop n x =
  printf "%02d %12.8f\n" n x;
  if n > 0 then
    loop (pred n) (Newton.phi_iter x)
;;

let () =
  loop 6 1.0
;;
