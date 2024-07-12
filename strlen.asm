.data
	msg1: .asciiz "Insira uma string: "
	msg2: .asciiz "O tamanho da string eh "
	msg3: .asciiz " caracteres.\n"
	string: .space 256 #maximo de 256 caracteres, pode ser alterado de acordo com a necessidade
.text
	li $v0, 4
	la $a0, msg1
	syscall
	
	#leitura da string
	li $v0, 8
	la $a0, string
	la $a1, 256
	syscall
	
	jal strlen
	jal imprime_tam
	
strlen:
	li $t0, 0 #contador = 0
	
	loop:
	lb $t1, 0($a0) #percorre a string
	beqz $t1, saida_strlen #para o loop caso encontre o caractere nulo
	addi $a0, $a0, 1 #incrementa o contador para percorrer a string
	addi $t0, $t0, 1 #incrementa o contador de caracteres
	j loop
	
	saida_strlen:
	subi $t2, $t0, 1 #exclui o caractere nulo
	jr $ra
	
imprime_tam:

         #exibe o tamanho da string e encerra o programa    	 	 
 	     li $v0, 4
 	     la $a0, msg2
 	     syscall
 	
 	     li $v0, 1
 	     la $a0, ($t2)
 	     syscall
 	
 	     li $v0, 4
 	     la $a0, msg3
 	     syscall
 	     
 	     li $v0, 10
 	     syscall