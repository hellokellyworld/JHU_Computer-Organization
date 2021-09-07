.data

	buffer: .space 20
	s1: .asciiz "Enter:"

.text
main:
	la $a0, s1 # print "Enter:"
	li $v0, 4 # printing the string
	syscall
	
	addi $v0, $zero, 5 # read integer
	syscall
	
	#addi, $v0,$zero,1
	
	la $a0, buffer # load buffer address
	li $a1, 20 # how many bytes to read
	
	sw $t0,-100($a0)
	syscall
	
	lw $a0,0($t0)
	addi $v0, $zero, 1
	syscall