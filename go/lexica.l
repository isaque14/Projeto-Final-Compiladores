%{
#include <string>

%}

ESPACO [ \t]
DIGITO [0-9]
LETRA [A-Za-z_]

DELIM {ESPACO}+
NUM {DIGITO}+
REAL {NUM}+("."{NUM}+)?
CHAR \'({LETRA}|{NUM})\'
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

"string"    { return TK_TIPO_STRING; }


[(){}[\];,]	{ return *yytext; }

[+\-*/%!&|<>]	{ return *yytext; }

"="         { return '='; }



{NUM}		{ yylval.label = yytext; return TK_NUM; }
{ID}		{ yylval.label = yytext; return TK_ID; }

.			{ *yytext; }

%%
