.data

pi: .double 3.141592
vAbsoluto: .double 0.00001
graus: .double 180.0
const3: .double 3.0
const2: .double 2.0
const1: .double 1.0
const_1: .double -1
const0: .double 0.0
msg1: .asciiz "Insira um numero em graus para ser calculado seu cosseno: "
msg2: .asciiz " \nO cosseno do numero inserido eh: "
aviso: .asciiz "\nOBS: quanto mais alto o valor do angulo, mais impreciso sera o calculo!\n"

.text
	l.d $f2, pi
	l.d $f6, graus
	li $s4, 2 #primeira iteracao k = 2
	
	li $v0, 4
	la $a0, msg1
	syscall
	
	li $v0, 7
	
	syscall
	
	jal calcRad
	
	li $v0, 4
	la $a0, aviso
	syscall
	
	jal calcCOSSen
	
calcCOSSen:
	li $s3, 0 #cont = 0
	l.d $f16, vAbsoluto
	l.d $f14, const2 #primeira iteracao k = 2
	l.d $f26, const2
	l.d $f20, const1
	loopCOSSen:
	jal potencia
	jal fatorial
	mtc1 $t5, $f18
	cvt.d.w $f18, $f18
	div.d $f28, $f8, $f18
	andi $s2, $s3, 1
	c.le.d $f28, $f16
	bc1t endCalcCOSSen
	beq $s2, $zero, antSub
	bne $s2, $zero, antSum
	addi $s3 $s3, 1
	addi $s4 $s4, 2
	add.d $f14, $f14, $f26

	j loopCOSSen
	
endCalcCOSSen:
	j opCOSSen
	
calcRad:
	mul.d $f4, $f2, $f0
	div.d $f4, $f4, $f6
	mov.d $f30, $f4
	c.eq.d $f0, $f6
	bc1t caso180 #trata o caso do angulo ser 180
	jr $ra

potencia:
	li $t7, 0
	l.d $f8, const1 #resultado = 1
	mtc1.d $t7, $f10
	cvt.d.w $f10, $f10
	l.d $f12, const1
	mov.d $f24, $f14
	
	
	
	while:	
	c.eq.d $f24, $f10
	bc1t saida
	mul.d $f8, $f8, $f4
	sub.d $f24, $f24, $f12
	j while	
	
	saida:
	    jr $ra
fatorial:
    move $t2, $s4 # carrega a variavel auxiliar
    move $t5, $s4
    addi $t2, $t2, -1

	calcFat:
    		beq $t2, $zero saidaFat
   	 	mul  $t5, $t5, $t2
    		addi $t2, $t2, -1
    		j calcFat

	saidaFat:
    		jr $ra
	
	
opCOSSen:
	
	j encerra_prog
	
primIt:
	l.d $f30, const1
	sub.d $f20, $f30, $f28
	addi $s3, $s3, 1 #cont++
	addi $s4, $s4, 2 #serie+2
	add.d $f14, $f14, $f26
	j loopCOSSen
antSum:
	add.d $f20, $f20, $f28
	addi $s3 $s3, 1
	addi $s4 $s4, 2
	add.d $f14, $f14, $f26
	j loopCOSSen
	
antSub: 
	sub.d $f20, $f20, $f28
	addi $s3, $s3, 1 #cont++
	addi $s4, $s4, 2 #serie++
	add.d $f14, $f14, $f26
	j loopCOSSen
	
caso180:
	l.d $f0, const_1
	mov.d $f20, $f0
	j encerra_prog
	
encerra_prog:
	li $v0, 4
	la $a0, msg2
	syscall
        li $v0, 3
	mov.d $f12, $f20
	syscall
	li $v0, 10
	syscall
