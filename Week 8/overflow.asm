.data
    str: .asciiz "You've earned an A+!"
    buffer: .space 28
    warnStr: .asciiz "Buffer overflow detected!"
    attackInput: .text 0x0040007c
    resetRaAddress: .text 0x00400020

.text
    li $v0,8 # System call for reading a string
    la $a0, buffer # Set $a0 to the location in memory to record input
    li $a1, 28 # Set 28 bytes to be the max num of bits to read in
   # la $t1,attackInput
    #la $t2,resetRaAddress
    move $t0,$a0 # Copy buffer space memory into $t0
    syscall
    
    move $a0, $t0 # Set $t0 content to argument and pass into print function
    jal print # Jump into print function
    
    li $v0, 10 # End execution syscall
    syscall
    
    print:
    	addi $sp, $sp, -20 # Create 20 bytes on the stack
    	sw $ra, 16($sp) # store ra return address
    	sw $a0, 12($sp) # store a0 parameter destintion?
    	
    	addi $t4, $sp, 0 # addrress of local_buf[0]
    	la $t1, ($a0) # Save argument passed in to $1
    	
    	load_str:
	    lbu $t2, ($t1) # Load $t1 address into $t
	    slti $t3, $t2, 1 # If $t2 is less than 1, set $t3 = 1 , otherwise $t3 = 0
	    beq $t2, 48, null # Branch to null if $t2 = 48
	    
	    resume:
    	    	
    	    	sb $t2, 0($t4) 
    	    	addi $t4, $t4, 1 # $t4 = $t4 + 1
    	    	addi $t1, $t1, 1 # $t1 = $t1 + 1
    	    	bne $t3, 1, load_str # Branch to load_str if $t3 is not equal to 1
    	
    	    li $v0, 4  # print
    	    syscall
    
            #move $ra,$s1
    	    #beq $ra,$t1, resetRa
           # move $s1,$ra
    	    lw $ra 16($sp) # resotre
    	    lw $a0 12($sp)# restore
    	    
    	    jr $ra
    	      #resetRa:
    	      
    	    	#move $t2 ,$ra
    	    	# lw $ra 16($sp) # resotre
    	         #lw $a0 12($sp)# restore
    	    
    	        #jr $ra
    	  
    	    	
    	    null:
    		addi $t2, $t2, -48  # $t2 = $t2 -48
   		j resume # jump to resume
print_a:
    la $a0, str  # print str "You've earned an A+!"
    li $v0, 4
    syscall

