.data
	
	Matriz:	.word 0:4 #inicializando a matriz com todos elementos valendo 0 M[2][2]
	tam:	.word 2 #tamanho das linhas e colunas
	prompt1: .asciiz "\nInsercao de elementos na Matriz 2x2\n"
	prompt2: .asciiz "\nDigite um numero inteiro: "
	prompt3: .asciiz "Posicao [l][c] = \n"
	EhMagico: .asciiz "A matriz inserida eh um quadrado magico! \n"
	nEhMagico: .asciiz "A matriz inserida nao eh um quadrado maigco! \n"
	
.text
	main:
		
	li $v0, 4
	la $a0, prompt1
	syscall
	
	jal magico
	jal percorre_linha
	jal percorre_coluna
	jal percorre_diagonal_principal
	jal percorre_diagonal_secundaria
	jal compLinhaCol
	
	
magico:     
        lw  $t0, tam #Nro linhas           
        lw  $t1, tam #Nro colunas     
        move $s0, $zero   
        move $s1, $zero  
        move $t2, $zero   

	insere_num:
		
		mult  $s0, $t1   
                mflo  $s2            
                add   $s2, $s2, $s1  
                sll   $s2, $s2, 2    
            
        	li $v0, 4        
        	la $a0, prompt2        
        	syscall
        	
        	li $v0, 5        
        	syscall
        	           
        	move $t2, $v0        
        	sw $t2, Matriz($s2)          
           
                addi $t2, $t2, 1 #incremento no contador
        
        	#loop:  
            	addi  $s1, $s1, 1
		bne   $s1, $t1, insere_num
            	move  $s1, $zero
            	addi  $s0, $s0, 1
            	bne $s0, $t0, insere_num
            	jr  $ra
        
       
    	    	add $v0, $s1, $zero # retorno 
    		jr $ra

verifMagL:
	bne $t7, $s3, nMagico
	beq $t7, $s3, linhaProx

verifMagC:
	bne $t7, $s4, nMagico
	beq $t7, $s4, colProx

#soma das linhas	
percorre_linha:
    	lw $t6, tam
    	li $t0, 0 #contador de linhas
    	li $t7, 0 #somaTemp
    	li $s3, 0 #somaLinhas1 = 0
    	li $s0, 0
    		
lloop:
    bge $t0, $t6, encerraSumLinhas #verifica se foram percorridas as linhas, passa para o final da funcao se >= 4
    li $t1, 0 #contador para colunas
			
	cloop_linha:
		bge $t1, $t6, vlinhaProx #checar se todas as colunas da linha foram percorridas
		lw $t2, tam
		mult $t0, $t2 #indice da linha
		mflo $t2
		add $s0, $t2, $t1 #indice do elemento
		sll $s0, $s0, 2
		la $t4, Matriz
		add $s0, $s0, $t4
		lw $t3, 0($s0) #carrega o elemento do indice atual
		add $s3, $s3, $t3
		addi $t1, $t1, 1 #incremento cont. colunas
		j cloop_linha
					
	vlinhaProx:
	        la $t7, ($s3)
		beq $t0, 1, verifMagL
		beq $t0, 2, verifMagL
		beq $t0, 3, verifMagL
	linhaProx:
		li $s3, 0
		addi $t0, $t0, 1 #incremento cont. linhas
		j lloop
		
	encerraSumLinhas:
		la $s3, ($t7)
		jr $ra

#soma das colunas
percorre_coluna:
	lw $t6, tam
	li $t0, 0 #contador de colunas
	li $s4, 0 #somaColunas = 0
	li $t7, 0 #somaTemp = 0
	li $s0, 0

cloop:
    bge $t0, $t6, encerraSumCol #verifica se foram percorridas as colunas, passa para o final da funcao se >= 4
    li  $t1, 0 #contador de linhas
    
    	lloop_coluna:
    		bge $t1, $t6, vcolProx #checar se todas as linhas da coluna foram percorridas
    		lw $t2, tam
    		mult $t1, $t2 #indice da linha
    		mflo $t2
    		add $s0, $t2, $t0 #indice do elemento
    		sll $s0, $s0, 2
    		la $t4, Matriz
    		add $s0, $s0, $t4
    		lw $t3, 0($s0) #carrega o elemento do indice atual
    		add $s4, $s4, $t3
    		addi $t1, $t1, 1 #incr. cont. linhas
    		j lloop_coluna
    	
    	vcolProx:
    	     la $t7, ($s4)
	     beq $t0, 1, verifMagC
	     beq $t0, 2, verifMagC
	     beq $t0, 3, verifMagC
	     li $s4, 0
        colProx:
    	     addi $t0, $t0 1
    	     j cloop
    	     
    	encerraSumCol:
    		 la $s4, ($t7)
    	         jr $ra
    	         
percorre_diagonal_principal:
	lw $t0, tam
	li $t1, 0 #contador de linhas e colunas
	li $s5, 0 #soma = 0
dgpLoop:
   bge $t1, $t0, encerraSumDGP #verifica se todas as linhas e colunas foram percorridas
   mult $t1, $t0 #indice da linha
   mflo $t2
   sll $t2, $t2, 2
   la $t3, Matriz
   add $s0, $t2, $t3 # endereço do elemento [linha * tam + coluna]
   lw $t4, 0($s0) #carrega o elemento do indice atual	
   add $s5, $s5, $t4
   addi $t1, $t1, 1 #incrementa contador
   j dgpLoop
   
encerraSumDGP:
	jr $ra
	
percorre_diagonal_secundaria:
	lw $t0, tam      
    	li $t1, 0  #contador de linha/coluna
    	li $s6, 0  #soma = 0
dgsLoop:
    	bge $t1, $t0, encerraSumDGL #verifica se todas as linhas e colunas foram percorridas
    	sub $t2, $t0, $t1  #indice da coluna diagonal secundaria [tam - linha - 1]
    	mult $t1, $t0   #indice da linha
    	mflo $t3
    	add $s0, $t3, $t2 #indice do elemento [tinha * tam + col]
    	sll $s0, $s0, 2 
    	la $t4, Matriz   
    	add $s0, $s0, $t4  
    	lw $t5, 0($s0)    
    	add $s6, $s6, $t5  
    	addi $t1, $t1, 1  #increnta contador
    	j dgsLoop
    	
encerraSumDGL:
    jr $ra
    	
encerra:
	li $v0, 10
	syscall
	
compLinhaCol: #comparacao de linha e coluna
	beq $s3, $s4, compDig
	bne $s3, $s4, nMagico
	
compDig:
	beq $s3, $s5, Magico
	bne $s5, $s6, nMagico 
	
Magico:
	li $v0, 4
	la $a0, EhMagico
	syscall
	j encerra
nMagico:
	li $v0, 4
	la $a0, nEhMagico
	syscall
	j encerra
		
