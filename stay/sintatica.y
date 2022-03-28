%{
#include <iostream>
#include <string>
#include <sstream>
#include <stdlib.h>
#include <vector>

#define YYSTYPE atributos

using namespace std;

struct atributos
{
	string label;
	string traducao;
	string tipo;
	string conteudo;
};

typedef struct
{
	string nomeVariavel;
	string tipoVariavel;
	string tempVariavel;
	//string value;
} TIPO_SIMBOLO;

typedef struct
{
	int indice;
	string caracter;
} TABELA_ASCII;

int var_temp_qnt;
vector<TIPO_SIMBOLO> tabelaSimbolos;
vector<TABELA_ASCII> table_ascii; 


string gentempcode();
void print_table();
bool buscaVariavel(string nomeVariavel);
void addSimbolo(string nome, string tipo, string temp);
TIPO_SIMBOLO getSimbolo(string variavel);
string cast(string tipo1, string tipo2);
bool comparaTipo(string tipo1, string tipo2);
void inicializaAscii();
void print_var();
void relacionalInvalida(string tipo1, string tipo2);


int yylex(void);
void yyerror(string);
%}

%token TK_NUM TK_REAL TK_CHAR 
%token TK_MAIN TK_ID TK_VAR TK_TIPO_INT TK_TIPO_FLOAT TK_TIPO_BOOL TK_TIPO_CHAR
%token TK_MAIOR_IGUAL TK_MENOR_IGUAL TK_IGUAL_IGUAL TK_DIFERENTE TK_MAIS_MAIS TK_MENOS_MENOS TK_OU TK_E
%token TK_FUNC
%token TK_INCREMENT
%token TK_FIM TK_ERROR
%token TK_TRUE TK_FALSE
%token TK_PRINTLN TK_PRINT

%start S

%left '+'

%%

S 			: TK_FUNC TK_MAIN '(' ')' BLOCO
			{
				cout << "\n\n/*Compilador STAY*/\n" << "#include <iostream>\n#include<string.h>\n#include<stdio.h>\n\nint main(void)\n{\n" <<endl;
				
				print_var();
				
				cout << "\n" + $5.traducao << "\treturn 0;\n}" << endl;
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
				bool encontrei = buscaVariavel($2.label);
				string temp = gentempcode();
			
				if(encontrei)
					yyerror("erro: a variavel '" + $2.label + "' já foi declarada");
				
				addSimbolo($2.label, "int", temp);
		
				$$.traducao = "\t" + temp + " = 0" + ";\n";
				$$.label = "int " + $2.label;
			}

			| TK_VAR TK_ID TK_TIPO_FLOAT ';'
			{
				bool encontrei = buscaVariavel($2.label);
				string temp = gentempcode();

				if(encontrei)
					yyerror("erro: a variavel '" + $2.label + "' já foi declarada");
				
				addSimbolo($2.label, "float", temp);
		
				$$.traducao = "\t" + temp + " = 0.0" + ";\n";
				$$.label = "float " + $2.label;
			}

			| TK_VAR TK_ID TK_TIPO_BOOL ';' 
			{
				bool encontrei = buscaVariavel($2.label);
				
				if(encontrei)
					yyerror("erro: a variavel '" + $2.label + "' já foi declarada");
				
				string temp = gentempcode();
				addSimbolo($2.label, "int", temp);
		
				$$.traducao = $2.traducao + $3.traducao + "\t" + temp + " = 0" + ";\n";
				$$.label = temp;
			}

			| TK_VAR TK_ID TK_TIPO_CHAR ';' 
			{
				bool encontrei = buscaVariavel($2.label); 
				string temp = gentempcode();

				if(encontrei)
					yyerror("erro: a variavel '" + $2.label + "' já foi declarada");	
				
				addSimbolo($2.label, "char",  temp);
		
				$$.traducao = "\t" + temp + " = " + "'" + "\0" +"'" + ";\n";
				$$.label = "int " + $2.label;
			}

			| TK_VAR TK_ID TK_TIPO_BOOL '=' TK_TRUE ';' 
			{
				bool encontrei = buscaVariavel($2.label); 
				string temp = gentempcode();

				if(encontrei)
					yyerror("erro: a variavel '" + $2.label + "' já foi declarada");
				
				// if($5.tipo != "int") 
				// 	yyerror("Erro: valor (" + $5.conteudo + ") inválido para o tipo int" );
					
				addSimbolo($2.label, "int", temp);
		
				$$.traducao = "\t" + temp + " = 1" + ";\n";
				$$.label = "int " + $2.label + " = " + $5.label;
				
			}

			| TK_VAR TK_ID TK_TIPO_BOOL '=' TK_FALSE ';' 
			{
				bool encontrei = buscaVariavel($2.label); 
				string temp = gentempcode();

				if(encontrei)
					yyerror("erro: a variavel '" + $2.label + "' já foi declarada");
				
				addSimbolo($2.label, "bool", temp);
		
				$$.traducao = "\t" + temp + " = 0" + ";\n";
				$$.label = "int " + $2.label + " = " + $5.label;
			}

			| TK_VAR TK_ID TK_TIPO_INT '=' E ';' 
			{
				string temp = gentempcode();
				
				bool encontrei = buscaVariavel($2.label); 
				
				if(encontrei)
					yyerror("erro: a variavel '" + $2.label + "' já foi declarada");
				
				if($5.tipo == "int"){ 

					addSimbolo($2.label, "int", temp);
			
					$$.traducao = $2.traducao + $5.traducao + "\t" + temp + " = " + $5.label + ";\n";
					$$.label = "int " + $2.label + " = " + $5.label;
				}

				else if ($5.tipo == "float"){
					addSimbolo($2.label, "int", temp);
					$$.traducao = "\t" + temp + " = 0" + ";\n"; 
					
					$$.label = gentempcode();
					addSimbolo($$.label, "int", $$.label);
					$$.traducao = $5.traducao + "\t" + $$.label + " = (int) " + $5.label + ";\n" + 
					"\t" + temp + " = " + $$.label + ";\n";
				}

				else if ($5.tipo == "char"){
					addSimbolo($2.label, "int", temp);
					// $$.traducao = "\t" + temp + " = 0" + ";\n"; 
					
					$$.label = gentempcode();
					addSimbolo($$.label, "int", $$.label);
					$$.traducao = $5.traducao + "\t" + $$.label + " = (int) " + $5.label + ";\n" + 
					"\t" + temp + " = " + $$.label + ";\n";
				}
			}

			| TK_VAR TK_ID TK_TIPO_FLOAT '=' E ';' 
			{
				string temp = gentempcode();
				
				bool encontrei = buscaVariavel($2.label); 
				
				if(encontrei)
					yyerror("erro: a variavel '" + $2.label + "' já foi declarada");
				
				if($5.tipo == "float"){ 

					addSimbolo($2.label, "float", temp);
			
					$$.traducao = $2.traducao + $5.traducao + "\t" + temp + " = " + $5.label + ";\n";
					$$.label = "float " + $2.label + " = " + $5.label;
				}

				else if ($5.tipo == "int"){
					addSimbolo($2.label, "float", temp);
					$$.traducao = "\t" + temp + " = 0" + ";\n"; 
					
					$$.label = gentempcode();
					addSimbolo($$.label, "float", $$.label);
					$$.traducao = $5.traducao + "\t" + $$.label + " = (float) " + $5.label + ";\n" + 
					"\t" + temp + " = " + $$.label + ";\n";
				}
			}

			| TK_VAR TK_ID TK_TIPO_CHAR '=' E ';' 
			{	
				string temp = gentempcode();
				
				bool encontrei = buscaVariavel($2.label); 
				
				if(encontrei)
					yyerror("erro: a variavel '" + $2.label + "' já foi declarada");
				
				if($5.tipo == "char"){ 

					addSimbolo($2.label, "char", temp);
			
					$$.traducao = $2.traducao + $5.traducao + "\t" + temp + " = " + $5.label + ";\n";
					$$.label = "char " + $2.label + " = " + $5.label;
				}

				else if ($5.tipo == "int"){
					addSimbolo($2.label, "char", temp);
					$$.traducao = "\t" + temp + " = 0" + ";\n"; 
					
					$$.label = gentempcode();
					addSimbolo($$.label, "char", $$.label);
					$$.traducao = $5.traducao + "\t" + $$.label + " = (char) " + $5.label + ";\n" + 
					"\t" + temp + " = " + $$.label + ";\n";
				}

				else if ($5.tipo == "float"){
					addSimbolo($2.label, "char", temp);
					$$.traducao = "\t" + temp + " = 0" + ";\n"; 
					
					$$.label = gentempcode();
					addSimbolo($$.label, "char", $$.label);
					$$.traducao = $5.traducao + "\t" + $$.label + " = (char) " + $5.label + ";\n" + 
					"\t" + temp + " = " + $$.label + ";\n";
				}










				// bool encontrei = buscaVariavel($2.label); 
				
				// if(encontrei)
				// 	yyerror("erro: a variavel '" + $2.label + "' já foi declarada");
				
				// string temp = gentempcode();
				// addSimbolo($2.label, "char", temp);
		
				// $$.traducao = "\t" + temp + " = " + "'" + $6.label + "'" + ";\n";
				// $$.label = "char " + $2.label + " = " + $6.label;
			}
			;


			
E 			
			// OPERADORES ARITMÉTICOS
			: E '+' E
			{
				$$.label = gentempcode();
				string tipoAux;
				string labelAux;
				string converter;

				if($1.tipo == $3.tipo){
					$$.tipo = $1.tipo;
					$$.traducao = $1.traducao + $3.traducao + "\t" + 
					$$.label + " = " + $1.label + " + " + $3.label + ";\n";
					addSimbolo($$.label, $$.tipo, $$.label);
				}								
				else if($1.tipo == "int" & $3.tipo == "float"){
					$$.tipo = $3.tipo;
					addSimbolo($$.label, $$.tipo, $$.label);
					converter = cast($1.tipo, $3.tipo);
					$$.traducao = $1.traducao + $3.traducao + "\t" + 
					$$.label + " = "  + converter + $1.label + ";\n";

					labelAux = $$.label;
					$$.label = gentempcode();
					addSimbolo($$.label, $$.tipo, labelAux);
					$$.traducao = $$.traducao + "\t"+
					$$.label + " = " + labelAux + " + " + $3.label + ";\n";
				}

				else if($1.tipo == "float" & $3.tipo == "int"){
					$$.tipo = $1.tipo;
					addSimbolo($$.label, $$.tipo, $$.label);
					converter = cast($1.tipo, $3.tipo);
					$$.traducao = $1.traducao + $3.traducao + "\t" + 
					$$.label + " = " + cast($1.tipo, $3.tipo) + $3.label + ";\n";

					labelAux = $$.label;
					$$.label = gentempcode();
					addSimbolo($$.label, $$.tipo, labelAux);
					$$.traducao = $$.traducao + "\t"+
					$$.label + " = " + $1.label + " + " + labelAux + ";\n";
				}
				
				else yyerror("erro: Cast inválido");
				
			}

			| E '-' E
			{
				$$.label = gentempcode();
				string tipoAux;
				string labelAux;
				string converter;

				if($1.tipo == $3.tipo){
					$$.tipo = $1.tipo;
					$$.traducao = $1.traducao + $3.traducao + "\t" + 
					$$.label + " = " + $1.label + " - " + $3.label + ";\n";
					addSimbolo($$.label, $$.tipo, $$.label);
				}								
				else if($1.tipo == "int" & $3.tipo == "float"){
					$$.tipo = $3.tipo;
					addSimbolo($$.label, $$.tipo, $$.label);
					converter = cast($1.tipo, $3.tipo);
					$$.traducao = $1.traducao + $3.traducao + "\t" + 
					$$.label + " = "  + converter + $1.label + ";\n";

					labelAux = $$.label;
					$$.label = gentempcode();
					addSimbolo($$.label, $$.tipo, labelAux);
					$$.traducao = $$.traducao + "\t"+
					$$.label + " = " + labelAux + " - " + $3.label + ";\n";
				}

				else if($1.tipo == "float" & $3.tipo == "int"){
					$$.tipo = $1.tipo;
					addSimbolo($$.label, $$.tipo, $$.label);
					converter = cast($1.tipo, $3.tipo);
					$$.traducao = $1.traducao + $3.traducao + "\t" + 
					$$.label + " = " + cast($1.tipo, $3.tipo) + $3.label + ";\n";

					labelAux = $$.label;
					$$.label = gentempcode();
					addSimbolo($$.label, $$.tipo, labelAux);
					$$.traducao = $$.traducao + "\t"+
					$$.label + " = " + $1.label + " - " + labelAux + ";\n";
				}
				
				else yyerror("erro: Cast inválido");
			}

			| E '*' E
			{
				$$.label = gentempcode();
				string tipoAux;
				string labelAux;
				string converter;

				if($1.tipo == $3.tipo){
					$$.tipo = $1.tipo;
					$$.traducao = $1.traducao + $3.traducao + "\t" + 
					$$.label + " = " + $1.label + " * " + $3.label + ";\n";
					addSimbolo($$.label, $$.tipo, $$.label);
				}								
				else if($1.tipo == "int" & $3.tipo == "float"){
					$$.tipo = $3.tipo;
					addSimbolo($$.label, $$.tipo, $$.label);
					converter = cast($1.tipo, $3.tipo);
					$$.traducao = $1.traducao + $3.traducao + "\t" + 
					$$.label + " = "  + converter + $1.label + ";\n";

					labelAux = $$.label;
					$$.label = gentempcode();
					addSimbolo($$.label, $$.tipo, labelAux);
					$$.traducao = $$.traducao + "\t"+
					$$.label + " = " + labelAux + " * " + $3.label + ";\n";
				}

				else if($1.tipo == "float" & $3.tipo == "int"){
					$$.tipo = $1.tipo;
					addSimbolo($$.label, $$.tipo, $$.label);
					converter = cast($1.tipo, $3.tipo);
					$$.traducao = $1.traducao + $3.traducao + "\t" + 
					$$.label + " = " + cast($1.tipo, $3.tipo) + $3.label + ";\n";

					labelAux = $$.label;
					$$.label = gentempcode();
					addSimbolo($$.label, $$.tipo, labelAux);
					$$.traducao = $$.traducao + "\t"+
					$$.label + " = " + $1.label + " * " + labelAux + ";\n";
				}
				
				else yyerror("erro: Cast inválido");
			}

			| E '/' E
			{
				$$.label = gentempcode();
				string tipoAux;
				string labelAux;
				string converter;
				
				string aux = $3.conteudo;
				int cont = 0;
				int ponto = 0;

				for(int i = 0; i < aux.size(); i++)
				{
					if(aux[i] == '.')
					{
						ponto = 1;
					}
					if(aux[i] == '0')
					{
						cont++;
					}
				}

				if(cont == aux.size() || (cont + ponto) == aux.size()){
					yyerror("Operação inválida, Divisão por 0");
				}

				if($1.tipo == $3.tipo){
					tipoAux = $1.tipo;
										
					$$.traducao = $1.traducao + $3.traducao + "\t" + 
					$$.label + " = " + $1.label + " / " + $3.label + ";\n";
					addSimbolo($$.label, tipoAux, $$.label);
				}
				else if($1.tipo == "int" & $3.tipo == "float"){
					tipoAux = "float";
					addSimbolo($$.label, tipoAux, $$.label);
					converter = cast($1.tipo, $2.tipo);
					$$.traducao = $1.traducao + $3.traducao + "\t" + 
					$$.label + " = " + converter + $1.label + ";\n";

					labelAux = $$.label;
					$$.label = gentempcode();
					addSimbolo($$.label, tipoAux, labelAux);
					$$.traducao = $$.traducao + "\t"+
					$$.label + " = " + labelAux + " / " + $3.label + ";\n";
				}
				else if($1.tipo == "float" & $3.tipo == "int"){
					tipoAux = "float";
					addSimbolo($$.label, tipoAux, $$.label);
					converter = cast($1.tipo, $2.tipo);
					$$.traducao = $1.traducao + $3.traducao + "\t" + 
					$$.label + " = " + converter + $3.label + ";\n";

					labelAux = $$.label;
					$$.label = gentempcode();
					addSimbolo($$.label, tipoAux, labelAux);
					$$.traducao = $$.traducao + "\t"+
					$$.label + " = " + $1.label + " / " + labelAux + ";\n";
				}
				else{
					yyerror("Erro: Divisão inválida");
				}
			}

			| E '%' E
			{
				$$.label = gentempcode();

				if($1.tipo == "int" & $3.tipo == "int"){
					$$.traducao = $1.traducao + $3.traducao + "\t" + 
					$$.label + " = " + $1.label + " % " + $3.label + ";\n";
					addSimbolo($$.label, $1.tipo, $$.label);
				}
				else{
					yyerror("Erro: Operação não permitida no tipo float");
				}
			}

			| TK_ID TK_MAIS_MAIS
			{
				if (!buscaVariavel($1.label)) yyerror("Erro: Variável não Declarada");

				TIPO_SIMBOLO var1 = getSimbolo($1.label);
				$$.traducao = $1.traducao + $2.traducao + "\t" + 
				var1.tempVariavel + " = " + var1.tempVariavel + " + 1" + ";\n";
			}

			| TK_ID TK_MENOS_MENOS
			{
				if (!buscaVariavel($1.label)) yyerror("Erro: Variável não Declarada");

				TIPO_SIMBOLO var1 = getSimbolo($1.label);
				$$.traducao = $1.traducao + $2.traducao + "\t" + 
				var1.tempVariavel + " = " + var1.tempVariavel + " - 1" + ";\n";
			}

			//OPERADORES RELACIONAIS

			| E '>' E
			{
				relacionalInvalida($1.tipo, $3.tipo);
				$$.label = gentempcode();
				addSimbolo($$.label, "int", $$.label);
				$$.traducao = $1.traducao + $3.traducao + "\t" + 
				$$.label + " = " + $1.label + " > " + $3.label + ";\n";
			}
			
			| E '<' E
			{
				relacionalInvalida($1.tipo, $3.tipo);
				$$.label = gentempcode();
				addSimbolo($$.label, "int", $$.label);
				$$.traducao = $1.traducao + $3.traducao + "\t" + 
				$$.label + " = " + $1.label + " < " + $3.label + ";\n";
			}

			| E TK_MAIOR_IGUAL E
			{
				relacionalInvalida($1.tipo, $3.tipo);
				$$.label = gentempcode();
				addSimbolo($$.label, "int", $$.label);
				$$.traducao = $1.traducao + $3.traducao + "\t" + 
				$$.label + " = " + $1.label + " >= " + $3.label + ";\n";
			}
			
			| E TK_MENOR_IGUAL E
			{
				relacionalInvalida($1.tipo, $3.tipo);
				$$.label = gentempcode();
				addSimbolo($$.label, "int", $$.label);
				$$.traducao = $1.traducao + $3.traducao + "\t" + 
				$$.label + " = " + $1.label + " <= " + $3.label + ";\n";
			}

			| E TK_IGUAL_IGUAL E
			{
				relacionalInvalida($1.tipo, $3.tipo);
				$$.label = gentempcode();
				addSimbolo($$.label, "int", $$.label);
				$$.traducao = $1.traducao + $3.traducao + "\t" + 
				$$.label + " = " + $1.label + " == " + $3.label + ";\n";
			}

			//OPERADORES LÓGICOS
			| E TK_DIFERENTE E
			{
				relacionalInvalida($1.tipo, $3.tipo);
				$$.label = gentempcode();
				addSimbolo($$.label, "int", $$.label);
				$$.traducao = $1.traducao + $3.traducao + "\t" + 
				$$.label + " = " + $1.label + " != " + $3.label + ";\n";
			}

			| E TK_OU E
			{
				$$.label = gentempcode();
				addSimbolo($$.label, "int", $$.label);
				$$.traducao = $1.traducao + $3.traducao + "\t" + 
				$$.label + " = " + $1.label + " || " + $3.label + ";\n";
			}

			| E TK_E E
			{
				cout << "Traduções -> " + $1.traducao + $3.traducao << endl;
				$$.label = gentempcode();
				addSimbolo($$.label, "int", $$.label);
				$$.traducao = $1.traducao + $3.traducao + "\t" + $$.label + " = " + $1.label + " && " + $3.label + ";\n";
			}

			| '!' E
			{
				$$.label = gentempcode();
				addSimbolo($$.label, "int", $$.label);
				$$.traducao = $2.traducao + "\t" + 
				$$.label + " = " + "!" + $2.label + ";\n";
			}

			//OPERADORES DE ATRIBUIÇÃO
			| TK_ID '=' E
			{
				if (!buscaVariavel($1.label)) yyerror("Erro: Variável não Declarada");

				TIPO_SIMBOLO var = getSimbolo($1.label);

				if(var.tipoVariavel == $3.tipo){
					$$.traducao = $1.traducao + $3.traducao + "\t" + 
				    var.tempVariavel + " = " + $3.label + ";\n";
				}
				else if (var.tipoVariavel == "int" & $3.tipo == "float")
				{
					$$.label = gentempcode();
					addSimbolo($$.label, "int", $$.label);
					$$.traducao = $1.traducao + $3.traducao + "\t" + 
					$$.label + " = (int) " + $3.label + ";\n" + "\t" + 
					var.tempVariavel + " = " + $$.label + ";\n";
				}
				else if (var.tipoVariavel == "float" & $3.tipo == "int")
				{
					$$.label = gentempcode();
					addSimbolo($$.label, "float", $$.label);
					$$.traducao = $1.traducao + $3.traducao + "\t" + 
					$$.label + " = (float) " + $3.label + ";\n" + "\t" + 
					var.tempVariavel + " = " + $$.label + ";\n";
				}
				else if (var.tipoVariavel == "char" & $3.tipo == "int"){
					$$.label = gentempcode();
					addSimbolo($$.label, "char", $$.label);
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.label + " = (char) " + $3.label + ";\n" + "\t" + 
					var.tempVariavel + " = " + $$.label + ";\n";
				}
				else if (var.tipoVariavel == "int" & $3.tipo == "char"){
					$$.label = gentempcode();
					addSimbolo($$.label, "int", $$.label);
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.label + " = (int) " + $3.label + ";\n" + "\t" + 
					var.tempVariavel + " = " + $$.label + ";\n";
				}
				else if (var.tipoVariavel == "float" & $3.tipo == "char"){
					$$.label = gentempcode();
					addSimbolo($$.label, "float", $$.label);
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.label + " = (float) " + $3.label + ";\n" + "\t" + 
					var.tempVariavel + " = " + $$.label + ";\n";
				}
				else if (var.tipoVariavel == "char" & $3.tipo == "float"){
					$$.label = gentempcode();
					addSimbolo($$.label, "char", $$.label);
					$$.traducao = $1.traducao + $3.traducao + "\t" +
					$$.label + " = (char) " + $3.label + ";\n" + "\t" + 
					var.tempVariavel + " = " + $$.label + ";\n";
				}
				else{ 
					yyerror("Erro: Atribuição inviavel");
				}
			}

			| TK_ID '=' TK_TRUE
			{
			    if (!buscaVariavel($1.label)) yyerror("Erro: Variável não Declarada");

				TIPO_SIMBOLO var1 = getSimbolo($1.label);
				$$.label = var1.tempVariavel;
				$$.traducao = $1.traducao + $3.traducao + "\t" + 
				var1.tempVariavel + " = 1"  + ";\n";
			}

			| TK_ID '=' TK_FALSE
			{
			    if (!buscaVariavel($1.label)) yyerror("Erro: Variável não Declarada");

				TIPO_SIMBOLO var1 = getSimbolo($1.label);
				$$.label = var1.tempVariavel;
				$$.traducao = $1.traducao + $2.traducao + "\t" + 
				var1.tempVariavel + " = 0"  + ";\n";
			}

			| TK_NUM
			{
				$$.tipo = "int";
				$$.conteudo = $1.label;
				$$.label = gentempcode();
				addSimbolo($$.label, $$.tipo, $$.label);
				$$.traducao = "\t" + $$.label + " = " + $1.label + ";\n";
			}

			| TK_REAL
			{
				$$.tipo = "float";
				$$.conteudo = $1.label;
				$$.label = gentempcode();
				$$.traducao = "\t" + $$.label + " = " + $1.label + ";\n";
				addSimbolo($$.label, $$.tipo, $$.label);
			}

			| TK_TRUE
			{
				$$.tipo = "int";
				$$.conteudo = "1";
				$$.label = gentempcode();
				$$.traducao = "\t" + $$.label + " = " + $$.conteudo + ";\n";
				addSimbolo($$.label, $$.tipo, $$.label);
			}

			| TK_FALSE
			{
				$$.tipo = "int";
				$$.conteudo = "0";
				$$.label = gentempcode();
				$$.traducao = "\t" + $$.label + " = " + $$.conteudo + ";\n";
				addSimbolo($$.label, $$.tipo, $$.label);
			}

			| TK_CHAR
			{
				$$.tipo = "char";
				$$.label = gentempcode();
				$$.traducao = "\t" + $$.label + " = " + $1.label + ";\n";
				addSimbolo($$.label, $$.tipo, $$.label);
			}
	
			| TK_ID
			{
				bool encontrei = false;
				TIPO_SIMBOLO variavel;
				for (int i = 0; i < tabelaSimbolos.size(); i++){
					if(tabelaSimbolos[i].nomeVariavel == $1.label){
						variavel = tabelaSimbolos[i];
						encontrei = true;
					} 
				}

				if(!encontrei){
					yyerror(" erro: a variável '" + $1.label + "' não foi declarada");
				}

				$$.tipo = variavel.tipoVariavel;
				
				// $$.conteudo = variavel.value;
				$$.label = gentempcode();
				addSimbolo(variavel.nomeVariavel, $$.tipo, $$.label);
				$$.traducao = "\t" + $$.label + " = " + variavel.tempVariavel + ";\n";
			}

			//CONVERSÃO EXPLÍCITA
			|TK_TIPO_FLOAT '(' E ')'
			{		
				$$.label = gentempcode();
				$$.tipo  = "float";

				addSimbolo($$.label, $$.tipo, $$.label);
				
				if($3.tipo == "int")
				{	
					$$.traducao = $3.traducao + "\t" + 
					$$.label + " = " + "(float) " + $3.label + ";\n";  
				}
				
				else
					yyerror("Erro Cast Inválido");
			}

			|TK_TIPO_INT '(' E ')'
			{	
				$$.label = gentempcode();
				$$.tipo  = "int";
				addSimbolo($$.label, $$.tipo, $$.label);

				if($3.tipo == "float")
				{
					$$.traducao = $3.traducao + "\t" + 
					$$.label + " = " + "(int) " + $3.label + ";\n";
				}
				
				else yyerror("operacao invalida");
			}

			// IO
			| TK_PRINTLN '(' E ')'
			{
				$$.traducao = $3.traducao + "\tcout << " + $3.label + " << endl;\n";
			}
			
			| TK_PRINT '(' E ')'
			{
				$$.traducao = $3.traducao + "\tcout << " + $3.label + ";\n";
			}
			
			// | TK_PRINTLN '(' ')'
			// {
			// 	$$.traducao = $3.traducao + "\tcout;\n";
			// }
			;

%%

#include "lex.yy.c"

int yyparse();

string gentempcode(){
	var_temp_qnt++;
	return "t" + std::to_string(var_temp_qnt);
}

void addSimbolo(string nome, string tipo, string temp){
	TIPO_SIMBOLO var;
	var.nomeVariavel = nome;
	var.tipoVariavel = tipo;
	var.tempVariavel = temp;

	tabelaSimbolos.push_back(var);					
}

void print_var(){
	TIPO_SIMBOLO var;
	
	for (int i = 0; i < tabelaSimbolos.size(); i++){
		var = tabelaSimbolos[i];
		if (var.tipoVariavel == "bool") var.tipoVariavel = "int";
		//if (var.tipoVariavel == "char") var.value = "\"" + var.value + "\"";
		cout << "\t" + var.tipoVariavel + " " + var.tempVariavel + ";\n";
	}
}

bool buscaVariavel(string nomeVariavel){
	for (int i = 0; i < tabelaSimbolos.size(); i++){
		if(tabelaSimbolos[i].nomeVariavel == nomeVariavel){
			return true;
		}
	}
	return false;
}

TIPO_SIMBOLO getSimbolo(string variavel){
	for (int i = 0; i < tabelaSimbolos.size(); i++){
		if(tabelaSimbolos[i].nomeVariavel == variavel)
			return tabelaSimbolos[i];					
	}
	
	yyerror("erro: variável não declarada");
	exit(0);
}

//Conversão implícita
string cast(string tipo1, string tipo2){
	
	if (tipo1 == "int" && tipo2 == "float" || tipo1 == "float" && tipo2 == "int")
		return "(float) ";
	
	yyerror("erro: Casting inválido");
	exit(0);
}

bool comparaTipo(string tipo1, string tipo2){
	if (tipo1 == tipo2) return true;

	return false;
}

void relacionalInvalida(string tipo1, string tipo2){
	if (tipo1 == "char" || tipo2 == "char" || tipo1 == "bool" || tipo2 == "bool") yyerror("Erro: Relacional Inválido");
}

void inicializaAscii(){
	TABELA_ASCII elemento;

	elemento.indice = 0;
	elemento.caracter = "\0";
	table_ascii.push_back(elemento);

	for ( char i = 1; i < 127; i++ ) {

		elemento.indice = i;
		elemento.caracter = i;
		
		table_ascii.push_back(elemento);
    }
}


int main( int argc, char* argv[] )
{
	inicializaAscii();

	var_temp_qnt = 0;
	
	yyparse();

	return 0;
}

void yyerror( string MSG )
{
	cout << MSG << endl;
	exit (0);
}				
