type t

external make : int -> int -> t = "caml_rational_make"
external print : t -> unit = "caml_rational_print"
external numerator : t -> int = "caml_rational_numerator"
external denominator : t -> int = "caml_rational_denominator"
external neg : t -> t = "caml_rational_neg"
external add : t -> t -> t = "caml_rational_add"
external sub : t -> t -> t = "caml_rational_sub"
external mult : t -> t -> t = "caml_rational_mult"
external div : t -> t -> t = "caml_rational_div"
