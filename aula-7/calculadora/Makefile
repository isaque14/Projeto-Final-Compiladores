all: 	
	flex lexica.l

	bison -d sintatica.y

	gcc -o calc sintatica.tab.c lex.yy.c -lfl

	./calc