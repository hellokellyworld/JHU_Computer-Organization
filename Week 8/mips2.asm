.data
    str: .asciiz "You've earned an A+!"
    buffer: .space 28
    
.text
    li $v0,8 # System call for reading a string
    la $a0, buffer # Set $a0 to the location in memory to record input
    li $a1, 28 # Set 28 bytes to be the max num of bits to read in
    # Note that this space set aside includes the terminating null '\0' character, 
    #so it will actually read only up to 27 characters from the buffer when the syscall executes.
    move $t0,$a0 # Copy buffer space memory into $t0
    syscall
    
    move $a0, $t0 # Set $t0 content to argument and pass into print function
    jal print # Jump into print function
    
    li $v0, 10 # End execution syscall
    syscall
    
    print:
    	addi $sp, $sp, -20 # Create 20 bytes on the stack
    	sw $ra, 16($sp) # Set return address at 16 bytes from the top
    	sw $a0, 12($sp) # Set argument address at 12 bytes from the top
    	
    	addi $t4, $sp, 0 # Set stack pointer to point to $t4
    	la $t1, ($a0) # Save argument passed in to $1
    	
    	load_str:
	    lbu $t2, ($t1) # Extend $t1 into 32 bits and set to $t2
	    slti $t3, $t2, 1 # If $t2 is less than 1, set $t3 = 1 , otherwise $t3 = 0
	    beq $t2, 48, null # Branch to null if $t2 = 48
	    
	    resume:
    	    	
    	    	sb $t2, 0($t4) 
    	    	addi $t4, $t4, 1 # $t4 = $t4 + 1
    	    	addi $t1, $t1, 1 # $t1 = $t1 + 1
    	    	bne $t3, 1, load_str # Branch to load_str if $t3 is not equal to 1
    	
    	    li $v0, 4  # print
    	    syscall
    
    	    lw $ra 16($sp) # resotre
    	    lw $a0 12($sp)# restore
    	     jr $ra
    		
    	    null:
    		addi $t2, $t2, -48  # $t2 = $t2 -48
    		j resume # jump to resume

print_a:
    la $a0, str  # print str "You've earned an A+!"
    li $v0, 4
    syscall