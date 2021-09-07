.data 

cache: .word 1,2,3,4,5,6,7,8

.text

addi $t1, $zero, 4


 mul $t5, $t1, 7


lw $t6, cache($t5)
	li $v0, 1
    	move $a0, $t6
    	syscall

	