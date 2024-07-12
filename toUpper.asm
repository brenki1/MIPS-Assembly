.data
	msg1: .asciiz "Insira uma string: "
	msg2: .asciiz "String inserida com todos caracteres minusculos:  \n"
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
	
	jal str_toLower
	jal imprime_encerra
	
str_toLower:
	
	percorre_str:
	lb $t0, 0($a0) #percorre a string
	beqz $t0, saida
	li $t1, 65 #ascii para 'A'
	li $t2, 90 #ascii para 'Z'
	li $t3, 97 #ascii para 'a'
	blt $t0, $t1, ret_lessA #retorna para a funcao se o char atual for menor que A
	bge $t0, $t3, ret_gra #retorna para a funcao se o char atual for maior que a
	bge $t0, $t1, checkChar #se for maior que A, checa se esta entre A e Z
	
	saida:
	     move $t4, $t0 
	     jr $ra
	
ret_lessA:
	#avanca a string
	addi $a0, $a0, 1
	j percorre_str
	
ret_gra:
	#avanca a string
	addi $a0, $a0, 1
	j percorre_str
	
checkChar:
	ble $t0, $t2, toLower
	move $t4, $t0 #passa o caractere atual para a string em minisculo
	j percorre_str
	
toLower:
	addi $t4, $t0, 32 #adiciona 32 para se tornar minusculo
	sb $t4, 0($a0) #devolve o caractere minusculo para a string
	addi $a0, $a0, 1 #avanca a string
	j percorre_str 
	
imprime_encerra:
	
	
	li $v0, 4
	la $a0, msg2
	syscall
	
	li $v0, 4
	la $a0, string
	syscall
	
	li $v0, 10
	syscall
	
	