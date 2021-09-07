.data
in_msg: .asciiz "Type your integer here: "
str1: .asciiz "There were "
zero: .asciiz " zeros.\n"
one: .asciiz " ones."

arr: .word 1, 1, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1

  .text
la $a0, in_msg
li $v0, 4
syscall

li $v0, 5
move $t0, $v0
syscall

addi $t0, $zero, 0 # set i = 0, loop count
addi $s1, $zero, 108 # set bound
addi $s2, $zero, 0 # zero count
addi $s3, $zero, 0 # one count
addi $s4, $zero, 1

Loop:
	slt $t1, $t0, $s1 # i < 27
	beq $t1, $zero, ENDLOOP # exit when i < 27 is false

	# a) get arr[i]
	lw $t2, arr($t0)

	# b) increment $s2 if zero, increment $s3if one
	slti $t5, $t2, 1 #if arr[i] < 1, arr[i] is zero
	beq $t5, $0, Else #if arr[i] < 1 not true, arr[i] is one
	addi $s2, $s2, 1 # increment zero counter
	j Endif

	Else:
 		 addi $s3, $s3, 1 # increment one counter

	Endif:

		addi $t0, $t0, 4
		j Loop

ENDLOOP:

  # c) print summary
la $a0, str1
li $v0, 4
syscall

li $v0, 1
move $a0, $s2
syscall

la $a0, zero
li $v0, 4
syscall

la $a0, str1
li $v0, 4
syscall

li $v0, 1
move $a0, $s3
syscall

la $a0, one
li $v0, 4
syscall
