.data

cache: .word 0x01,0x02,0x03,0x04

.text 

addi $t0, $zero, 8

lw $t1,cache($t0)

li $v0, 1
    	move $a0, $t1
    	syscall
   
 addi $t2, $zero, 100	
sw $t2,cache($t0)

lw $t1,cache($t0)

li $v0, 1
    	move $a0, $t1
    	syscall
   