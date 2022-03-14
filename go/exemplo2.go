func main()
{
	1+4;
	var num1 int;
	var num2 int = 90;
	var real1 float;
	var real2 float = 1.8;
	var txt1 char;
	var txt2 char = "p";
	var bolean1 bool;
	var bolean2 bool = True;
	
	real1 = num2;

	var num3 int = 71;
	num1 + num3;
	real1 = float (num3);
	num1 = txt2;
	txt2 = num2;


	******* Erros********
	// não aceita variaveis repetidas
	var a int;
	var a float;

	// Não aceita divisão por zero 
	a = num/a;
	1/0;

	// Não aceita char com mais de um caracter
	"teste";
	var a char = "teste";
}

