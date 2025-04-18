%{
#include "parser.tab.h"
#include <string.h>
%}

%%

[a-zA-Z_][a-zA-Z0-9_]*   { yylval.str = strdup(yytext); return ID; }
[0-9]+                   { yylval.str = strdup(yytext); return NUM; }
"="                      { return ASSIGN; }
"("                      { return LPAREN; }
")"                      { return RPAREN; }
"+"                      { return PLUS; }
"-"                      { return MINUS; }
"*"                      { return TIMES; }
"/"                      { return DIVIDE; }
";"                      { return SEMICOLON; }
[ \t\n]+                 { /* skip whitespace */ }
.                        { printf("Unknown character: %s\n", yytext); }

%%
int yywrap() {
    return 1;
}

