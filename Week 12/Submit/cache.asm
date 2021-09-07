.data

zero: .half 3
one: .half 'a'
two: .half 9
three: .half 'R'
four: .half '!'
five: .half 8
six: .half 'p'
seven: .half 'd'
eight: .half 'J'
nine: .half 7
A: .half '?'
B: .half 'V'
C: .half 's'
D: .half 'A'
E: .half 'T'
F: .half 4

cache: .word 1, 2, 3, 4, 5, 6, 7, 8

arr: .word 0x10010008, 0x1001000C, 0x10010006, 0x1001000D, 0x10010002, 0x1001000B, 0x10010005, 0x10010001, 0x10010008, 0x1001000F, 0x1001000A, 0x10010007, 0x10010000, 0x10010003, 0x1001000C, 0x1001000E, 0x10010000, 0x10010009, 0x10010007

hitString: .asciiz "Cache hit!"
missString: .asciiz "Cache miss!"

newline: .asciiz "\n"

str1: .asciiz "There were "
str2: .asciiz " cache hits"
str3: .asciiz " cache misses"

.text

addi $t0, $zero, 0 # set i = 0, loop count
addi $s1, $zero, 76 # set bound
addi $s2, $zero, 0 # hit count
addi $s3, $zero, 0 # miss count

Loop:

	slt $t1, $t0, $s1 # i < 19
	beq $t1, $zero, ENDLOOP # exit when i < 19 is false

	# a) get arr[i]
	lw $t2, arr($t0)

	# b) get cache[arr[i] % 8]
	addi $t5, $zero, 8
	div $t2, $t5
	mfhi $t4 # reminder to $t4
	mul $t4, $t4, 4
	lw $t3, cache($t4)

	# c) get tag value of arr[i]
	addi $t6, $zero, 0x10010007
	sgt $t1, $t2, $t6 # $t2 is passed in , arr[i]
	beq $t1, $0, Else #if false go to Else
	addi $t9, $zero, 4097 #if true, tag = 4097
	j Endif
	
	Else:
   		addi $t9, $zero, 4096 #if false, tag = 4096
	Endif:

	# d) dfetermine hit or miss
	beq $t3, $t9, hitFunc
	j missFunc

	hitFunc:
		addi $s2, $s2, 1 # increment hit
		sw $t9, cache($t4)
		la $a0, hitString
		li $v0, 4
		syscall
		li $v0, 4
		la $a0, newline
		syscall
		j EndCompare

	missFunc:
		addi $s3, $s3, 1 # increment miss
		sw $t9, cache($t4)
		la $a0, missString
		li $v0, 4
		syscall
		li $v0, 4
		la $a0, newline
		syscall
		j EndCompare
	
	EndCompare:
	
	addi $t0, $t0, 4
	j Loop
	
ENDLOOP:


# e) print summary
la $a0, str1
li $v0, 4
syscall

li $v0, 1
move $a0, $s2
syscall

la $a0, str2
li $v0, 4
syscall
li $v0, 4
la $a0, newline
syscall

la $a0, str1
li $v0, 4
syscall

li $v0, 1
move $a0, $s3
syscall

la $a0, str3
li $v0, 4
syscall
