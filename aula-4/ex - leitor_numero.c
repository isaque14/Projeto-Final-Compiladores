%{
#define D	300
#define O	301
#define H	302
#define F	303
#define B	304
#define X	399

%}

%%

[1-9][0-9]* 					{ return D; }
0[0-7]*							{ return O; }
0x[0-9A-Fa-f]+					{ return H; }
[0-9]*\.[0-9]+|[0-9]+\.[0-9]* 	{ return F; }
[ \n\t]+						{ return B; }
.								{ return B; }
<<EOF>>							{ return X; }

%%

int main(int argc, char *argv[])
{
	FILE *f_in;
	int tipoToken;
	int totalDec = 0,
		totalOct = 0,
		totalHex = 0,
		totalFlt = 0;

	if(argc == 2)
	{
		if(f_in == fopen(argv[1], "r"))
		{
			yyin = f_in;
		}
		else
		{
			perror(argv[0]);
		}
	}
	else
	{
		yyin = stdin;
	}

	while((tipoToken = yylex()) != X)
	{
		switch (tipoToken)
		{
			case D:
				++totalDec;
				break;
			case O:
				++totalOct;
				break;
			case H:
				++totalHex;
				break;
			case F:
				++totalFlt;
				break;
		}
	}

	printf("Arquivo tem:\n");
	printf("\t %d valores decimais\n", totalDec);
	printf("\t %d valores octais\n", totalOct);
	printf("\t %d valores hexadecimais\n", totalHex);
	printf("\t %d valores octais\n", totalFlt);
}
