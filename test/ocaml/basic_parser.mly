%{
open Basic_types ;;

let phrase_of_cmd c =
 match c with
   "RUN" -> Run
 | "LIST" -> List
 | "END" -> End
 | _ -> failwith "line : unexpected command"
;;

let op_bin_of_rel r =
 match r with
   "=" -> EGAL
 | "<" -> INF
 | "<=" -> INFEQ
 | ">" -> SUP
 | ">=" -> SUPEQ
 | "<>" -> DIFF
 | _ -> failwith "line : unexpected relation symbol"
;;

%}


%token <int> Lint
%token <string> Lident
%token <string> Lstring
%token <string> Lcmd
%token Lplus Lmoins Lmult Ldiv Lmod
%token <string> Lrel
%token Land Lor Lneg
%token Lpar Rpar
%token <string> Lrem 
%token Lrem Llet Lprint Linput Lif Lthen Lgoto
%token Legal
%token Leol

%right Lneg
%left Land Lor
%left Legal Lrel
%left Lmod
%left Lplus Lmoins
%left Lmult Ldiv
%nonassoc Lopp

%start line
%type <Basic_types.phrase> line


%%
line : 
   Lint inst Leol               { Ligne {num=$1; inst=$2} }
 | Lcmd        Leol                    { phrase_of_cmd $1 }
 ;

inst :
   Lrem                         { Rem $1 }
 | Lgoto Lint                   { Goto $2 }
 | Lprint exp                   { Print $2 }
 | Linput Lident                { Input $2 }
 | Lif exp Lthen Lint           { If ($2, $4) }
 | Llet Lident Legal exp        { Let ($2, $4) }
 ;

exp :
   Lint                         { ExpInt $1 }
 | Lident                       { ExpVar $1 }
 | Lstring                      { ExpStr $1 }
 | Lneg exp                     { ExpUnr (NON, $2) }
 | exp Lplus exp                { ExpBin ($1, PLUS, $3) }
 | exp Lmoins exp               { ExpBin ($1, MOINS, $3) }
 | exp Lmult exp                { ExpBin ($1, MULT, $3) }
 | exp Ldiv exp                        { ExpBin ($1, DIV, $3) }
 | exp Lmod exp                        { ExpBin ($1, MOD, $3) }
 | exp Legal exp                { ExpBin ($1, EGAL, $3) }
 | exp Lrel exp                        { ExpBin ($1, (op_bin_of_rel $2), $3) }
 | exp Land exp                 { ExpBin ($1, ET, $3) }
 | exp Lor exp                  { ExpBin ($1, OU, $3) }
 | Lmoins exp %prec Lopp        { ExpUnr(OPPOSE, $2) }
 | Lpar exp Rpar                { $2 }
 ;
%%
