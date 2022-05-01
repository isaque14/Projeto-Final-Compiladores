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

"\n"		{ contLinha(); }

{DELIM} 	{}

"func main"	{ return TK_MAIN; }
"func"      { return TK_FUNC; }
"return"    { return TK_RETURN; }
"var"       { return TK_VAR; }

"pow"       { return TK_POW; }
"sqrt"      { return TK_SQRT; }

"int"		{ return TK_TIPO_INT; }
"float"		{ return TK_TIPO_FLOAT; }
"bool"		{ return TK_TIPO_BOOL; }
"char"      { return TK_TIPO_CHAR; }
"string"    { return TK_TIPO_STRING; }
"void"      { return TK_TIPO_VOID; }

"True"      { return TK_TRUE; }
"False"     { return TK_FALSE; }

"println"   { return TK_PRINTLN; }
"print"     { return TK_PRINT; }
"scan"      { return TK_SCAN; }

"if"        { return TK_IF; }
"else"      { return TK_ELSE; }
"else if"   { return TK_ELSE_IF; }

"break"     { return TK_BREAK; }
"continue"  { return TK_CONTINUE; }

"while"     { yylval.label = genLaceNameCode(); pushLoop("while"); return TK_WHILE; }
"for"       { yylval.label = genLaceNameCode(); pushLoop("for"); return TK_FOR; }
"do"        { yylval.label = genLaceNameCode(); pushLoop("do"); return TK_DO; } //yylval.traducao = "DO";

"{"         { pushContexto(); return *yytext;}
"}"         { popContexto(); return *yytext;}



[(){}[\];,]	{ return *yytext; }

[+\-*/%!&|<>""'']	{ return *yytext; }

","         { return *yytext; }

":"         { return *yytext; }

"?"         { return *yytext; }

"="		    { return *yytext; }

":="        { return TK_DOIS_PTS_IGUAL; }

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
