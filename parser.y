%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int tempCount = 0;
char* newTemp() {
    char* temp = (char*)malloc(10);
    sprintf(temp, "t%d", tempCount++);
    return temp;
}

void yyerror(const char* s);
int yylex(void);

%}

%union {
    char* str;
}

%token <str> ID NUM
%token ASSIGN PLUS MINUS TIMES DIVIDE LPAREN RPAREN SEMICOLON

%type <str> expr term factor stmt

%%

stmt:
      ID ASSIGN expr SEMICOLON {
          printf("%s = %s\n", $1, $3);
      }
    | error SEMICOLON {
          yyerror("Invalid statement. Recovered at ';'");
          yyerrok;
      }
;

expr:
      expr PLUS term {
          if (strcmp($3, "error") == 0) {
              yyerror("Missing operand after '+'");
              $$ = strdup("error");
          } else {
              char* temp = newTemp();
              printf("%s = %s + %s\n", temp, $1, $3);
              $$ = temp;
          }
      }
    | expr MINUS term {
          if (strcmp($3, "error") == 0) {
              yyerror("Missing operand after '-'");
              $$ = strdup("error");
          } else {
              char* temp = newTemp();
              printf("%s = %s - %s\n", temp, $1, $3);
              $$ = temp;
          }
      }
    | term {
          $$ = $1;
      }
;

term:
      term TIMES factor {
          if (strcmp($3, "error") == 0) {
              yyerror("Missing operand after '*'");
              $$ = strdup("error");
          } else {
              char* temp = newTemp();
              printf("%s = %s * %s\n", temp, $1, $3);
              $$ = temp;
          }
      }
    | term DIVIDE factor {
          if (strcmp($3, "error") == 0) {
              yyerror("Missing operand after '/'");
              $$ = strdup("error");
          } else {
              char* temp = newTemp();
              printf("%s = %s / %s\n", temp, $1, $3);
              $$ = temp;
          }
      }
    | factor {
          $$ = $1;
      }
;

factor:
      LPAREN expr RPAREN {
          $$ = $2;
      }
    | LPAREN error RPAREN {
          yyerror("Invalid expression inside parentheses");
          $$ = strdup("error");
      }
    | ID {
          $$ = $1;
      }
    | NUM {
          $$ = $1;
      }
    | error {
          yyerror("Unexpected token in expression");
          $$ = strdup("error");
      }
;

%%

void yyerror(const char* s) {
    fprintf(stderr, "Syntax Error: %s\n", s);
}

int main() {
    return yyparse();
}
