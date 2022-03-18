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

%start S

%left '+'

%%

S 			: TK_FUNC TK_MAIN '(' ')' BLOCO
			{
				cout << "\n\n/*Compilador GO*/\n" << "#include <iostream>\n#include<string.h>\n#include<stdio.h>\n\nint main(void)\n{\n" <<endl;
				
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
			
				if(encontrei){
					yyerror("erro: a variavel '" + $2.label + "' já foi declarada");
					exit(1);
				}
				
				addSimbolo(temp, "int", temp);
		
				$$.traducao = "\t" + temp + " = 0" + ";\n";
				$$.label = "int " + $2.label;
			}

			| TK_VAR TK_ID TK_TIPO_FLOAT ';'
			{
				bool encontrei = buscaVariavel($2.label);
				string temp = gentempcode();

				if(encontrei){
					yyerror("erro: a variavel '" + $2.label + "' já foi declarada");
					exit(1);
				}
				
				addSimbolo(temp, "float", temp);
		
				$$.traducao = "\t" + temp + " = 0.0" + ";\n";
				$$.label = "float " + $2.label;
			}

			| TK_VAR TK_ID TK_TIPO_BOOL ';' 
			{
				bool encontrei = buscaVariavel($2.label);
				string temp = gentempcode();

				if(encontrei){
					yyerror("erro: a variavel '" + $2.label + "' já foi declarada");
					exit(1);
				}
				
				addSimbolo(temp, "bool", temp);
		
				$$.traducao = "\t" + temp + " = 0" + ";\n";
				$$.label = "int " + $2.label;
			}

			| TK_VAR TK_ID TK_TIPO_CHAR ';' 
			{
				bool encontrei = buscaVariavel($2.label); 
				string temp = gentempcode();

				if(encontrei){
					yyerror("erro: a variavel '" + $2.label + "' já foi declarada");
					exit(1);
				}
				
				
				addSimbolo($2.label, "char",  temp);
		
				//$$.traducao = $2.traducao + "\t" +  "char " + $2.label + ";\n";
				$$.label = "char " + $2.label;
			}

			| TK_VAR TK_ID TK_TIPO_BOOL '=' TK_TRUE ';' 
			{
				bool encontrei = buscaVariavel($2.label); 
				string temp = gentempcode();

				if(encontrei){
					yyerror("erro: a variavel '" + $2.label + "' já foi declarada");
					exit(1);
				}
				
				addSimbolo($2.label, "bool", temp);
		
				//$$.traducao = $2.traducao + "\t" +  "int " + $2.label + " = 1" + ";\n";
				$$.label = "int " + $2.label + " = " + $5.label;
				$$.conteudo = $5.label;
			}

			| TK_VAR TK_ID TK_TIPO_BOOL '=' TK_FALSE ';' 
			{
				bool encontrei = buscaVariavel($2.label); 
				string temp = gentempcode();

				if(encontrei){
					yyerror("erro: a variavel '" + $2.label + "' já foi declarada");
					exit(1);
				}
				
				addSimbolo($2.label, "bool", temp);
		
				//$$.traducao = $2.traducao + "\t" +  "int " + $2.label + " = 0" + ";\n";
				$$.label = "int " + $2.label + " = " + $5.label;
				$$.conteudo = $5.label;
			}

			| TK_VAR TK_ID TK_TIPO_INT '=' TK_NUM ';' 
			{
				bool encontrei = buscaVariavel($2.label); 
				string temp = gentempcode();

				if(encontrei){
					yyerror("erro: a variavel '" + $2.label + "' já foi declarada");
					exit(1);
				}
				
				addSimbolo(temp, "int", temp);
		
				$$.traducao = "\t" + temp + " = " + $5.label + ";\n";
				$$.label = "int " + $2.label + " = " + $5.label;
				$$.conteudo = $5.label;
			}

			| TK_VAR TK_ID TK_TIPO_FLOAT '=' TK_REAL ';' 
			{
				bool encontrei = buscaVariavel($2.label); 
				string temp = gentempcode();

				if(encontrei){
					yyerror("erro: a variavel '" + $2.label + "' já foi declarada");
					exit(1);
				}
				
				addSimbolo(temp, "float", temp);
		
				$$.traducao = "\t" + temp + " = " + $5.label + ";\n";
				$$.label = "float " + $2.label + " = " + $5.label;
				$$.conteudo = $5.label;
			}

			// //CHAR
			// | TK_VAR TK_ID TK_TIPO_CHAR '=' '"' TK_ID '"' ';' 
			// {

			// 	if ($6.label.size() > 1){
			// 		 yyerror("erro: a variável (char " + $2.label + ") só pode receber um caracter");
			// 		 exit(1);
			// 	}
			// 	bool encontrei = buscaVariavel($2.label); 
				
			// 	if(encontrei){
			// 		yyerror("erro: a variavel '" + $2.label + "' já foi declarada");
			// 		exit(1);
			// 	}
				
			// 	addSimbolo($2.label, "char");
		
			// 	//$$.traducao = $2.traducao + "\t" +  "char " + $2.label + " = " + '"' + $6.label + '"' + ";\n";
			// 	$$.label = "char " + $2.label + " = " + $6.label;
			// 	$$.conteudo = $6.label;
			// }
			// ;

			// //CHAR
			// | TK_VAR TK_ID TK_TIPO_CHAR '=' '"' TK_NUM '"' ';' 
			// {
			// 	if ($6.label.size() > 1){
			// 		yyerror("erro: a variável (char " + $2.label + ") só pode receber um caracter");
			// 		exit(1);
			// 	}
			// 	bool encontrei = buscaVariavel($2.label); 
				
			// 	if(encontrei){
			// 		yyerror("erro: a variavel '" + $2.label + "' já foi declarada");
			// 		exit(1);
			// 	}
				
			// 	addSimbolo($2.label, "char");
		
			// 	//$$.traducao = $2.traducao + "\t" +  "char " + $2.label + " = " + '"' + $6.label + '"' + ";\n";
			// 	$$.label = "char " + $2.label + " = " + $6.label;
			// 	$$.conteudo = $6.label;
			// }


			
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

			// | E '-' E
			// {
			// 	$$.label = gentempcode();
			// 	string tipoAux;
			// 	string labelAux;
			// 	string converter;

			// 	if($1.tipo == $3.tipo){
			// 		$$.tipo = $1.tipo;
			// 		$$.traducao = $1.traducao + $3.traducao + "\t" + 
			// 		$$.label + " = " + $1.label + " - " + $3.label + ";\n";
			// 		addSimbolo($$.label, $$.tipo);
			// 	}								
			// 	else if($1.tipo == "int" & $3.tipo == "float"){
			// 		$$.tipo = $3.tipo;
			// 		addSimbolo($$.label, $$.tipo);
			// 		converter = cast($1.tipo, $3.tipo);
			// 		$$.traducao = $1.traducao + $3.traducao + "\t" + 
			// 		$$.label + " = "  + converter + $1.label + ";\n";

			// 		labelAux = $$.label;
			// 		$$.label = gentempcode();
			// 		addSimbolo($$.label, $$.tipo);
			// 		$$.traducao = $$.traducao + "\t"+
			// 		$$.label + " = " + labelAux + " - " + $3.label + ";\n";
			// 	}

			// 	else if($1.tipo == "float" & $3.tipo == "int"){
			// 		$$.tipo = $1.tipo;
			// 		addSimbolo($$.label, $$.tipo);
			// 		converter = cast($1.tipo, $3.tipo);
			// 		$$.traducao = $1.traducao + $3.traducao + "\t" + 
			// 		$$.label + " = " + cast($1.tipo, $3.tipo) + $3.label + ";\n";

			// 		labelAux = $$.label;
			// 		$$.label = gentempcode();
			// 		addSimbolo($$.label, $$.tipo);
			// 		$$.traducao = $$.traducao + "\t"+
			// 		$$.label + " = " + $1.label + " - " + labelAux + ";\n";
			// 	}
				
			// 	else yyerror("erro: Cast inválido");
			// }

			// | E '*' E
			// {
			// 	$$.label = gentempcode();
			// 	string tipoAux;
			// 	string labelAux;
			// 	string converter;

			// 	if($1.tipo == $3.tipo){
			// 		$$.tipo = $1.tipo;
			// 		$$.traducao = $1.traducao + $3.traducao + "\t" + 
			// 		$$.label + " = " + $1.label + " * " + $3.label + ";\n";
			// 		addSimbolo($$.label, $$.tipo);
			// 	}								
			// 	else if($1.tipo == "int" & $3.tipo == "float"){
			// 		$$.tipo = $3.tipo;
			// 		addSimbolo($$.label, $$.tipo);
			// 		converter = cast($1.tipo, $3.tipo);
			// 		$$.traducao = $1.traducao + $3.traducao + "\t" + 
			// 		$$.label + " = "  + converter + $1.label + ";\n";

			// 		labelAux = $$.label;
			// 		$$.label = gentempcode();
			// 		addSimbolo($$.label, $$.tipo);
			// 		$$.traducao = $$.traducao + "\t"+
			// 		$$.label + " = " + labelAux + " * " + $3.label + ";\n";
			// 	}

			// 	else if($1.tipo == "float" & $3.tipo == "int"){
			// 		$$.tipo = $1.tipo;
			// 		addSimbolo($$.label, $$.tipo);
			// 		converter = cast($1.tipo, $3.tipo);
			// 		$$.traducao = $1.traducao + $3.traducao + "\t" + 
			// 		$$.label + " = " + cast($1.tipo, $3.tipo) + $3.label + ";\n";

			// 		labelAux = $$.label;
			// 		$$.label = gentempcode();
			// 		addSimbolo($$.label, $$.tipo);
			// 		$$.traducao = $$.traducao + "\t"+
			// 		$$.label + " = " + $1.label + " * " + labelAux + ";\n";
			// 	}
				
			// 	else yyerror("erro: Cast inválido");
			// }

			// | E '/' E
			// {
			// 	$$.label = gentempcode();
			// 	string tipoAux;
			// 	string labelAux;
			// 	string converter;
				
			// 	string aux = $3.conteudo;
			// 	int cont = 0;
			// 	int ponto = 0;

			// 	for(int i = 0; i < aux.size(); i++)
			// 	{
			// 		if(aux[i] == '.')
			// 		{
			// 			ponto = 1;
			// 		}
			// 		if(aux[i] == '0')
			// 		{
			// 			cont++;
			// 		}
			// 	}

			// 	if(cont == aux.size() || (cont + ponto) == aux.size()){
			// 		yyerror("Operação inválida, Divisão por 0");
			// 	}

			// 	if($1.tipo == $3.tipo){
			// 		tipoAux = $1.tipo;
										
			// 		$$.traducao = $1.traducao + $3.traducao + "\t" + 
			// 		$$.label + " = " + $1.label + " / " + $3.label + ";\n";
			// 		addSimbolo($$.label, tipoAux);
			// 	}
			// 	else if($1.tipo == "int" & $3.tipo == "float"){
			// 		tipoAux = "float";
			// 		addSimbolo($$.label, tipoAux);
			// 		converter = cast($1.tipo, $2.tipo);
			// 		$$.traducao = $1.traducao + $3.traducao + "\t" + 
			// 		$$.label + " = " + converter + $1.label + ";\n";

			// 		labelAux = $$.label;
			// 		$$.label = gentempcode();
			// 		addSimbolo($$.label, tipoAux);
			// 		$$.traducao = $$.traducao + "\t"+
			// 		$$.label + " = " + labelAux + " / " + $3.label + ";\n";
			// 	}
			// 	else if($1.tipo == "float" & $3.tipo == "int"){
			// 		tipoAux = "float";
			// 		addSimbolo($$.label, tipoAux);
			// 		converter = cast($1.tipo, $2.tipo);
			// 		$$.traducao = $1.traducao + $3.traducao + "\t" + 
			// 		$$.label + " = " + converter + $3.label + ";\n";

			// 		labelAux = $$.label;
			// 		$$.label = gentempcode();
			// 		addSimbolo($$.label, tipoAux);
			// 		$$.traducao = $$.traducao + "\t"+
			// 		$$.label + " = " + $1.label + " / " + labelAux + ";\n";
			// 	}
			// 	else{
			// 		yyerror("Erro: Divisão inválida");
			// 	}
			// }

			// | E '%' E
			// {
			// 	$$.label = gentempcode();

			// 	if($1.tipo == "int" & $3.tipo == "int"){
			// 		$$.traducao = $1.traducao + $3.traducao + "\t" + 
			// 		$$.label + " = " + $1.label + " % " + $3.label + ";\n";
			// 		addSimbolo($$.label, $1.tipo);
			// 	}
			// 	else{
			// 		yyerror("Erro: Operação não permitida no tipo float");
			// 	}
			// }

































			// | TK_ID '+' '+'
			// {
			// 	$$.label = gentempcode();
			// 	$$.traducao = $1.traducao + $2.traducao + "\t" + $$.label + " = " + $1.label +
			// 		'+' + '+' + ";\n";
			// }

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
			// | TK_ID '<' E
			// {
			// 	$$.label = gentempcode();
			// 	$$.traducao = $1.traducao + $3.traducao + "\t" + $1.label + " < " + $3.label + ";\n";
			// }

			// | TK_ID '>' E
			// {
			// 	$$.label = gentempcode();
			// 	$$.traducao = $1.traducao + $3.traducao + "\t" + $1.label + " > " + $3.label + ";\n";
			// }

			// | TK_ID '<' '=' E
			// {
			// 	$$.label = gentempcode();
			// 	$$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " <= " + $4.label + ";\n";
			// }

			// | TK_ID '>' '=' E
			// {
			// 	$$.label = gentempcode();
			// 	$$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " >= " + $4.label + ";\n";
			// }

			// | TK_ID '=' '=' E
			// {
			// 	$$.label = gentempcode();
			// 	$$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " == " + $4.label + ";\n";
			// }

			// | TK_ID '!' '=' E
			// {
			// 	$$.label = gentempcode();
			// 	$$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " != " + $4.label + ";\n";
			// }

			//OPERADORES LÓGICOS
			// | E '&' '&' E
			// {
			// 	$$.label = gentempcode();
			// 	$$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " && " + $4.label + ";\n";
			// }

			// | E '|' '|' E
			// {
			// 	$$.label = gentempcode();
			// 	$$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " || " + $4.label + ";\n";
			// }

			// | '!' E
			// {
			// 	$$.label = gentempcode();
			// 	$$.traducao = $2.traducao + "\t" + " !" + $2.label + ";\n";
			// }


			//OPERADORES DE ATRIBUIÇÃO
			| TK_ID '=' TK_ID
			{
				TIPO_SIMBOLO var1 = getSimbolo($1.label);
				TIPO_SIMBOLO var2 = getSimbolo($3.label);

				bool validador = comparaTipo(var1.tipoVariavel, var2.tipoVariavel);

				if (validador){
					$$.traducao = "\t" + $1.label + " = " + $3.label + ";\n";
					cout << "Tipo igual " +$1.label + " " + $3.label << endl;
				}

				else{
					string result = cast(var1, var2);
					$$.traducao = $1.traducao + $3.traducao + "\t" + $1.label + " = " + result + ";\n";
				}
			}

			// | TK_ID '=' TK_NUM
			// {
			// 	TIPO_SIMBOLO var1 = getSimbolo($1.label);

			// 	bool validador = comparaTipo(var1.tipoVariavel, "int");
			// 	if (validador)
			// 		$$.traducao = $1.traducao + $3.traducao + "\t" + $1.label + " = " + $3.label + ";\n";
				
			// 	else{
			// 		yyerror("erro: atribuição inválida");
			// 		exit(1);
			// 	}
			// }
			
			// | TK_ID '=' TK_REAL
			// {
			// 	TIPO_SIMBOLO var1 = getSimbolo($1.label);

			// 	bool validador = comparaTipo(var1.tipoVariavel, "float");
			// 	if (validador)
			// 		$$.traducao = $1.traducao + $3.traducao + "\t" + $1.label + " = " + $3.label + ";\n";
				
			// 	else{
			// 		yyerror("erro: atribuição inválida");
			// 		exit(1);
			// 	}
			// }

			// | TK_ID '=' TK_TRUE
			// {
			// 	TIPO_SIMBOLO var1 = getSimbolo($1.label);

			// 	bool validador = comparaTipo(var1.tipoVariavel, "bool");
			// 	if (validador)
			// 		$$.traducao = $1.traducao + $3.traducao + "\t" + $1.label + " = " + "1" + ";\n";
				
			// 	else{
			// 		yyerror("erro: atribuição inválida");
			// 		exit(1);
			// 	}
			// }

			// | TK_ID '=' TK_FALSE
			// {
			// 	TIPO_SIMBOLO var1 = getSimbolo($1.label);

			// 	bool validador = comparaTipo(var1.tipoVariavel, "bool");
			// 	if (validador)
			// 		$$.traducao = $1.traducao + $3.traducao + "\t" + $1.label + " = " + "0" + ";\n";
				
			// 	else{
			// 		yyerror("erro: atribuição inválida");
			// 		exit(1);
			// 	}
			// }
			
			// | TK_ID '+' '=' E
			// {
			// 	$$.label = gentempcode();
			// 	addSimbolo($$.label, $$.tipo, $$.conteudo);
			// 	// $$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " += " + $4.label + ";\n";
			// }

			// | TK_ID '-' '=' E
			// {
			// 	$$.label = gentempcode();
			// 	$$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " -= " + $4.label + ";\n";
			// }

			// | TK_ID '*' '=' E
			// {
			// 	$$.label = gentempcode();
			// 	$$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " *= " + $4.label + ";\n";
			// }

			// | TK_ID '/' '=' E
			// {
			// 	if ($4.conteudo == "0"){
			// 		yyerror("Erro: Divisão por Zero");
			// 		exit(1);
			// 	}

			// 	TIPO_SIMBOLO var1 = getSimbolo($1.label);
	
			// 	bool validador = comparaTipo(var1.tipoVariavel, $4.tipo);
			// 	if (!validador){
			// 		yyerror("Erro: Associação inválida");
			// 	}
					
			// 	$$.label = gentempcode();
			// 	$$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " /= " + $4.label + ";\n";
			// }

			// | TK_ID '%' '=' E
			// {
			// 	$$.label = gentempcode();
			// 	$$.traducao = $1.traducao + $4.traducao + "\t" + $1.label + " %= " + $4.label + ";\n";
			// }

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

			| '"' TK_CHAR '"'
			{
				$$.tipo = "char";
				$$.conteudo = $2.label;
				$$.label = gentempcode();
				$$.traducao = "\t" + $$.label + " = " + $2.label + ";\n";
				addSimbolo($$.label, $$.tipo, $$.label);
			}

			// //CHAR
			// | '"' TK_ID '"'
 			// {
			// 	$$.tipo = "char";
			// 	$$.label = gentempcode();
			// 	$$.conteudo = $2.label;
			// 	if ($2.label.size() > 1){
			// 		yyerror("erro: a variável (char " + $$.label + ") só pode receber um caracter");
			// 		exit(1);
			// 	}
			// 	addSimbolo($$.label, $$.tipo, $$.conteudo);
				
			// }

			// //CHAR
			// | '"' TK_NUM '"'
 			// {
			// 	$$.tipo = "char";
			// 	$$.label = gentempcode();
			// 	$$.conteudo = $2.label;
			// 	if ($2.label.size() > 1){
			// 		yyerror("erro: a variável (char " + $$.label + ") só pode receber um caracter");
			// 		exit(1);
			// 	}
			// 	addSimbolo($$.label, $$.tipo, $$.conteudo);
			// }
	
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
				addSimbolo($$.label, $$.tipo, $$.label);
				// $$.traducao = "\t" + $$.label + " = " + $1.label + ";\n";
			}

			//Conversão Explicita
			| TK_TIPO_FLOAT '(' TK_ID ')' 
			{
				$$.label = gentempcode();
				$$.traducao = "\t" + $$.label + " = " + "(float) " + $3.label + ";\n";   
			}

			| TK_ID '=' TK_TIPO_FLOAT '(' TK_ID ')'
			{
				TIPO_SIMBOLO var1 = getSimbolo($1.label);

				bool validador = comparaTipo(var1.tipoVariavel, "float");
				if (validador)
					$$.traducao = "\t" + $1.label + " = "+ "(float) " + $5.label + ";\n";
				
				else{
					yyerror("erro: atribuição inválida");
					exit(1);
				}
			}
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
		cout << "\t" + var.tipoVariavel + " " + var.nomeVariavel + ";\n";
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
	exit(1);
}

//Conversão implícita
string cast(string tipo1, string tipo2){
	// if (var1.tipoVariavel == var2.tipoVariavel) 
	// 	return var1.nomeVariavel;
	
	if (tipo1 == "int" && tipo2 == "float" || tipo1 == "float" && tipo2 == "int")
		return "(float) ";
	
	// char -> int
	// if(var1.tipoVariavel == "int" && var2.tipoVariavel == "char") {
	// 	for (int i = 0; i < table_ascii.size(); i++){
	// 		if (table_ascii[i].caracter == var2.value)
	// 			return  std::to_string(table_ascii[i].indice);
	// 	}
	// }
	// // int -> char
	// if(var1.tipoVariavel == "char" && var2.tipoVariavel == "int") {
	// 	for (int i = 0; i < table_ascii.size(); i++){
	// 		if (std::to_string(table_ascii[i].indice) == var2.value)
	// 			return "\"" + table_ascii[i].caracter + "\"";
	// 	}
	// }
	
	yyerror("erro: Casting inválido");
	exit(1);
}

bool comparaTipo(string tipo1, string tipo2){
	if (tipo1 == tipo2) return true;

	return false;
}

void inicializaAscii(){
	TABELA_ASCII elemento;

	elemento.indice = 0;
	elemento.caracter = "\0";
	table_ascii.push_back(elemento);

	for ( char i = 1; i < 127; i++ ) {

		elemento.indice = i;
		elemento.caracter = i;
		// cout << std::to_string(elemento.indice) + " = " + elemento.caracter + "\n"<< endl; 

		table_ascii.push_back(elemento);
    }
}


int main( int argc, char* argv[] )
{

	// 123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~

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
