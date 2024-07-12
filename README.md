# Descrição dos códigos

## StrLen

O objetivo desse código é informar ao usuário quantos caracteres há em uma
string inserida pelo mesmo. O programa pede ao usuário para que ele insira uma string
qualquer, depois a string é salva no registrador $a0, logo em seguida o programa chama a
função strlen, que de forma recursiva percorre a string até o terminador nulo, a cada
recursão o contador, começado em 0, incrementa em 1. Depois a função imprime_tam é
chamada, que antes de exibir ao usuário o tamanho da string, ele subtrai 1 do contador,
pois o terminador nulo também é contado, e assim, é impresso o tamanho da string
inserida

## toUpper

O objetivo principal do código é transformar todas as letras de uma string
inserida em caracteres minúsculos. O programa pede ao usuário que insira uma string,
depois a salva no registrador $a0, em seguida a função str_ToLower é chamada, que então
chama percorre_str, um loop que a cada iteração, percorre caractere por caractere da
string. Também alguns registradores são preenchidos com códigos ascii das letras A, Z e a,
para realizar verificações se deve-se ou não incrementar 32 ao código ascii do caractere da
string atual. Primeiro temos o retLessA, que faz o loop avançar caso o caractere atual já
seja minúsculo ou “menor” que A. Se for maior ou igual a ‘a’, o ret_gra verifica isso, caso
seja maior ou igual a ‘A’, a função checkChar é chamada para verificar se o caractere atual
está no intervalo de A - Z, caso positivo, a função toLower é chamada, do contrário, retorna
para percorre_str, ao chegar no terminador nulo, a string inserida é impressa com todos
seus caracteres minúsculos.

## Calc sen e cossen (problemas 3 e 4)

Os dois códigos têm objetivos diferentes mas funcionam de maneiras
similares. Começando pelo problema 3, temos um código que calcula o seno do ângulo
inserido em graus pelo usuário. Primeiramente, o ângulo que o usuário inseriu é convertido
para radianos na função calcRad, depois a função calcSen é chamada, antes de iniciar o
loop, o registrador $s0 recebe 0, para indicar a iteração da série, o $f16 recebe 0.00001,
que é o valor absoluto e condição de parada da série, $f14 recebe o valor da “primeira”
iteração, que no Problema 3 começa com 3, $f26 recebe 2 para incrementar em $f14 a cada
iteração, e $f20 recebe x, portanto já começando a série na segunda iteração. Depois é
calculada a potência (numerador), que é x^k, depois o fatorial, que é k!, como o fatorial é um
inteiro, ele é convertido para ponto flutuante nas instruções


`mtc1 $t5, $f18`

`cvt.d.w $f18, $f18`


Depois é calculado o termo da iteração atual da série, dividindo $f8 por $f18 e guardando
em $f28 (registrador que guarda o termo atual). Depois é verificado qual iteração está a
série, e de acordo, o termo atual será subtraído ou somado do somatório da série.
No entanto, antes de ser somado, é sempre feita uma verificação para saber se o termo
atual é menor que o valor absoluto, caso positivo é parada a série, caso contrário a série
continua e $f28 é somado/subtraído de $f20. Quando a série para o termo atual não é
somado à $f20, e o valor que está em $f20 é exibido ao usuário.
Já no problema 4 é calculado o cosseno de um ângulo inserido em graus pelo usuário. A
primeira iteração começa com k = 2 pois do contrário da série do seno, os números k são
pares, mas k continua sendo incrementado de 2 em 2, e diferente do seno, o primeiro termo
da série do cosseno é 1 ao invés de x. Essas são as principais diferenças entre os dois
programas/problemas, tirando isso, o 4 funciona igual ao 3

## Matriz quadrado mágico 

Primeiramente, ao iniciar o programa, é inicializada uma matriz a escolha do usuário, basta
trocar os indicadores tam e Matriz, onde, tam é o número máximo de elementos por coluna
e linha, como a matriz deve sempre ser quadrada, esse número é o mesmo para os dois.
Já Matriz indica quantas posições ela vai ocupar na memória, ou o tamanho
real/propriamente dito, portanto deve ser n², onde n é o número de elementos por
linha/coluna.

Por padrão usaremos Matriz 0:16 e tam 4 ou seja uma matriz 4x4 M[4][4].

Há 6 funções “principais” no programa: magico, percorre_linha, percorre_coluna,
percorre_diagonal_principal, percorre_diagonal_secundaria e compLinhaCol.

Inicia-se chamando a função magico que tem o papel de preencher a matriz com números
inteiros e positivos iinseridos pelo usuário. Ela possui 2 partes, a magico que prepara os
registradores de linha e coluna e seus respectivos contadores e o registrador que guardará
o elemento na matriz, e insere_num que coloca o numero digitado na matriz, vale ressaltar
que foram utilizados as instruções mflo e sll para inserir o elemento no endereço da
posição correta da matriz.

Após ser preenchida a matriz a função percorre_linha é chamada, de forma recursiva a
função vai passando por cada elemento de uma linha (de coluna em coluna) e os soma em
um registrador. Após a primeira iteração, a função zera o registrador de somatório, e salva
esse valor em um registrador temporário, depois o compara com o somatório da linha atual,
através da função verifMagL, caso o somatório de uma linha seja diferente da outra, aqui já
encerramos a execução, pois a matriz não é um quadrado mágico.

A função percorre_coluna funciona de maneira idêntica à de linhas, só que neste caso, ela
para em uma coluna e vai de linha em linha analisando os elementos.

As funções percorre_diagonal_principal e percorre_diagonal_secundaria, funcionam de
forma idêntica às outras duas anteriormente mencionadas, e são praticamente semelhantes
entre si. Elas percorrem a diagonal principal e secundaria, respectivamente, de forma
recursiva, mas diferente das outras de L e C, elas não chamam uma função para comparar.

Feitos todos os somatórios, a função compLinhaCol entra em ação, comparando o
somatório de linhas e colunas, e caso seja igual, elas passam para a compDig, caso
contrário, o programa encerra com a mensagem de que a matriz não é mágica. Nessa
função, o programa compara o somatório das diagonais entre si e entre os das linhas e
colunas, caso seja igual, o programa diz que é mágico, caso contrário ele encerra com uma
mensagem dizendo o oposto
