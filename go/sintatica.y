%{
#include <iostream>
#include <string>
#include <sstream>
#include <vector>

#define YYSTYPE atributos

using namespace std;

string gentempcode();

struct atributos
{
	string label;
	string traducao;
	string tipo;
};

typedef struct
{
	string nomeVariavel;
	string tipoVariavel;
} TIPO_SIMBOLO;

int var_temp_qnt;
vector<TIPO_SIMBOLO> tabelaSimbolos; 

int yylex(void);
void yyerror(string);
%}

%token TK_NUM
%token TK_MAIN TK_ID TK_VAR TK_TIPO_INT TK_TIPO_FLOAT TK_TIPO_BOOL TK_TIPO_STRING
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
			
			| TK_VAR TK_ID TK_TIPO_INT ';'
			{
				TIPO_SIMBOLO valor;
				valor.nomeVariavel = $2.label;
				valor.tipoVariavel = "int";

				tabelaSimbolos.push_back(valor);
		
				$$.traducao = $2.traducao + "\t" +  "int " + $2.label + ";\n";
				$$.label = "int " + $2.label;
			}

			| TK_VAR TK_ID TK_TIPO_FLOAT ';'
			{
				TIPO_SIMBOLO valor;
				valor.nomeVariavel = $2.label;
				valor.tipoVariavel = "float";

				tabelaSimbolos.push_back(valor);
				
				$$.traducao = $2.traducao + "\t" +  "float " + $2.label + ";\n";
				$$.label = "float " + $2.label;			
			}

			| TK_VAR TK_ID TK_TIPO_BOOL ';' 
			{
				TIPO_SIMBOLO valor;
				valor.nomeVariavel = $2.label;
				valor.tipoVariavel = "bool";

				tabelaSimbolos.push_back(valor);
				
				$$.traducao = $2.traducao + "\t" +  "boolean " + $2.label + ";\n";
				$$.label = "boolean " + $2.label;	
			}

			| TK_VAR TK_ID TK_TIPO_STRING ';' 
			{
				TIPO_SIMBOLO valor;
				valor.nomeVariavel = $2.label;
				valor.tipoVariavel = "char";

				tabelaSimbolos.push_back(valor);
				
				$$.traducao = $2.traducao + "\t" +  "char " + $2.label + ";\n";
				$$.label = "char " + $2.label;	
			}

			;


			
E 			
			//OPERADORES ARITMÉTICOS
			: TK_ID '+' E
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
			| TK_ID '+' '+'
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
				$$.tipo = "int";
				$$.label = gentempcode();
				$$.traducao = "\t" + $$.label + " = " + $1.label + ";\n";
			}
			| TK_ID
			{
				bool encontrei = false;
				TIPO_SIMBOLO variavel;
				for (int i = 0; i < tabelaSimbolos.size(); i++){
					cout << tabelaSimbolos[i].nomeVariavel << endl;
					if(tabelaSimbolos[i].nomeVariavel == $1.label){
						cout << tabelaSimbolos[i].nomeVariavel << endl;
						variavel = tabelaSimbolos[i];
						encontrei = true;
					} 
				}

				if(!encontrei){
					yyerror("variavel não declarada");
				}

				$$.tipo = variavel.tipoVariavel;
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
