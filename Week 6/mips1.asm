.data

.text
main:

	addi $a0, $0, 1
	jal factrl
	add $t5, $0, $v0
	
	# Print factorial of K
	add $a0, $zero, $t5 # Get number read from previous syscall and put it in $a0, argument for next syscall
	addi $v0, $zero, 1  
	syscall 

 factrl:		

sw $ra, 4($sp) # save the return address 
sw $a0, 0($sp) # save the current value of n 
addi $sp, $sp, -8 # move stack pointer 

slti $t0, $a0, 2 # save 1 iteration, n=0 or n =1; n!=1 
beq $t0, $zero, L1 # not less than 2 , calculate n(n - 1)! 
addi $v0, $zero, 1 # n=1; n!=1 
jr $ra # now multiply 

L1: 

addi $a0, $a0, -1 # n = n - 1 

jal factrl # now (n - 1)! 

addi $sp, $sp, 8 # reset the stack pointer 
lw $a0, 0($sp) # fetch saved (n - 1) 
lw $ra, 4($sp) # fetch return address 
mul $v0, $a0, $v0 # multiply (n)*(n - 1) 
jr $ra # return value n!           
