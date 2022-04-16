%{
#include <string>

%}

ESPACO [ \t]
DIGITO [0-9]
LETRA [A-Za-z_]
SIMBOLO [:;<=>?@[\]^`{|} 0x0020]

DELIM {ESPACO}+
NUM {DIGITO}+
REAL {NUM}+("."{NUM}+)?
CHAR \'({LETRA}|{DIGITO}|{SIMBOLO})\' 
STRING \"(({LETRA}*|{DIGITO}*|{SIMBOLO}*))*\"
ID {LETRA}({LETRA}|{NUM})*


%%

"\n"		{}

{DELIM} 	{}

"main"		{ return TK_MAIN; }

"func"      { return TK_FUNC; }

"var"       { return TK_VAR; }

"int"		{ return TK_TIPO_INT; }

"float"		{ return TK_TIPO_FLOAT; }

"bool"		{ return TK_TIPO_BOOL; }

"char"      { return TK_TIPO_CHAR; }
"string"    { return TK_TIPO_STRING; }

"True"      { return TK_TRUE; }
"False"     { return TK_FALSE; }

"println"   { return TK_PRINTLN; }
"print"     { return TK_PRINT; }
"scan"      { return TK_SCAN; }

"if"        { return TK_IF; }
"else"      { return TK_ELSE; }
"else if"   { return TK_ELSE_IF; }
"while"     { return TK_WHILE; }
"do"        { return TK_DO; }
"for"       { return TK_FOR; }



[(){}[\];,]	{ return *yytext; }

[+\-*/%!&|<>""'']	{ return *yytext; }


"="		    { return *yytext; }

">="        { return TK_MAIOR_IGUAL; }

"<="        { return TK_MENOR_IGUAL; }

"=="        { return TK_IGUAL_IGUAL; }

"!="        { return TK_DIFERENTE; }

"++"        { return TK_MAIS_MAIS; }

"--"        { return TK_MENOS_MENOS; }

"||"        { return TK_OU; }

"&&"        { return TK_E; }




{NUM}		{ yylval.label = yytext; return TK_NUM; }
{REAL}      { yylval.label = yytext; return TK_REAL; }
{ID}		{ yylval.label = yytext; return TK_ID; }
{CHAR}      { yylval.label = yytext; return TK_CHAR; }
{STRING}    { yylval.label = yytext; return TK_STRING; }
.			{ *yytext; }

%%
