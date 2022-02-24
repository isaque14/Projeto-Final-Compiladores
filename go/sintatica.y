%{
#include <iostream>
#include <string>
#include <sstream>

#define YYSTYPE atributos

using namespace std;

int var_temp_qnt;
string gentempcode();

struct atributos
{
	string label;
	string traducao;
};

int yylex(void);
void yyerror(string);
%}

%token TK_NUM
%token TK_MAIN TK_ID TK_TIPO_INT
%token TK_FUNC
%token TK_INCREMENT
%token TK__TIPO_REAL
%token TK_FIM TK_ERROR

%start S

%left '+'

%%

S 			: TK_FUNC TK_MAIN '(' ')' BLOCO
			{
				cout << "\n\n/*Compilador GO*/\n" << "#include <iostream>\n#include<string.h>\n#include<stdio.h>\nint main(void)\n{\n" << $5.traducao << "\treturn 0;\n}" << endl; 
			}
			;

BLOCO		: '{' COMANDOS '}'
			{
				$$.traducao = $2.traducao;
			}
			;

COMANDOS	: COMANDO COMANDOS
			{
				$$.traducao = $1.traducao + $2.traducao;
			}
			|
			{
				$$.traducao + "";
			}
			;

COMANDO 	: E ';'
			;


			
E 			
			//OPERADORES ARITMÉTICOS
			: E '+' E
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + $3.traducao + "\t" + $$.label +
					" = " + $1.label + " + " + $3.label + ";\n";
			}
			| E '-' E
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + $3.traducao + "\t" + $$.label +
					" = " + $1.label + " - " + $3.label + ";\n";
			}

			| E '*' E
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + $3.traducao + "\t" + $$.label +
					" = " + $1.label + " * " + $3.label + ";\n";
			}

			| E '/' E
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + $3.traducao + "\t" + $$.label +
					" = " + $1.label + " / " + $3.label + ";\n";
			}
			| E '%' E
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + $3.traducao + "\t" + $$.label +
					" = " + $1.label + " % " + $3.label + ";\n";
			}
			| E '+' '+'
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + $2.traducao + "\t" + $$.label + " = " + $1.label +
					'+' + '+' + ";\n";
			}
			| E '-' '-' 
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + "\t" + $$.label + " = " + $1.label + 
					"-" + "-" + ";\n";
			}

			| '+' '+' E
			{
				$$.label = gentempcode();
				$$.traducao = $3.traducao + "\t" + $$.label + " = " +
					'+' + '+' + $3.label + ";\n";
			}

			| '-' '-' E
			{
				$$.label = gentempcode();
				$$.traducao = $3.traducao + "\t" + $$.label + " = " +
					'-' + '-' + $3.label + ";\n";
			}
			
			//OPERADORES RELACIONAIS
			| TK_ID '<' E
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + $3.traducao + "\t" + $1.label + " < " + $3.label + ";\n";
			}

			| TK_ID '>' E
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + $3.traducao + "\t" + $1.label + " > " + $3.label + ";\n";
			}

			| TK_ID '<' '=' E
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " <= " + $4.label + ";\n";
			}

			| TK_ID '>' '=' E
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " >= " + $4.label + ";\n";
			}
			
			| TK_ID '=' '=' E
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " == " + $4.label + ";\n";
			}

			| TK_ID '!' '=' E
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " != " + $4.label + ";\n";
			}

			//OPERADORES LÓGICOS
			| E '&' '&' E
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " && " + $4.label + ";\n";
			}

			| E '|' '|' E
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " || " + $4.label + ";\n";
			}

			| '!' E
			{
				$$.label = gentempcode();
				$$.traducao = $2.traducao + "\t" + " !" + $2.label + ";\n";
			}

			//OPERADORES DE ATRIBUIÇÃO
			| TK_ID '=' E
			{
				$$.traducao = $1.traducao + $3.traducao + "\t" + $1.label + " = " + $3.label + ";\n";
			}

			| TK_ID '+' '=' E
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " += " + $4.label + ";\n";
			}

			| TK_ID '-' '=' E
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " -= " + $4.label + ";\n";
			}

			| TK_ID '*' '=' E
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " *= " + $4.label + ";\n";
			}

			| TK_ID '/' '=' E
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " /= " + $4.label + ";\n";
			}

			| TK_ID '%' '=' E
			{
				$$.label = gentempcode();
				$$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " %= " + $4.label + ";\n";
			}

			| TK_NUM
			{
				$$.label = gentempcode();
				$$.traducao = "\t" + $$.label + " = " + $1.label + ";\n";
			}
			| TK_ID
			{
				$$.label = gentempcode();
				$$.traducao = "\t" + $$.label + " = " + $1.label + ";\n";
			}
			;

%%

#include "lex.yy.c"

int yyparse();

string gentempcode(){
	var_temp_qnt++;
	return "t" + std::to_string(var_temp_qnt);
}


int main( int argc, char* argv[] )
{
	var_temp_qnt = 0;
	yyparse();

	return 0;
}

void yyerror( string MSG )
{
	cout << MSG << endl;
	exit (0);
}				
