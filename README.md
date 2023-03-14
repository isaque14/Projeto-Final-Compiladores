# Linguagem de Programação Stay e seu Compilador

## Sobre o Projeto 
- Este repositório foi criado para o projeto final da disciplina de Compiladores da Universidade Federal Rural do Rio de Janeiro. O projeto consiste na criação de uma Linguagem de programação
 e seu Compilador. A linguagem criada neste projeto recebeu o nome de Stay, e foi inspirada na Linguagem de Programação Go. 
 
 - O Compilador foi projetado para transformar o código criado em Stay em um código intermediário de baixo nível em C++. É utilizado o esquema de três endereços para a criação
 de todos os códigos intermediários.


## Ferramentas Utilizadas
- C++.
- Lex/Flex.
- Yacc/Bison.
- Make File

## Utilização do Compilador
### Instalação das ferramentas   
- Para utilizar o compilador criado nesse projeto será necessário a instalação das ferramentas citadas acima, isso pode ser feito utilizando o Sistema Linux ou o WSL no Windows utilizando os comandos abaixo.
- 1° sudo apt install g++
- 2° sudo apt install make
- 3° sudo apt install flex
- 4° sudo apt install bison

### Rodando um exemplo no compilador 
- Para executar um exemplo de código na linguagem Stay e ver o resultado do compilador em c++, basta escrever o código que deseja compilar no arquivo exemplo.stay, e no terminal executar o comando "make". 
OBS.: Todos os códigos na linguagem stay devem conter a classe principal main: 
```

func main()
{
    // Seu código aqui
}

```
Veja agora alguns exemplos de códigos escritos em Stay que podem ser compilador para C++ com esta ferramenta.

#### Instanciando variáveis 

```

func main()
	{
		var a int;
		var b float = 15.6;
		var c float = -16.88; 
		var d char = 'Z';
		var e bool = True;
		var f string = "Isaque";
		var g := 7; 
    }

```

#### Declaração de Vetores
```

func main()
	{
		var h[] int = 2, 6, 8, 1;
		var i[4] float = 1.2, 2.1, 4.3;
	}

```

#### Váriáveis de Escopo Global
```

var global int = 9;

	func main()
	{
		print(global);
	}

```

#### Contexto
```

func main()
	{
		var a int = 0

		while a < 10 {
			var b int = 26;
			a++;
		}

		b = 1;
	}

```
#### Concatenação de Strings
```

func main()
	{
		var name string = "Isaque";
		var last_name string = "_Diniz";

		var full_name string; 
		full_name = name + last_name;

		println(full_name);
	}

```

#### Comando Break
```

func main()
	{
		var i int;

		for i = 0; i < 10; i++{
			if i > 5{
				break;
			}
			println(i);
		}
	}

```
#### Comando Continue
```

func main()
	{
		var i int;

		for i = 0; i < 10; i++{
			if i < 5{
				continue;
			}
			println(i);
		}
	}

```
#### Input e Output (I/O)
```

func main()
	{	
		var a int;

		scan(&a);
		print("valor de a = ");
		println(a);
	}

```
#### Função de Potenciação
```

func main()
	{
		var pot float; 

		pot = pow(3, 2);

		print("Valor da potencia = ");
		println(pot);
	}

```
#### Função de Raiz Quadrada
```

func main()
	{
		var raiz float;

		raiz = sqrt(9);

		print("Valor da raiz = ");
		println(raiz);
	}

```
#### Operador Ternário 
```

func main()
	{
		var num := 15
		num > 10 ? println("true") : println("false");
	}

```
#### Declaração e Chamada de Funções 
```

    func int soma (a int, num int, msg string){
		println(msg);
		return num + a;
	}
	
	func void status(){
		println("OK");
	}
	
	func main()
	{
		status();
	}      

```
### Controle de Erros 

#### Não aceita variáveis repetidas 
```

func main(){
		var a int;
		var a float;
	}

```
#### Não aceita divisão por zero
```

func main()
	{
		var a int = 1;
		a = a/0;
	}

```
#### Não aceita vetores com elementos acima do valor estipulado
```

func main()
	{
		var vet[3] int = 1,2,3,4,5;
	}

```
#### Controle do tipo de retorno de uma função
```

func int soma (a float, num int, msg string){
		println(msg);
		return a + 1.7;
	}
	
	func void status(){
		return "ok";
	}
	
	func main()
	{
	
	}

```
## Responsável pelo Projeto: Isaque Diniz da Silva
#### Redes Sociais
[Linkedin](https://www.linkedin.com/in/isaque-diniz-da-silva-a0773459/)
</br>
[GitHub](https://github.com/isaque14)
