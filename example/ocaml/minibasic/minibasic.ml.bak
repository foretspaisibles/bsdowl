module Basic_types =
struct

type op_unr = OPPOSE | NON
type op_bin = PLUS | MOINS | MULT | DIV | MOD
             | EGAL | INF | INFEQ | SUP | SUPEQ | DIFF
             | ET | OU
type expression =
     ExpInt of int
   | ExpVar of string
   | ExpStr of string
   | ExpUnr of op_unr * expression
   | ExpBin of expression * op_bin * expression
type instruction =
     Rem of string
   | Goto of int
   | Print of expression
   | Input of string
   | If of expression * int
   | Let of string * expression
type ligne = { num : int ; inst : instruction }
type program = ligne list
type phrase =  Ligne of ligne | List | Run | End


end
