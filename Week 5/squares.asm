.data
	string1: .asciiz "Please enter an integer: "
	string2: .asciiz "The sum of squares between "
	string3: .asciiz " and 100 is: "
.text
main:

  	 # Print propmt message
	la $a0, string1 
	li $v0, 4
	syscall 
	
	# Read number 
	addi $v0, $zero, 5
	syscall

	# Store number in memory
	add $s1, $zero, $v0
	
	# Calculate the sum
	add $t0, $zero, $s1  # Set counter = the entered number
	add $t1, $zero, $zero # Set sum = zero

	Loop:
		beq $t0, 101, exit # Exit loop when equal to 100
		mult $t0, $t0 # Calculate t0 times t0
		mflo $s2 # Move the content from low register to $s2
		add $t1, $t1, $s2 # sum = sum + square
		addi $t0, $t0, 1 # Increment counter
		j Loop
	exit:

	# Print first half string "The sum of squares between "
	la $a0, string2 
	li $v0, 4
	syscall
	
	# Print number entered 
	add $a0, $zero, $s1  # Get number read from previous syscall and put it in $a0, argument for next syscall
	addi $v0, $zero, 1
	syscall


	# Print second half string " and 100 is"
	la $a0, string3 
	li $v0, 4
	syscall
	
	# Print calculated result
	add $a0, $zero, $t1  # Get number read from previous syscall and put it in $a0, argument for next syscall
	addi $v0, $zero, 1  
	syscall             
