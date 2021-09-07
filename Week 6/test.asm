.data 
	string1: .asciiz "Please enter the size of the large pool: "
	string2: .asciiz "How many do you want to draw from the large pool? "
	string3: .asciiz "Please enter the size of the small pool: "
	string4: .asciiz "How many do you want to draw from the small pool? "
	string5: .asciiz "The odds are 1 in "


.text
	.globl main
	
	main:
	# Print propmt message 1
	la $a0, string1 
	li $v0, 4
	syscall 
	
	# Read number N
	addi $v0, $zero, 5
	syscall
	
	# Store number in memory
	add $t1, $zero, $v0


	# Print propmt message 2
	la $a0, string2
	li $v0, 4
	syscall 
	
	# Read number K
	addi $v0, $zero, 5
	syscall
	
	# Store number in memory
	add $t2, $zero, $v0
	
	# Print propmt message 3
	la $a0, string3 
	li $v0, 4
	syscall 
	
	# Read number n
	addi $v0, $zero, 5
	syscall
	
	# Store number in memory
	add $t3, $zero, $v0
	
	# Print propmt message 4
	la $a0, string4 
	li $v0, 4
	syscall 
	
	# Read number k
	addi $v0, $zero, 5
	syscall
	
	# Store number in memory
	add $t4, $zero, $v0
	
	######### large Pool ###########
	
	# Calculate product of leading terms (numerator ) for large pool
	
	add $a0,$0,$t1
	add $a1,$0,$t2
	jal product
	add $t6,$0, $v0

			
	# Calculate factorial for denominator K!
	add $a0, $0, $t2
	jal factrl
	add $t7, $0, $v0
	

	
	# Calculate the division N(N-1)...(N-K+1) / K!
	div $t8, $t6, $t7

	
	######### Small Pool ###########
	
	# Calculate product of leading terms (numerator ) for the small pool

	add $a0,$0,$t3
	add $a1,$0,$t4
	jal product
	add $t6,$0, $v0
			
	# Calculate factorial for denominator k!
	add $a0, $0, $t4
	jal factrl
	add $t7, $0, $v0
	
	# Calculate the division n(n-1)...(n-k+1) / k!
	div $t9, $t6, $t7
	
	
        ####### Calculate the odds of winning
	
	mult $t8, $t9
	mflo $t9

	# Print propmt message 5
	la $a0, string5 
	li $v0, 4
	syscall 
	
	# Print calculated result
	add $a0, $zero, $t9  # Get number read from previous syscall and put it in $a0, argument for next syscall
	addi $v0, $zero, 1  
	syscall 
	
	
	li $v0, 10
	syscall


	# Given n, in register $a0 ; 
	# calculate n!, store and return the result in register $v0 

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
	
	
	# Given N in register $a0, K in register $a1
	# calculate N * (N -1) * ... * (N-K+1)
	# store and return the result in register $v0 

	product:	
		addi $sp, $sp, -4  # Create 4 bytes on the stack
		sw $s0, 0($sp) # Push s0 onto stack
	
		sub $t1, $a0, $a1 # Calculate N-K
		add $t0, $zero, $a0  # Set counter = N
		addi $s0, $zero, 1 # Set product = 1
		Loop:
			beq $t0, $t1, exit # Exit loop when equal to N-K
			mult $s0, $t0 # product = product * (n -1)
			mflo $s0 # Move the content from low register to $s0		
			subi $t0, $t0, 1 # Decrement counter
			j Loop
		
		exit:
	
		add $v0, $0, $s0 # Return result in v0
		lw $a0, 0($sp) # Fetch saved result
		addi $sp, $sp, 4 # Reset the stack pointer 
		jr $ra # return value n!