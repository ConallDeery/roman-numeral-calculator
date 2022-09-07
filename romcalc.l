%option noyywrap
%{
# include "romcalc.tab.h"
void yyerror(const char *);
%}

%%
"+"       { return ADD; }
"-"       { return SUB; }
"*"       { return MUL; }
"/"       { return DIV; }
"{"       { return lparenthesis; }
"}"       { return rparenthesis; }

IVI|ivi   { yyerror("Invalid input"); exit(1); }
ILI|ili   { yyerror("Invalid input"); exit(1); }
ICI|ici   { yyerror("Invalid input"); exit(1); }
IDI|idi   { yyerror("Invalid input"); exit(1); }
IMI|imi   { yyerror("Invalid input"); exit(1); }
XLX|xlx   { yyerror("Invalid input"); exit(1); }
XCX|xcx   { yyerror("Invalid input"); exit(1); }
XMX|xmx   { yyerror("Invalid input"); exit(1); }
CDC|cdc   { yyerror("Invalid input"); exit(1); }
CMC|cmc   { yyerror("Invalid input"); exit(1); }
V|v{2,}   { yyerror("Invalid input"); exit(1); }
L|l{2,}   { yyerror("Invalid input"); exit(1); }
D|d{2,}   { yyerror("Invalid input"); exit(1); }

("M")|("m")       { return THOUSAND; }
("D")|("d")       { return FIVEHUNDRED; }
("C")|("c")       { return HUNDRED; }
("L")|("l")       { return FIFTY; }
("X")|("x")       { return TEN; }
("V")|("v")       { return FIVE; }
("I")|("i")       { return ONE; }

\n        { return EOL; }
.         { yyerror("Symbol undefined"); exit(1); }
%%
