open Printf

let rec loop iter n x =
  printf "%02d %12.8f %s\n" n x (Fibonacci.phi_string n);
  if n < iter then
    loop iter (succ n) (Newton.phi_iter x)

let () =
  loop 20 0 1.0
