%{
#include <stdio.h>

void yyerror(char *); /* ver abaixo */
%}

%token INTEIRO
%token FIM_LINHA

%start linha

%%

linha: expressao FIM_LINHA { printf("valor: %d\n", $1); }
     ;

expressao: expressao '+' termo { $$ = $1 + $3; }
         | expressao '-' termo { $$ = $1 - $3; }
         | termo { $$ = $1; }
         ;

termo: INTEIRO { $$ = $1; }
     ;

%%

int main(int argc, char **argv)
{
  return yyparse();
}

/* função usada pelo bison para dar mensagens de erro */
void yyerror(char *msg)
{
  fprintf(stderr, "erro: %s\n", msg);
}

