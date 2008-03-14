{
 open Basic_parser ;;

 let string_chars s = String.sub s 1 ((String.length s)-2) ;;
}

rule lexer = parse
   [' ' '\t']            { lexer lexbuf }

 | '\n'                  { Leol }

 | '!'                   { Lneg }
 | '&'                   { Land }
 | '|'                   { Lor }
 | '='                         { Legal }
 | '%'                         { Lmod }
 | '+'                         { Lplus }
 | '-'                         { Lmoins }
 | '*'                         { Lmult }
 | '/'                         { Ldiv }

 | ['<' '>']             { Lrel (Lexing.lexeme lexbuf) }
 | "<="                         { Lrel (Lexing.lexeme lexbuf) }
 | ">="                         { Lrel (Lexing.lexeme lexbuf) }

 | "REM" [^ '\n']*       { Lrem (Lexing.lexeme lexbuf) }
 | "LET"                 { Llet }
 | "PRINT"               { Lprint }
 | "INPUT"               { Linput }
 | "IF"                  { Lif }
 | "THEN"                { Lthen }
 | "GOTO"                { Lgoto }

 | "RUN"                { Lcmd (Lexing.lexeme lexbuf) }
 | "LIST"               { Lcmd (Lexing.lexeme lexbuf) }
 | "END"                { Lcmd (Lexing.lexeme lexbuf) }
 
 | ['0'-'9']+           { Lint (int_of_string (Lexing.lexeme lexbuf)) }
 | ['A'-'z']+           { Lident (Lexing.lexeme lexbuf) }
 | '"' [^ '"']* '"'     { Lstring (string_chars (Lexing.lexeme lexbuf)) }
