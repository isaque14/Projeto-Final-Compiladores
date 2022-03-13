%{
#include <string>

%}

ESPACO [ \t]
DIGITO [0-9]
LETRA [A-Za-z_]
SIMBOLO [:;<=>?@[\]^`{|}~]

DELIM {ESPACO}+
NUM {DIGITO}+
REAL {NUM}+("."{NUM}+)?
CHAR ({SIMBOLO}|{DIGITO}|{LETRA})
ID {LETRA}({LETRA}|{NUM})*
CARACTER {SIMBOLO}

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

"True"      { return TK_TRUE; }

"False"     { return TK_FALSE; }


[(){}[\];,""]	{ return *yytext; }

[+\-*/%!&|<>""]	{ return *yytext; }

"="         { return '='; }



{NUM}		{ yylval.label = yytext; return TK_NUM; }
{REAL}      { yylval.label = yytext; return TK_REAL; }
{ID}		{ yylval.label = yytext; return TK_ID; }
{CHAR}      { yylval.label = yytext; return TK_CHAR; }
{CARACTER}   { yylval.label = yytext; return TK_CARACTER; }
.			{ *yytext; }

%%
