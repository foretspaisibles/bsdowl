open Printf

let init () =
  printf "The Enterprise\n"

let parse_line = Basic_parser.line Basic_lexer.lexer
