%{
#include <iostream>
#include <string>
#include <sstream>
#include <stdlib.h>
#include <vector>

#define YYSTYPE atributos

using namespace std;
using std::stoi;

int var_lace_qnt;
int var_cond_qnt;
int num_linha = 1;
int var_lace_name_qnt = 0;
int num_elementos_iniciados; 

string error = "";
string warning = "";
string linha_atual = "";
string declaracoes = "";
string funcoes = "";
string atributos_fun = "";
string cabecalho_fun = "";


typedef struct
{
	string nomeVariavel;
	string tipoVariavel;
	string tempVariavel;
	string strSize;
	string conteudo;
	string vetor;
	bool varDeFunc;
} TIPO_SIMBOLO;

struct atributos
{
	string label;
	string traducao;
	string tipo;
	string conteudo;
	string temp;
	bool temRetorno = false;
	TIPO_SIMBOLO varRetorno;
	string conteudoRetorno;
	string label_bool;
	bool isVector;
	string vetor;
	int sizeVector;
	int numElementos;
	string varAtributo;
};

typedef struct
{
	string nomeLaco;
	string tipoLaco;
	string fimLaco;
	string contexto;
}	TIPO_LOOP;

typedef struct
{
	int indice;
	string caracter;
} TABELA_ASCII;

typedef struct
{
	string nomeFunc;
	string tipo;
	string varRetorno;
	string conteudoRetorno;
} TIPO_FUNC;


vector<TIPO_SIMBOLO> tabelaVarFunc;
vector<TIPO_LOOP> tabelaLoop;
vector<vector<TIPO_SIMBOLO>> mapa;
vector<TIPO_FUNC> tabelaFunc;
int contextoGlobal;


string strGeralSize = "500";
int var_temp_qnt;
int num_jump;
vector<TIPO_SIMBOLO> global_escopo;
vector<TABELA_ASCII> table_ascii; 

string label_jump();
string gentempcode();

string genLacecode();
string genCondcode();
string genLaceNameCode();


void print_table();
bool buscaRetorno(string retorno);
bool buscaVariavel(string variavel);
void addSimbolo(string nome, string tipo, string temp);
void addVarFunc(string nome, string tipo, string temp);
void addStr(string nome, string tipo, string temp, string conteudo);
void addVector(string nome, string tipo, string temp, string vetor, string conteudo);
TIPO_SIMBOLO getSimbolo(string variavel);
TIPO_SIMBOLO getRetorno(string retorno);
string cast(string tipo1, string tipo2);
bool comparaTipo(string tipo1, string tipo2);
void inicializaAscii();
void print_var(TIPO_SIMBOLO);
void relacionalInvalida(string tipo1, string tipo2);
int getLength(string str);


void atualizarContexto(int num);
void contLinha();
void pushContexto();
void popContexto();
void pushLoop(string tipo);
TIPO_LOOP getLace(string nome);
TIPO_LOOP getLaceBreak();

void addFunc(string nome, string tipo);
TIPO_FUNC getFunc(string func);
bool buscaFunc(string func);

int yylex(void);
void yyerror(string);
%}

%token TK_NUM TK_REAL TK_CHAR TK_STRING
%token TK_MAIN TK_ID TK_VAR TK_TIPO_INT TK_TIPO_FLOAT TK_TIPO_BOOL TK_TIPO_CHAR TK_TIPO_STRING
%token TK_MAIOR_IGUAL TK_DOIS_PTS_IGUAL TK_MENOR_IGUAL TK_IGUAL_IGUAL TK_DIFERENTE TK_MAIS_MAIS TK_MENOS_MENOS TK_OU TK_E
%token TK_FUNC TK_RETURN TK_TIPO_VOID
%token TK_INCREMENT
%token TK_FIM TK_ERROR
%token TK_COMENTARIO
%token TK_TRUE TK_FALSE
%token TK_PRINTLN TK_PRINT TK_SCAN
%token TK_IF TK_ELSE TK_ELSE_IF TK_WHILE TK_FOR TK_DO TK_BREAK TK_CONTINUE
%token TK_POW TK_SQRT

%start S

%left '+'

%%

S 			: COMANDOS TK_MAIN '(' ')' BLOCO
			{
				if (error == ""){
					cout << "\n\n/*Compilador STAY*/\n" << "#include <iostream>\n#include<string.h>\n#include<stdio.h>\n#include<cstring>\n\n";
					
					cout << atributos_fun << endl;

					cout << cabecalho_fun << endl;

					cout << "\nint main(void)\n{\n" <<endl;
					
					cout << declaracoes;

					cout << "\n" + $1.traducao + $5.traducao << "\treturn 0;\n}\n\n";

					cout << funcoes << endl;
				}
				else yyerror(error);  
			}
			;

BLOCO		: '{' COMANDOS '}'
			{
				$$.traducao = $2.traducao;
			}

			| '{' COMANDOS RETORNO '}'
			{
				$$.tipo = $3.tipo;
				$$.temRetorno = true;
				$$.traducao = $2.traducao + $3.traducao;
				$$.varRetorno = $3.varRetorno;
			}

			| '{' RETORNO COMANDOS '}'
			{
				$$.tipo = $2.tipo;
				$$.temRetorno = true;
				$$.traducao = $2.traducao + $3.traducao;
				$$.varRetorno = $2.varRetorno;
			}

			| '{' COMANDOS RETORNO COMANDOS '}'
			{
				$$.tipo = $3.tipo;
				$$.temRetorno = true;
				$$.traducao = $1.traducao + $2.traducao + $3.traducao;
				$$.varRetorno = $3.varRetorno;
			}
			;


ATRIBUTOS 	: ATRIBUTO
			{
				$$.traducao = $1.traducao;
			}

			| ATRIBUTO ',' ATRIBUTOS
			{
				$$.traducao = $1.traducao + ", " + $3.traducao;
			}

			|
			{

			}
			;


ATRIBUTO 	: TK_ID TIPO 
			{	
				cout << "ADD LABEL = " + $1.label << endl;
				string temp = gentempcode();
				addVarFunc($1.label, $2.tipo, temp);

				$$.varAtributo = temp;
				$$.traducao = $2.tipo + " " + temp;
				atributos_fun += $$.traducao + "; //atributo '" + $1.label + "'\n";
			}
			;

/*PARAMETROS_CHAMADA	: PARAMETRO
					{
						cout << "Um parâmetro\n";
						$$.traducao = $1.traducao;
					}

					| PARAMETRO PARAMETROS_CHAMADA
					{
						$$.traducao = $1.traducao + $2.traducao;
					}

					|
					{
						cout << "Nenhum PArametro\n";;
					}

PARAMETRO 	: TK_ID TIPO
			{
				bool encontrei = buscaSimbolo($1.label);
				// if (!encontrei) error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Função (" + $3.label + ") Não declarada" + "\n";
				TIPO_SIMBOLO var = getSimbolo($1.label);
				$$.traducao = $1.label + $2.tipo;
			}
			;
*/

FUNCOES 	: DECLARA_FUNCAO FUNCOES
			
			| DECLARA_FUNCAO
			;

DECLARA_FUNCAO 	: TK_FUNC TIPO TK_ID '(' ATRIBUTOS ')' BLOCO
				{
					TIPO_SIMBOLO retorno = $7.varRetorno;
					bool encontrei = buscaFunc($3.label);
					cout << "***VAR de FUNC***\n" + atributos_fun;
					cout << "***\n\n VARIAVEIS DO PROGRAMA ***\n" + declaracoes;
					cout << "\n\n**TESTE BLOCO**\n " + $7.traducao;

					cout << "\n\n *** COMPARACAO DE VARIAVEIS *** \n\t" + $2.tipo + " == " + retorno.tipoVariavel + "?\n";

					cout << "\n\n 	*** VARIAVEL RETORNADA ***\n" + retorno.tipoVariavel + " " + retorno.nomeVariavel + "..." << endl;

					
					if(encontrei) error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Função (" + $3.label + ") Já declarada" + "\n";


					if (!$7.temRetorno && ($2.tipo != "void")){
						 error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Retorno da função (" + $3.label + ") não expecificado.\n";
					}

					else if($7.temRetorno && $2.tipo == "void"){
						error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m A função (" + $2.tipo + " " + $3.label + ") não deve ter retorno\n";
					}
					// else if ($2.tipo != $7.tipo && $2.tipo != "void") error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m A função (" + $2.tipo + " " + $3.label + ") Não pode retornar um " + $7.tipo + "\n";
					
					else if ($2.tipo == retorno.tipoVariavel){
						addFunc($3.label, $2.tipo);
					
						funcoes += $2.tipo + " " + $3.label + "(" + $5.traducao + ")\n" + "{\n" + $7.traducao + "\treturn " + retorno.tempVariavel + "\n}\n\n";
						cabecalho_fun += $2.tipo + " " + $3.label + "(" + $5.traducao + ");\n";
					}

					else if ($2.tipo == "void" && !$7.temRetorno){
						addFunc($3.label, $2.tipo);
					
						funcoes += $2.tipo + " " + $3.label + "(" + $5.traducao + ")\n" + "{\n" + $7.traducao + "\n}\n\n";
						cabecalho_fun += $2.tipo + " " + $3.label + "(" + $5.traducao + ");\n";
					}

					else {
						error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m A função (" + $2.tipo + " " + $3.label + ") Não pode retornar um " + retorno.tipoVariavel + ".\n";
					}
				}
				;

CHAMA_FUNCAO	: TK_ID '(' ATRIBUTOS ')'
				{
					cout << "BUSCA Func Chamada\n";
					// TIPO_FUNC aux = getFunc($1.label);
					// $$.label = aux.nomeFunc;
					// $$.tipo = aux.tipo;
					// $$.traducao = aux.nomeFunc + "(" + $3.traducao + ")\n";
				}

				| TK_ID '(' ')'
				{
					TIPO_FUNC fun = getFunc($1.label);

					$$.traducao = "\t" + fun.nomeFunc + "();\n";
				}
				;

RETORNO 	: TK_RETURN E ';'
			{
				TIPO_SIMBOLO var_retorno = getSimbolo($2.label);
				cout << "TA retornando -> " + var_retorno.tipoVariavel + " " + var_retorno.nomeVariavel << endl;
				$$.tipo = $2.tipo;
				$$.temRetorno = true;
				$$.label = "return";
				$$.varRetorno = var_retorno;
				$$.traducao = $2.traducao;
			}

			| TK_RETURN E 
			{
				TIPO_SIMBOLO var_retorno = getSimbolo($2.label);
				cout << "TA retornando -> " + var_retorno.tipoVariavel + " " + var_retorno.nomeVariavel << endl;
				$$.tipo = $2.tipo;
				$$.temRetorno = true;
				$$.label = "return";
				$$.varRetorno = var_retorno;
				$$.traducao = $2.traducao;
			}

			TK_RETURN TK_ID ';'
			{
				bool encontrei = buscaVariavel($2.label);
				if (!encontrei) error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Variável (" + $2.label + ") Não declarada.\n";

				else {
					TIPO_SIMBOLO var_retorno = getSimbolo($2.label);
					cout << "TA retornando -> " + var_retorno.tipoVariavel + " " + var_retorno.nomeVariavel << endl;
					$$.tipo = $2.tipo;
					$$.temRetorno = true;
					$$.label = "return";
					$$.varRetorno = var_retorno;
					// $$.traducao = $2.traducao + "\treturn " + $2.label + ";\n";
				}
			}

			| TK_RETURN TK_ID 
			{
				bool encontrei = buscaVariavel($2.label);
				if (!encontrei) error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Variável (" + $2.label + "Não declarada.\n";

				else{
					TIPO_SIMBOLO var_retorno = getSimbolo($2.label);
					cout << "TA retornando -> " + var_retorno.tipoVariavel + " " + var_retorno.nomeVariavel << endl;
					$$.tipo = $2.tipo;
					$$.temRetorno = true;
					$$.label = "return";
					$$.varRetorno = var_retorno;
					// $$.traducao = $2.traducao + "\treturn " + $2.label + ";\n";
				}
			}

			| TK_RETURN
			{
				$$.temRetorno = false;
				error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Falta uma expressão após o comando (return)\n";
			}

			| TK_RETURN ';'
			{
				$$.temRetorno = false;
				error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Falta uma expressão após o comando (return)\n";
			}
			;

TERNARIO 	: E '?' COMANDO ':' COMANDO
			{
				cout << "Reconhece Ternário\n";

				if($1.tipo != "bool") error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m O condicinal do loop deve ser um boolean\n";

				else{
					string temp = gentempcode();
					$$.label = temp;
					addSimbolo(temp, "bool", temp);
					string jump = label_jump();
					
					addSimbolo(temp, "bool", temp);
					string condicao = temp + " = !" + $1.label;

					$$.traducao = $1.traducao + "\t" + condicao + ";\n INICIO_TERNARIO:\n" +
					"\n\tif (" + temp + ") goto CONDICAO_2_" + jump + ";\n" +
					$3.traducao + "\tgoto FIM_TERNARIO_" + jump + ";\n" +
					"CONDICAO_2_" + jump + ":\n\n" +
					$5.traducao + "\nFIM_TERNARIO_" + jump + ":\n\n";
				}
			}
			;


COMANDOS	: COMANDO COMANDOS
			{
				$$.traducao = $1.traducao + $2.traducao;
			}

			| FUNCOES{
				$$.traducao = $1.traducao;
			}

			|
			{
				$$.traducao = "";
			}

			| BLOCO 
			{
				$$.temRetorno = $1.temRetorno;
				$$.traducao = $1.traducao;
			}

			| TK_IF E BLOCO COMANDOS
			{				
				if($2.tipo != "bool") error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m O condicinal do loop deve ser um boolean\n";

				else{
					string temp = gentempcode();
					$$.label = temp;
					addSimbolo(temp, "bool", temp);
					string jump = label_jump();
					
					addSimbolo(temp, "bool", temp);
					string condicao = temp + " = !" + $2.label;

					$$.traducao = $2.traducao + "\t" + condicao + ";\n" +
					"\n\tif (" + temp + ") goto FIM_IF_" + jump + ";\n" +
					$3.traducao +
					"\tFIM_IF_" + jump + ":\n\n" +
					$4.traducao;
				}
			}
			| TK_IF E BLOCO TK_ELSE BLOCO COMANDOS
			{
				if($2.tipo != "bool") error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m O condicinal do loop deve ser um boolean\n";
				string temp = gentempcode();

				string jump1 = label_jump();
				string jump2 = label_jump();
				
				addSimbolo(temp, "bool", temp);
				string condicao = temp + " = !" + $2.label;

				$$.traducao = $2.traducao + "\t" + condicao + ";\n" +
				"\n\tif (" + temp + ") goto FIM_IF_" + jump1 + "\n;" +
			 	$3.traducao +
				"\tgoto FIM_ELSE_" + jump2 + ";\n" +
				"FIM_IF_" + jump1 + ":\n" +
				"INICIO_ELSE_" + jump2 + ":\n" +
				$5.traducao +
				"FIM_ELSE_" + jump2 + ":\n\n" + $6.traducao;

			}

			| TK_IF E BLOCO TK_ELSE_IF E BLOCO COMANDOS
			{
				if($2.tipo != "bool" || $5.tipo != "bool") error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m O condicinal do loop deve ser um boolean\n";
				
				else{
					string temp = gentempcode();
					string jump1 = label_jump();
					string jump2 = label_jump();
					
					addSimbolo(temp, "bool", temp);
					string condicao = temp + " = !" + $2.label;

					string temp2 = gentempcode();
					addSimbolo(temp2, "bool", temp2);
					string condicao2 = temp2 + " = !" + $5.label;

					$$.traducao = $2.traducao + "\t" + condicao + ";\n" +
					"\n\tif (" + temp + ") goto FIM_IF_" + jump1 + "\n;" +
					$3.traducao +
					"\nFIM_IF_" + jump1 + ":\n" +
					"INICIO_ELSE_IF_" + jump2 + ":\n" +
					$5.traducao + "\t" + condicao2 + ";\n" +
					"\n\tif (" + temp2 + ") goto FIM_ELSE_IF_" + jump2 + ";"
					"\n\t{\n" +
					$6.traducao +
					"\t}\n" +
					"FIM_ELSE_IF_" + jump2 + ":\n\n" + $7.traducao;
				}
			}

			| TK_WHILE E BLOCO COMANDOS 
			{
				if($2.tipo != "bool") error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m O condicinal do loop deve ser um boolean\n";

				else{
					string temp = gentempcode();
					$$.label = temp;
					addSimbolo(temp, "bool", temp);
					string lace = genLacecode();
					TIPO_LOOP loop = getLace($1.label);	
					
					string condicao = temp + " = !" + $2.label;

					$$.traducao = loop.nomeLaco + ":\n" + lace + ":\n" + $2.traducao + "\t" + condicao + ";\n" +
					"\n\tif (" + temp + ") goto " + loop.fimLaco + ";\n" +
					$3.traducao +
					"\tgoto " + lace + ";\n" +
					loop.fimLaco + ":\n\n" + $4.traducao;
				}
			}

			| TK_DO BLOCO TK_WHILE E ';' COMANDOS
			{
				if($4.tipo != "bool") error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m O condicinal do loop deve ser um boolean\n";
				
				else{
					string temp = gentempcode();
					$$.label = temp;
					addSimbolo(temp, "bool", temp);
					string lace = genLacecode();
					TIPO_LOOP loop = getLace($1.label);	
					
					string condicao = temp + " = !" + $4.label;

					$$.traducao = lace + ":\n" +  
					$4.traducao + $2.traducao + "\t" + condicao + ";\n" +
					$3.traducao + loop.nomeLaco + ":\n" +
					"\n\tif (" + temp + ") goto " + loop.fimLaco + ";\n" +
					"\tgoto " + lace + ";\n" +
					loop.fimLaco + ":\n\n" + $6.traducao;
				}
			}			

			| TK_FOR E ';' E ';' E BLOCO COMANDOS
			{
				if($4.tipo != "bool") error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m O condicinal do loop deve ser um boolean\n";

				else{	
					string temp = gentempcode();
					string jump = label_jump();
					
					addSimbolo(temp, "bool", temp);
					string lace = genLacecode();
					TIPO_LOOP loop = getLace($1.label);
					string condicao = temp + " =! " + $4.label;

					$$.traducao = $2.traducao + "INICIO_FOR_" + jump + ":\n" + lace + ":\n" +
					$4.traducao + "\t" + condicao + ";\n" +
					"\n\tif (" + temp + ") goto " + loop.fimLaco + ";\n" +
					$7.traducao + loop.nomeLaco + ":\n" + $6.traducao +
					"\tgoto " + lace + ";\n" +
					"FIM_FOR_" + jump + ":\n" + loop.fimLaco + ":\n" + $8.traducao;
				}
			}
			;

INICIALIZA_MULTI 	: INICIALIZA
					{
						num_elementos_iniciados++;
						$$.numElementos++;
						$$.label = $1.label;
						$$.tipo = $1.tipo;
						$$.conteudo = $1.conteudo;
						$$.traducao = $1.traducao;
					}

					| INICIALIZA ',' INICIALIZA_MULTI
					{
						num_elementos_iniciados++;
						int tam = $1.numElementos + $3.numElementos;
						cout << "TAM EL " + std::to_string(tam) << endl; 
						if ($1.tipo != $3.tipo) error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Um vetor não pode receber tipos diferentes\n";

						else{
							$$.tipo = $1.tipo;
							
							$$.conteudo = $1.conteudo + ", " + $3.conteudo;
							$$.traducao = $1.traducao + $3.traducao;
						}
					}

INICIALIZA 	: TK_NUM
			{
				$$.tipo = "int";
				$$.conteudo = $1.label;
				$$.label = gentempcode();
				addSimbolo($$.label, $$.tipo, $$.label);
				$$.traducao = "\t" + $$.label + " = " + $1.label + ";\n";
			}

			| '-' TK_NUM
			{
				$$.tipo = "int";
				$$.conteudo = $2.label;
				$$.label = gentempcode();
				addSimbolo($$.label, $$.tipo, $$.label);
				$$.traducao = "\t" + $$.label + " = -" + $2.label + ";\n";
			}

			| TK_REAL
			{
				$$.tipo = "float";
				$$.conteudo = $1.label;
				$$.label = gentempcode();
				addSimbolo($$.label, $$.tipo, $$.label);
				$$.traducao = "\t" + $$.label + " = " + $1.label + ";\n";
			
			}

			| '-' TK_REAL
			{
				$$.tipo = "float";
				$$.conteudo = $2.label;
				$$.label = gentempcode();
				addSimbolo($$.label, $$.tipo, $$.label);
				$$.traducao = "\t" + $$.label + " = -" + $2.label + ";\n";
			
			}

			| TK_CHAR
			{
				$$.tipo = "char";
				$$.conteudo = $1.label;
				$$.label = gentempcode();
				addSimbolo($$.label, $$.tipo, $$.label);
				$$.traducao = "\t" + $$.label + " = " + $1.label + ";\n";
			}

			| TK_STRING
			{
				$$.tipo = "string";
				$$.conteudo = $$.label;
				$$.label = gentempcode();
				addStr($$.label, $$.tipo, $$.label, $$.conteudo);
				// $$.traducao = "\t" + $$.label + " = " + $1.label + ";\n";
				$$.traducao = "\tstrcpy(" + $$.label + ", " + $1.label + ");\t//"+ $$.label +"\n";	
				// cout << "traducao 1 " + $$.traducao << endl;	
			}

			| TK_TRUE
			{
				$$.tipo = "bool";
				$$.conteudo = "1";
				$$.label_bool = "True";
				$$.label = gentempcode();
				$$.traducao = "\t" + $$.label + " = " + $$.conteudo + ";\n";
				addSimbolo($$.label, $$.tipo, $$.label);
			}

			| TK_FALSE
			{
				$$.tipo = "bool";
				$$.conteudo = "0";
				$$.label_bool = "False";
				$$.label = gentempcode();
				$$.traducao = "\t" + $$.label + " = " + $$.conteudo + ";\n";
				addSimbolo($$.label, $$.tipo, $$.label);
			}

			/* | TK_ID
			{
				bool encontrei = buscaVariavel($1.label);
				if (!encontrei) error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Variável (" + $1.label + ") Não declarada.\n";

				else{
					TIPO_SIMBOLO variavel = getSimbolo($1.label);	
					$$.tipo = variavel.tipoVariavel;
					$$.label = variavel.tempVariavel;
					$$.temp = $$.label;
				}
			} */
			;

TIPO 		: TK_TIPO_INT
			{
				$$.tipo = "int";
				$$.traducao = "int";
			}

			| TK_TIPO_FLOAT
			{
				$$.tipo = "float";
				$$.traducao = "float";
			}

			| TK_TIPO_BOOL
			{
				$$.tipo = "bool";
				// $$.traducao = "bool";
			}

			| TK_TIPO_CHAR
			{
				$$.tipo = "char";
				$$.traducao = "char";
			}

			| TK_TIPO_STRING
			{
				$$.tipo = "string";
				$$.traducao = "string";
			}

			| TK_TIPO_VOID
			{
				$$.tipo = "void";
				$$.traducao = "void";
			}

			| VETOR TIPO
			{
				$$.sizeVector = $1.sizeVector;
				$$.tipo = $2.tipo;
				$$.isVector = true;
				$$.vetor = $1.traducao;
				$$.traducao = $1.traducao + $2.traducao;
			}
			;

DECLARA_VAR : TK_VAR TK_ID TIPO 
			{
				bool encontrei = buscaVariavel($2.label);
				string temp = gentempcode();
				$$.tipo = $3.tipo;
			
				if(encontrei)
					error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m A variavel '" + $2.label + "' já foi declarada\n";
				
				if ($3.isVector){
					addVector($2.label, $$.tipo, temp, $3.vetor, "0");
				}

				else if ($3.tipo == "int"){
					addSimbolo($2.label, "int", temp);
			
					$$.traducao = "\t" + temp + " = 0" + ";\n";
					$$.label = "int " + $2.label;
				}

				else if ($3.tipo == "float"){
					addSimbolo($2.label, "float", temp);
		
					$$.traducao = "\t" + temp + " = 0.0" + ";\n";
					$$.label = "float " + $2.label;
				}

				else if ($3.tipo == "bool"){
					string temp = gentempcode();
					addSimbolo($2.label, "bool", temp);
			
					$$.traducao = $2.traducao + $3.traducao + "\t" + temp + " = 0" + ";\n";
					$$.label = temp;
				}

				else if ($3.tipo == "char"){
					addSimbolo($2.label, "char",  temp);
			
					$$.traducao = "\t" + temp + " = " + "'" + "\0" +"'" + ";\n";
					$$.label = "int " + $2.label;
				}

				else if ($3.tipo == "string"){
					addStr($2.label, "string",  temp, "\0");
					// $$.traducao = "\tstrcpy(" + temp + ", " + "\\0" + ");\n";
					$$.label = "\tstrcpy(" + temp + ", " + "\"\\0\"" + ");\n";
					//  $$.traducao = "\t" + temp + " = " + "'" + "\\0" + "'" + ";\n";
				}
			}

			| TK_VAR TK_ID TIPO '=' INICIALIZA_MULTI 
			{
				$$.tipo = $3.tipo;
				bool encontrei = buscaVariavel($2.label); 
				string temp = gentempcode();

				if(encontrei)
					error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m A variavel '" + $2.label + "' já foi declarada\n";


				if ($3.isVector){
					if ($3.tipo != $5.tipo) error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Não é permirtido tipos diferentes na inicialização do vetor (" + $2.label + ")\n";

					cout << "Num_elementos_iniciados = " + std::to_string(num_elementos_iniciados) + " sizeVector = " + std::to_string($3.sizeVector) << endl;

					if (num_elementos_iniciados > $3.sizeVector) error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Excesso de elementos para o vetor (" + $2.label + ")\n";
					addVector($2.label, $3.tipo, temp, $3.vetor, $5.conteudo);
					num_elementos_iniciados = 0;
				}
				
				else if ($3.tipo == $5.tipo && $3.tipo == "string"){
					addStr($2.label, "string", temp, $5.conteudo);
					$$.traducao = $5.traducao + "\tstrcpy(" + temp + ", " + $5.label + ");\n"; 
				}

				
				else if ($3.tipo == $5.tipo){
					addSimbolo($2.label, $3.tipo, temp);
			
					$$.traducao = $2.traducao + $5.traducao + "\t" + temp + " = " + $5.label + ";\n";
					$$.label = $3.tipo + $2.label + " = " + $5.label;
				}

				else if($3.tipo == "bool"){ 
					if($5.tipo != "bool"){
						error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m valor (" + $5.conteudo + ") inválido para o tipo bool\n";
					}
						
					addSimbolo($2.label, "bool", temp);
					string val_bool;
					
					if ($5.label_bool == "True") val_bool = "1";
					else val_bool = "0";

					$$.traducao = "\t" + temp + " = " + val_bool + ";\n";
					$$.label = "int " + $2.label + " = " + $5.label;
				}

				else if ($3.tipo == "int"){
					cout << "primeiro é inteiro\n";
					if ($5.tipo == "float"){
						cout << "segundo é float\n";
						addSimbolo($2.label, "int", temp);
						$$.traducao = "\t" + temp + " = 0" + ";\n"; 
						
						$$.label = gentempcode();
						addSimbolo($$.label, "int", $$.label);
						$$.traducao = $5.traducao + "\t" + $$.label + " = (int) " + $5.label + ";\n" + 
						"\t" + temp + " = " + $$.label + ";\n";
					}

					if ($5.tipo == "char"){
						addSimbolo($2.label, "int", temp);
						// $$.traducao = "\t" + temp + " = 0" + ";\n"; 
						
						$$.label = gentempcode();
						addSimbolo($$.label, "int", $$.label);
						$$.traducao = $5.traducao + "\t" + $$.label + " = (int) " + $5.label + ";\n" + 
						"\t" + temp + " = " + $$.label + ";\n";
					}
				}

				else if ($3.tipo == "float"){
					if ($5.tipo == "int"){
					addSimbolo($2.label, "float", temp);
					$$.traducao = "\t" + temp + " = 0" + ";\n"; 
					
					$$.label = gentempcode();
					addSimbolo($$.label, "float", $$.label);
					$$.traducao = $5.traducao + "\t" + $$.label + " = (float) " + $5.label + ";\n" + 
					"\t" + temp + " = " + $$.label + ";\n";
					}
				}

				else if ($3.tipo == "char"){
					if ($5.tipo == "int"){
						addSimbolo($2.label, "char", temp);
						$$.traducao = "\t" + temp + " = 0" + ";\n"; 
						
						$$.label = gentempcode();
						addSimbolo($$.label, "char", $$.label);
						$$.traducao = $5.traducao + "\t" + $$.label + " = (char) " + $5.label + ";\n" + 
						"\t" + temp + " = " + $$.label + ";\n";
					}

					if ($5.tipo == "float"){
						addSimbolo($2.label, "char", temp);
						$$.traducao = "\t" + temp + " = 0" + ";\n"; 
						
						$$.label = gentempcode();
						addSimbolo($$.label, "char", $$.label);
						$$.traducao = $5.traducao + "\t" + $$.label + " = (char) " + $5.label + ";\n" + 
						"\t" + temp + " = " + $$.label + ";\n";
					}
				}

				else error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Atribuição inválida para a variável (" + $2.label + ")\n";
			}

			| TK_VAR TK_ID TK_DOIS_PTS_IGUAL INICIALIZA_MULTI 
			{
				$$.tipo = $4.tipo;
				bool encontrei = buscaVariavel($2.label); 
				string temp = gentempcode();

				if(encontrei)
					error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m A variavel '" + $2.label + "' já foi declarada\n";

				
				else if ($4.tipo == "string"){
					addStr($2.label, "string", temp, $4.conteudo);
					$$.traducao = $4.traducao + "\tstrcpy(" + temp + ", " + $4.label + ");\n"; 
				}

				else if($4.tipo == "bool"){ 	
					addSimbolo($2.label, "bool", temp);
					string val_bool;
					
					if ($4.label_bool == "True") val_bool = "1";
					else val_bool = "0";

					$$.traducao = "\t" + temp + " = " + val_bool + ";\n";
					$$.label = "int " + $2.label + " = " + $4.label;
				}

				else if ($4.tipo != "string" && $4.tipo != "bool") {
					addSimbolo($2.label, $4.tipo, temp);

					$$.traducao = $4.traducao + "\t" + temp + " = " + $4.label + ";\n";
					$$.label = $4.tipo + $2.label;
				}

				else error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Atribuição inválida para a variável (" + $2.label + ")\n";
			}

			| TK_VAR TK_ID
			{
				bool encontrei = buscaVariavel($2.label);
							
				if(encontrei)
					error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m A variavel '" + $2.label + "' já foi declarada\n";

				error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m A variável '" + $2.label + "' não pode ser inicializada sem um tipo.\n";
			}

			| TK_VAR TK_ID TK_DOIS_PTS_IGUAL 
			{
				bool encontrei = buscaVariavel($2.label);
							
				if(encontrei)
					error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m A variavel '" + $2.label + "' já foi declarada\n";

				error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m A variável '" + $2.label + "' não pode ser inicializada sem um valor após ':='.\n";
			}

			| TK_VAR TK_ID '=' INICIALIZA_MULTI
			{
				bool encontrei = buscaVariavel($2.label);
							
				if(encontrei)
					error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m A variavel '" + $2.label + "' já foi declarada\n";

				error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Não foi declarado um tipo para a variável '" + $2.label + "'.\n";
			} 

			| TK_VAR TK_ID TIPO TK_DOIS_PTS_IGUAL INICIALIZA_MULTI
			{
				bool encontrei = buscaVariavel($2.label);
							
				if(encontrei)
					error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m A variavel '" + $2.label + "' já foi declarada\n";

				error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m A variável '" + $2.label + "' Declarada com o operador ':=' não dever ter tipo definido.\n";
			}
			;


VETOR 	: '[' TK_NUM ']'
		{
			$$.sizeVector = stoi($2.label);

			$$.label = "[" + $2.label + "]";
			$$.traducao = $$.label;
		}

		| '[' TK_ID ']'
		{
			bool encontrei = buscaVariavel($2.label);
			if (!encontrei) error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Variável (" + $2.label + "Não declarada.\n";

			else{
				TIPO_SIMBOLO var = getSimbolo($2.label);
				if (var.tipoVariavel != "int") error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Tamanho do vetor (" + var.nomeVariavel + ") deve ser um inteiro\n";
				$$.label = "[" + var.tempVariavel + "]";
				$$.traducao = "[" + var.tempVariavel + "]";
			}
		}

		| '[' ']'
		{
			$$.label = "[]";
			$$.traducao = $$.label;
			$$.sizeVector = 500;
		}
		;

CONTROLE_LACO	: TK_BREAK 
				{
					TIPO_LOOP loop = getLaceBreak();
					$$.traducao = "\tgoto " + loop.fimLaco + ";\n";
				}

				| TK_CONTINUE 
				{
					TIPO_LOOP loop = getLaceBreak();
					$$.traducao = "\tgoto " + loop.nomeLaco + ";\n";
				}
				;

COMANDO 	: E ';'

			| E

			| TERNARIO
			{
				$$.traducao = $1.traducao;
			}

			| TERNARIO ';'
			{
				$$.traducao = $1.traducao;
			}

			| DECLARA_VAR 
			{
				$$.traducao = $1.traducao;
			}

			| DECLARA_VAR ';' 
			{
				$$.traducao = $1.traducao;
			}

			| CHAMA_FUNCAO
			{
				$$.traducao = $1.traducao;
			}

			| CHAMA_FUNCAO ';'
			{
				$$.traducao = $1.traducao;
			}

			| CONTROLE_LACO
			{
				$$.traducao = $1.traducao;
			}

			| CONTROLE_LACO ';'
			{
				$$.traducao = $1.traducao;
			}

			| POW
			{
				$$.traducao = $1.traducao;
			}

			| POW ';'
			{
				$$.traducao = $1.traducao;
			}

			| SQRT
			{
				$$.traducao = $1.traducao;
			}

			| SQRT ';'
			{
				$$.traducao = $1.traducao;
			} 
			;

POW		: TK_POW '(' INICIALIZA ',' INICIALIZA ')'
		{
			if (($3.tipo == "int" && $5.tipo == "int") || ($3.tipo == "int" && $5.tipo == "float") 
				|| ($3.tipo == "float" && $5.tipo == "float") || ($3.tipo == "float" && $5.tipo == "int")) 
			{
				int base = stoi($3.conteudo);
				int exp = stoi($5.conteudo);
			
				$$.traducao = $3.traducao + $5.traducao;
				
				string temp = gentempcode();				
				string temp2 = gentempcode();
				string result = gentempcode();
				string zero = gentempcode();
				addSimbolo(temp, "bool", temp);
				addSimbolo(temp2, "bool", temp2);
				addSimbolo(result, "float", result);
				addSimbolo(zero, "int", zero);
				string lace = genLacecode();
				string jump = label_jump();
				string inicio_loop = "INICIO_POW_" + jump;
				string fim_loop = "FIM_POW_" + jump;
				string cond_inicial = $5.label + " != " + zero + ";\n";

				string condicao = temp + " = !" + temp2;

				$$.traducao = $3.traducao + $5.traducao + "\t" + zero + " = 0; //zero\n" + "\t" + 
				result + " = 1.0; //resultado\n" + inicio_loop + ":\n" +
				lace + ":\n" + "\t" + temp2 + " = " + cond_inicial + "\t" + condicao + ";\n" +
				"\n\tif (" + temp + ") goto " + fim_loop + ";\n" +
			 	"\t" + result + " = " + result + " * " + $3.label + ";\n" +
				"\t" + $5.label + " = " + $5.label + " -1;\n" +
				"\tgoto " + lace + ";\n" +
				fim_loop + ":\n\n";

				$$.label = result;
			}
			else error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Parâmetro inválido para potência (pow)\n";
		}

		| TK_POW '(' ')'
		{
			error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m O comando (pow) precisa de dois parâmetros\n";
		}

		| TK_POW '(' INICIALIZA ')'
		{
			error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m O comando (pow) precisa de dois parâmetros\n"; 
		}
		;

SQRT 	: TK_SQRT '(' INICIALIZA ')'
		{
			if ($3.tipo == "int" || $3.tipo == "float"){

				//precisão
				string temp1 = gentempcode(); 
				addSimbolo(temp1, "float", temp1);
				string precisao = "\t" + temp1 + " = 0.000001; // precisao\n";

				// Número 1
				string temp2 = gentempcode(); 
				addSimbolo(temp2, "float", temp2);
				string num_1 = "\t" + temp2 + " = 1; //num_1\n";

				// Número 2
				string temp9 = gentempcode(); 
				addSimbolo(temp9, "float", temp9);
				string num_2 = "\t" + temp9 + " = 2; //num_2 raiz quadrada\n";

				//Input
				string temp3 = gentempcode(); 
				addSimbolo(temp3, "float", temp3);
				string input = temp3 + " = " + $3.label + "; //input\n";

				// Aux Input 
				string temp7 = gentempcode(); 
				addSimbolo(temp7, "float", temp7);
				string aux_input = "\t" + temp7 + " = " + $3.label + "; // aux_input\n";

				// Cond_1 Aux_input - num_1
				string temp4 = gentempcode(); 
				addSimbolo(temp4, "int", temp4);
				string cond1 = "\t" + temp4 + " = " + temp7 + " - " + temp2 + "; //Aux_input - num_1\n";

				// Condição Final
				string temp5 = gentempcode(); 
				addSimbolo(temp5, "bool", temp5);
				string cond_final = "\t" + temp5 + " = " + temp4 + " >= " + temp1 + "; // condição final\n";
				
				// Nega condição Final
				string temp6 = gentempcode(); 
				addSimbolo(temp6, "bool", temp6);
				string condicao = "\t" + temp6 + " = !" + temp5 + "; //Nega cond_final\n";

				// Resultado
				string temp8 = gentempcode(); 
				addSimbolo(temp8, "float", temp8);
				string result = "\t" + temp8 + " = 0; // resultado\n";

				// num_1 + aux_input
				string temp10 = gentempcode(); 
				addSimbolo(temp10, "float", temp10);
				string operacao_1 = "\t" + temp10 + " = " + temp2 + " + " + temp7 + "; // num_1 + aux_input\n";

				// (num_1 + aux_input) / num_2
				string temp11 = gentempcode(); 
				addSimbolo(temp11, "float", temp11);
				string operacao_2 = "\t" + temp11 + " = " + temp10 + " / " + temp9 + "; // (num_1 + aux_input) / num_2\n";

				// Input / aux_input
				string temp12 = gentempcode(); 
				addSimbolo(temp12, "float", temp12);
				string operacao_3 = "\t" + temp12 + " = " + $3.label + " / " + temp7 + "; // Input / aux_input\n";

				// Jumpers
				string lace = genLacecode();
				string jump = label_jump();
				string inicio_loop = "INICIO_SQRT_" + jump;
				string fim_loop = "FIM_SQRT_" + jump;

				$$.traducao = $3.traducao + precisao + aux_input + num_1 + num_2 + result + 
				inicio_loop + ":\n" +
				lace + ":\n" + cond1 + cond_final + condicao +
				"\n\tif (" + temp6 + ") goto " + fim_loop + ";\n" +
			 	operacao_1 + operacao_2 + "\t" + temp7 + " = " + temp11 + ";\n" +
				operacao_3 + "\t" + temp2 + " = " + temp12 + ";\n" + "\t" + temp8 + " = " + temp7 + ";\n" +
				"\tgoto " + lace + ";\n" +
				fim_loop + ":\n\n";

				$$.label = temp8;
			}
			// error += "\033[1;31mError\033[0m - \033[1;36mLinha " + contLinha +  ":\033[0m\033[1;39m Operandos com tipos inválidos.\n";
			else error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Parâmetro inválido para ráiz quadrada (sqrt)";
		}

		| TK_SQRT '(' ')'
		{
			error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m O comando (sqrt) precisa de um parâmetro real.\n"; 
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
					if ($1.tipo == "string"){
						$$.tipo = $1.tipo;
						$$.traducao = $1.traducao + $3.traducao + "\t" + 
						"strcat(" + $1.label + ", " + $3.label + ");\n";
						addSimbolo($$.label, $$.tipo, $$.label);
					}

					else{
						$$.tipo = $1.tipo;
						$$.traducao = $1.traducao + $3.traducao + "\t" + 
						$$.label + " = " + $1.label + " + " + $3.label + ";\n";
						addSimbolo($$.label, $$.tipo, $$.label);
					}
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
				
				else error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Cast inválido\n";
				
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
				
				else error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Cast inválido\n";
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
				
				else error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Cast inválido\n";
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
					error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Operação inválida, Divisão por 0\n";
				}

				else{
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
						error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Divisão inválida\n";
					}
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
					error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Operação não permitida no tipo float\n";
				}
			}

			| TK_ID TK_MAIS_MAIS
			{
				// bool encontrei = buscaVariavel($1.label);
				// if (!encontrei) error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Variável (" + $1.label + ") Não declarada. //TK_ID TK_MAIS_MAIS\n";

				// else{
					TIPO_SIMBOLO var1 = getSimbolo($1.label);
					$$.traducao = $1.traducao + $2.traducao + "\t" + 
					var1.tempVariavel + " = " + var1.tempVariavel + " + 1" + ";\n";
				// }
			}

			| TK_ID TK_MENOS_MENOS
			{
				// bool encontrei = buscaVariavel($1.label);
				// if (!encontrei) error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Variável (" + $1.label + "Não declarada.\n";

				// else {
					TIPO_SIMBOLO var1 = getSimbolo($1.label);
					$$.traducao = $1.traducao + $2.traducao + "\t" + 
					var1.tempVariavel + " = " + var1.tempVariavel + " - 1" + ";\n";
				// }
			}

			//OPERADORES RELACIONAIS

			| E '>' E
			{
				string temp = gentempcode();
				$$.label = temp;
				$$.tipo = "bool";
				$$.temp = temp;

				relacionalInvalida($1.tipo, $3.tipo);

				if ($1.tipo == $3.tipo && $1.tipo != "string"){				
					addSimbolo($$.label, "bool", $$.label);
					$$.traducao = $1.traducao + $3.traducao + "\t" + 
					$$.label + " = " + $1.label + " > " + $3.label + ";\n";
				}

				else if ($1.tipo == "int" && $3.tipo == "float"){
					addSimbolo(temp, "bool", temp);
					$$.traducao = "\t" + temp + " = 0" + ";\n"; 
					
					$$.label = gentempcode();
					
					addSimbolo($$.label, "int", $$.label);
					$$.traducao = $1.traducao + $3.traducao + $$.traducao + "\t" + $$.label + " = (int) " + $3.label + ";\n" + 
					"\t" + temp + " = " + $1.label + " > " + $$.label + ";\n";

					$$.label = temp;
				}

				else if ($1.tipo == "float" && $3.tipo == "int"){
					addSimbolo(temp, "bool", temp);
					$$.traducao = "\t" + temp + " = 0" + ";\n"; 
					
					$$.label = gentempcode();
					addSimbolo($$.label, "int", $$.label);
					$$.traducao = $1.traducao + $3.traducao + $$.traducao + "\t" + $$.label + " = (float) " + $3.label + ";\n" + 
					"\t" + temp + " = " + $1.label + " > " + $$.label + ";\n";

					$$.label = temp;
				}
				
			}
			
			| E '<' E
			{
				string temp = gentempcode();
				$$.label = temp;
				$$.tipo = "bool";
				$$.temp = temp;

				relacionalInvalida($1.tipo, $3.tipo);

				if ($1.tipo == $3.tipo && $1.tipo != "string"){				
					addSimbolo($$.label, "bool", $$.label);
					$$.traducao = $1.traducao + $3.traducao + "\t" + 
					$$.label + " = " + $1.label + " < " + $3.label + ";\n";
				}

				else if ($1.tipo == "int" && $3.tipo == "float"){
					addSimbolo(temp, "bool", temp);
					$$.traducao = "\t" + temp + " = 0" + ";\n"; 
					
					$$.label = gentempcode();
					addSimbolo($$.label, "int", $$.label);
					$$.traducao = $1.traducao + $3.traducao + $$.traducao + "\t" + $$.label + " = (int) " + $3.label + ";\n" + 
					"\t" + temp + " = " + $1.label + " < " + $$.label + ";\n";

					$$.label = temp;
				}

				else if ($1.tipo == "float" && $3.tipo == "int"){
					addSimbolo(temp, "bool", temp);
					$$.traducao = "\t" + temp + " = 0" + ";\n"; 
					
					$$.label = gentempcode();
					addSimbolo($$.label, "int", $$.label);
					$$.traducao = $1.traducao + $3.traducao + $$.traducao + "\t" + $$.label + " = (float) " + $3.label + ";\n" + 
					"\t" + temp + " = " + $1.label + " < " + $$.label + ";\n";

					$$.label = temp;
				}
			}

			| E TK_MAIOR_IGUAL E
			{
				string temp = gentempcode();
				$$.label = temp;
				$$.tipo = "bool";

				relacionalInvalida($1.tipo, $3.tipo);

				if ($1.tipo == $3.tipo && $1.tipo != "string"){				
					addSimbolo($$.label, "bool", $$.label);
					$$.traducao = $1.traducao + $3.traducao + "\t" + 
					$$.label + " = " + $1.label + " >= " + $3.label + ";\n";
				}

				else if ($1.tipo == "int" && $3.tipo == "float"){
					addSimbolo(temp, "bool", temp);
					$$.traducao = "\t" + temp + " = 0" + ";\n"; 
					
					$$.label = gentempcode();
					addSimbolo($$.label, "int", $$.label);
					$$.traducao = $1.traducao + $3.traducao + $$.traducao + "\t" + $$.label + " = (int) " + $3.label + ";\n" + 
					"\t" + temp + " = " + $1.label + " >= " + $$.label + ";\n";

					$$.label = temp;
				}

				else if ($1.tipo == "float" && $3.tipo == "int"){
					addSimbolo(temp, "bool", temp);
					$$.traducao = "\t" + temp + " = 0" + ";\n"; 
					
					$$.label = gentempcode();
					addSimbolo($$.label, "int", $$.label);
					$$.traducao = $1.traducao + $3.traducao + $$.traducao + "\t" + $$.label + " = (float) " + $3.label + ";\n" + 
					"\t" + temp + " = " + $1.label + " >= " + $$.label + ";\n";

					$$.label = temp;
				}
			}
			
			| E TK_MENOR_IGUAL E
			{
				string temp = gentempcode();
				$$.label = temp;
				$$.tipo = "bool";

				relacionalInvalida($1.tipo, $3.tipo);

				if ($1.tipo == $3.tipo && $1.tipo != "string"){				
					addSimbolo($$.label, "bool", $$.label);
					$$.traducao = $1.traducao + $3.traducao + "\t" + 
					$$.label + " = " + $1.label + " <= " + $3.label + ";\n";
				}

				else if ($1.tipo == "int" && $3.tipo == "float"){
					addSimbolo(temp, "bool", temp);
					$$.traducao = "\t" + temp + " = 0" + ";\n"; 
					
					$$.label = gentempcode();
					addSimbolo($$.label, "int", $$.label);
					$$.traducao = $1.traducao + $3.traducao + $$.traducao + "\t" + $$.label + " = (int) " + $3.label + ";\n" + 
					"\t" + temp + " = " + $1.label + " <= " + $$.label + ";\n";

					$$.label = temp;
				}

				else if ($1.tipo == "float" && $3.tipo == "int"){
					addSimbolo(temp, "bool", temp);
					$$.traducao = "\t" + temp + " = 0" + ";\n"; 
					
					$$.label = gentempcode();
					addSimbolo($$.label, "int", $$.label);
					$$.traducao = $1.traducao + $3.traducao + $$.traducao + "\t" + $$.label + " = (float) " + $3.label + ";\n" + 
					"\t" + temp + " = " + $1.label + " <= " + $$.label + ";\n";

					$$.label = temp;
				}
			}

			| E TK_IGUAL_IGUAL E
			{
				string temp = gentempcode();
				$$.label = temp;
				$$.tipo = "bool";

				relacionalInvalida($1.tipo, $3.tipo);

				if ($1.tipo == $3.tipo && $1.tipo != "string"){				
					addSimbolo($$.label, "bool", $$.label);
					$$.traducao = $1.traducao + $3.traducao + "\t" + 
					$$.label + " = " + $1.label + " == " + $3.label + ";\n";
				}

				else if ($1.tipo == "int" && $3.tipo == "float"){
					addSimbolo(temp, "bool", temp);
					$$.traducao = "\t" + temp + " = 0" + ";\n"; 
					
					$$.label = gentempcode();
					addSimbolo($$.label, "int", $$.label);
					$$.traducao = $1.traducao + $3.traducao + $$.traducao + "\t" + $$.label + " = (int) " + $3.label + ";\n" + 
					"\t" + temp + " = " + $1.label + " == " + $$.label + ";\n";
					
					$$.label = temp;
				}

				else if ($1.tipo == "float" && $3.tipo == "int"){
					addSimbolo(temp, "bool", temp);
					$$.traducao = "\t" + temp + " = 0" + ";\n"; 
					
					$$.label = gentempcode();
					addSimbolo($$.label, "int", $$.label);
					$$.traducao = $1.traducao + $3.traducao + $$.traducao + "\t" + $$.label + " = (float) " + $3.label + ";\n" + 
					"\t" + temp + " = " + $1.label + " == " + $$.label + ";\n";

					$$.label = temp;
				}
			}

			//OPERADORES LÓGICOS
			| E TK_DIFERENTE E
			{
				relacionalInvalida($1.tipo, $3.tipo);
				$$.label = gentempcode();
				$$.tipo = "bool";
				addSimbolo($$.label, "bool", $$.label);
				$$.traducao = $1.traducao + $3.traducao + "\t" + 
				$$.label + " = " + $1.label + " != " + $3.label + ";\n";
			}

			| E TK_OU E
			{
				$$.label = gentempcode();
				$$.tipo = "bool";
				addSimbolo($$.label, "bool", $$.label);
				$$.traducao = $1.traducao + $3.traducao + "\t" + 
				$$.label + " = " + $1.label + " || " + $3.label + ";\n";
			}

			| E TK_E E
			{
				cout << "Traduções -> " + $1.traducao + $3.traducao << endl;
				$$.label = gentempcode();
				$$.tipo = "bool";
				addSimbolo($$.label, "bool", $$.label);
				$$.traducao = $1.traducao + $3.traducao + "\t" + $$.label + " = " + $1.label + " && " + $3.label + ";\n";
			}

			| '!' E
			{
				$$.label = gentempcode();
				$$.tipo = "bool";
				addSimbolo($$.label, $$.tipo, $$.label);
				$$.traducao = $2.traducao + "\t" + 
				$$.label + " = " + "!" + $2.label + ";\n";
			}

			//OPERADORES DE ATRIBUIÇÃO
			| TK_ID '=' CHAMA_FUNCAO 
			{
				cout << "Chamando Função\n";

				// if (!buscaVariavel($1.label)) yyerror("Erro: Variável (" + $1.label + ") não Declarada");

				// TIPO_SIMBOLO var = getSimbolo($1.label);

				// if(var.tipoVariavel == $3.tipo){
				// 	if (var.tipoVariavel == "string"){
				// 		cout << "$3.traducao no = " + $3.traducao << endl;
				// 		$$.traducao = $3.traducao + "\tstrcpy(" + var.tempVariavel + ", " + $3.label + ");\n"; 
				// 	}
				// }
			}

			| TK_ID '=' POW
			{
				bool encontrei = buscaVariavel($1.label);
				if (!encontrei) error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Variável (" + $1.label + "Não declarada.\n";

				else{
					TIPO_SIMBOLO var = getSimbolo($1.label);
					
					if (var.tipoVariavel != "float") error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m A variável (" + var.tipoVariavel + " " + var.nomeVariavel + ") não pode receber o retorno float do comando pow()\n";

					else $$.traducao = $1.traducao + $3.traducao + "\t" + var.tempVariavel + " = " + $3.label + ";\n";
				}
			}

			| TK_ID '=' SQRT
			{
				bool encontrei = buscaVariavel($1.label);
				if (!encontrei) error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Variável (" + $1.label + "Não declarada.\n";

				else{
					TIPO_SIMBOLO var = getSimbolo($1.label);
					
					if (var.tipoVariavel != "float") error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m A variável (" + var.tipoVariavel + " " + var.nomeVariavel + ") não pode receber o retorno float do comando sqrt()\n";

					else $$.traducao = $1.traducao + $3.traducao + "\t" + var.tempVariavel + " = " + $3.label + ";\n";
				}
			}
						
			| TK_ID '=' E
			{
				bool encontrei = buscaVariavel($1.label);
				bool busca_fun = buscaRetorno($1.label);
				if (!encontrei && !busca_fun) error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Variável(" + $1.label + "Não declarada.\n";

				else{
					TIPO_SIMBOLO var = getSimbolo($1.label);
					
					// if($1.tipo == "bool"){ 
					// 	if($3.tipo != "bool"){
					// 		yyerror("Erro: valor (" + $3.conteudo + ") inválido para o tipo bool" );
					// 	}
						
					// 	string temp = gentempcode();
					// 	addSimbolo($2.label, "bool", temp);
					// 	string val_bool;
						
					// 	if ($3.label_bool == "True") val_bool = "1";
					// 	else val_bool = "0";

					// 	$$.traducao = "\t" + temp + " = " + val_bool + ";\n";
					// 	$$.label = "int " + $2.label + " = " + $3.label;
					// }

					if(var.tipoVariavel == $3.tipo){
						if (var.tipoVariavel == "string"){
							// cout << "$3.traducao no = " + $3.traducao << endl;
							$$.traducao = $1.traducao + $3.traducao + "\tstrcpy(" + var.tempVariavel + ", " + $3.label + ");\n"; 
						}
		
						else{
							$$.traducao = $1.traducao + $3.traducao + "\t" + 
							var.tempVariavel + " = " + $3.label + ";\n";
						}
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
						error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Atribuição inviavel\n";
					}
				}
			}

			| TK_ID '=' INICIALIZA
			{
				bool encontrei = buscaVariavel($1.label);
				if (!encontrei) {
					error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Variável (" + $1.label + ") Não Declarada.\n";
				}

				else{
					TIPO_SIMBOLO var = getSimbolo($1.label);

					if(var.tipoVariavel == $3.tipo){
						if (var.tipoVariavel == "string"){
							$$.traducao = $3.traducao + "\tstrcpy(" + var.tempVariavel + ", " + $3.label + ");\n"; 
						}
		
						else{
							$$.traducao = $1.traducao + $3.traducao + "\t" + 
							var.tempVariavel + " = " + $3.label + ";\n";
						}
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
						error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Atribuição inviavel\n";
					}
				}
			}

			| INICIALIZA
			{
				$$.tipo = $1.tipo;
				$$.conteudo = $1.conteudo;
				$$.label = $1.label;
				$$.traducao = $1.traducao;
			}
	
			| TK_ID
			{
				// bool encontrei = buscaVariavel($1.label);
				// if (!encontrei) error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Variável #####(" + $1.label + ") Não Declarada.\n";

				// else{
					TIPO_SIMBOLO variavel = getSimbolo($1.label);	
					$$.tipo = variavel.tipoVariavel;
					$$.label = variavel.tempVariavel;
					$$.temp = $$.label;
				// }
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
					error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Cast Inválido\n";
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
				
				else error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Operacao invalida\n";
			}

			// IO
			| TK_PRINTLN '(' E ')'
			{
				$$.traducao = $3.traducao + "\tcout << " + $3.label + " << endl;\n";
				// cout << "tradução " + $3.traducao << endl;
			}
			
			| TK_PRINT '(' E ')'
			{
				// cout << "traducao no print -> \n"+ $3.traducao + "\n label -> " + $3.label << endl;
				// if ($3.tipo == "string")
				// 	$$.traducao = "\tcout << " + $3.label + ";\n";	
				
				// else
					$$.traducao = $3.traducao + "\tcout << " + $3.label + ";\n";
				
			}

			| TK_SCAN '(' '&' TK_ID ')'
			{
				$$.label = gentempcode();
				$$.tipo = $4.tipo;

				bool encontrei = buscaVariavel($4.label);
				if (!encontrei) error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Variável (" + $4.label + ") Não declarada.\n";
				
				TIPO_SIMBOLO var = getSimbolo($4.label);

				$$.traducao = $4.traducao + "\tcin >> " + var.tempVariavel + ";\n" + $3.traducao; 
			} 
			;

%%

#include "lex.yy.c"

int yyparse();

string gentempcode(){
	var_temp_qnt++;
	return "t" + std::to_string(var_temp_qnt);
}

string genLacecode(){
	var_lace_qnt++;
	return "_L" + std::to_string(var_lace_qnt);	
}

string genCondcode(){
	var_cond_qnt++;
	return "FIM_IF_" + std::to_string(var_cond_qnt);
}

string genLaceNameCode(){
	var_lace_name_qnt++;
	return "loop_" + std::to_string(var_lace_name_qnt);
}

string label_jump(){
	num_jump++;
	return "J" + std::to_string(num_jump);
}

void addSimbolo(string nome, string tipo, string temp){
	TIPO_SIMBOLO var;
	var.nomeVariavel = nome;
	var.tipoVariavel = tipo;
	var.tempVariavel = temp;

	int contexto = mapa.size() - 1;
	mapa[contexto].push_back(var);
	
	print_var(var);				
}

void addVarFunc(string nome, string tipo, string temp){
	TIPO_SIMBOLO var;
	var.nomeVariavel = nome;
	var.tipoVariavel = tipo;
	var.tempVariavel = temp;
	var.varDeFunc = true;

	tabelaVarFunc.push_back(var);

	int contexto = mapa.size() - 1;
	mapa[contexto].push_back(var);
	
}

void addStr(string nome, string tipo, string temp, string conteudo){
	TIPO_SIMBOLO var;
	var.nomeVariavel = nome;
	var.tipoVariavel = tipo;
	var.tempVariavel = temp;
	var.conteudo = conteudo;

	int contexto = mapa.size() - 1;
	mapa[contexto].push_back(var);		
	print_var(var);		
}

void addVector(string nome, string tipo, string temp, string vetor, string conteudo){
	TIPO_SIMBOLO var;
	var.nomeVariavel = nome;
	var.tipoVariavel = tipo;
	var.tempVariavel = temp;
	var.vetor = vetor;
	var.conteudo = conteudo;

	int contexto = mapa.size() - 1;
	mapa[contexto].push_back(var);		
	print_var(var);		
}

void print_var(TIPO_SIMBOLO var){
	if (var.tipoVariavel == "bool") var.tipoVariavel = "int";

	if (var.tipoVariavel == "string"){
		var.tipoVariavel = "char";
		if (var.conteudo == "\0"){
			declaracoes += "\t" + var.tipoVariavel + " " + var.tempVariavel + "[" + strGeralSize + "];\t//" + var.nomeVariavel + "\n";
		}
		
		else{
			int size = getLength(var.conteudo) - 2; // O -2 remove as aspas que vem junto da string 
			declaracoes += "\t" + var.tipoVariavel + " " + var.tempVariavel + "[" + std::to_string(size) + "];\t//" + var.nomeVariavel + "\n";
		}
	}
	else if (var.vetor != ""){
		declaracoes += "\t" + var.tipoVariavel + " " + var.tempVariavel + var.vetor + " = {" + var.conteudo + "};\n";
	}
	else{
		declaracoes += "\t" + var.tipoVariavel + " " + var.tempVariavel + ";\n";
	}			

}

bool buscaVariavel(string variavel){
	
	int contexto = mapa.size() - 1;
	vector<TIPO_SIMBOLO> tabelaSimbolos;
	tabelaSimbolos = mapa[contexto];

	for(int i = 0; i < tabelaSimbolos.size(); i++)
	{
		if(tabelaSimbolos[i].nomeVariavel == variavel)
		{
			return true;
		}
	}
	return false;
}

TIPO_SIMBOLO getSimbolo(string variavel){
	
	int contexto = mapa.size() - 1;
	vector<TIPO_SIMBOLO> tabelaSimbolos;
	tabelaSimbolos = mapa[contexto];

	while(contexto >= 0)
	{
		for (int i = tabelaSimbolos.size() - 1; i >= 0; i--)
		{
			cout << tabelaSimbolos[i].nomeVariavel + " == " + variavel + "? \n";
			if(tabelaSimbolos[i].nomeVariavel == variavel)
			{
				cout << "To retornando!!!\n";
				cout << tabelaSimbolos[i].tipoVariavel + " " + tabelaSimbolos[i].nomeVariavel + " " + tabelaSimbolos[i].tempVariavel << endl;
				return tabelaSimbolos[i];
			}				
		}
		contexto--;
		tabelaSimbolos = mapa[contexto];
	}
	
	yyerror("\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Variavel *(" + variavel + ")* não declarada\n");
	exit(0);
	
}

TIPO_SIMBOLO getRetorno(string retorno){
	
	for (int i = tabelaVarFunc.size() - 1; i >= 0; i--)
	{
		if(tabelaVarFunc[i].nomeVariavel == retorno)
		{
			return tabelaVarFunc[i];
		}				
	}
	exit(0);
}

bool buscaRetorno(string retorno){
	
	for (int i = tabelaVarFunc.size() - 1; i >= 0; i--)
	{
		if(tabelaVarFunc[i].nomeVariavel == retorno)
		{
			return true;
		}				
	}
	return false;
}

//Conversão implícita
string cast(string tipo1, string tipo2){
	
	if (tipo1 == "int" && tipo2 == "float" || tipo1 == "float" && tipo2 == "int")
		return "(float) ";
	
	error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Casting inválido\n";
	exit(0);
}

bool comparaTipo(string tipo1, string tipo2){
	if (tipo1 == tipo2) return true;

	return false;
}

void relacionalInvalida(string tipo1, string tipo2){
	if (tipo1 == "char" || tipo2 == "char" || tipo1 == "bool" || tipo2 == "bool") {
		error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Relacional Inválido\n";
	}
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

int getLength(string str){
	int i = 0;
	while (str[i] != '\0') i++;

	return i+1;
}


int main( int argc, char* argv[] )
{	
	var_temp_qnt = 0;
	contextoGlobal = 0;
	num_elementos_iniciados = 0;
	vector<TIPO_SIMBOLO> tabelaSimbolos;
	mapa.push_back(tabelaSimbolos);
	
	cout << std::to_string(mapa.size()) << endl;

	yyparse();

	return 0;
}

void yyerror( string MSG )
{
	cout << MSG << endl;
	exit (0);
}				

void pushContexto(){
	vector<TIPO_SIMBOLO> tabelaSimbolos;
	mapa.push_back(tabelaSimbolos);
}

void popContexto(){
	mapa.pop_back();
}

void pushLoop(string tipo){

	TIPO_LOOP aux;
	aux.nomeLaco = "loop_" + std::to_string(var_lace_name_qnt);
	aux.tipoLaco = tipo;
	aux.fimLaco = genCondcode();
	aux.contexto = mapa.size();
	tabelaLoop.push_back(aux);
}

TIPO_LOOP getLace(string nome){

	for (int i = tabelaLoop.size() - 1; i >= 0; i--)
	{ 
		if(tabelaLoop[i].nomeLaco == nome){
			return tabelaLoop[i];
		}
	}
	exit(0);
}

TIPO_LOOP getLaceBreak(){
	int size = tabelaLoop.size();

	if(size == 0){
		error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Comando continue/break fora de laco\n";
	}

	return tabelaLoop[size - 1];
}


void contLinha(){
	num_linha++;
	linha_atual = std::to_string(num_linha);
}

void addFunc(string nome, string tipo){
	TIPO_FUNC new_func;
	new_func.nomeFunc = nome;
	new_func.tipo = tipo;
	/* new_func.varRetorno = varRetorno; */
	/* new_func.conteudoRetorno = conteudoRetorno; */

	tabelaFunc.push_back(new_func);
}

TIPO_FUNC getFunc(string func){
	for (int i = tabelaFunc.size() - 1; i >= 0; i--)
	{
		if(tabelaFunc[i].nomeFunc == func)
		{
			return tabelaFunc[i];
		}				
	}
	
	error += "\033[1;31mError\033[0m - \033[1;36mLinha " + linha_atual + ":\033[0m\033[1;39m Função (" + func + ") Função não Declarada" + "\n";
	exit(0);
}

bool buscaFunc(string func){
	for (int i = tabelaFunc.size() - 1; i >= 0; i--)
	{

		cout << tabelaFunc[i].nomeFunc + " == " + func + " ?\n";
		
		if(tabelaFunc[i].nomeFunc == func)
		{
			return true;
		}				
	}
	
	return false;
}