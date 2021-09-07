.data
    str: .asciiz "You've earned an A+!"
    buffer: .space 28
    
.text
    li $v0,8
    la $a0, buffer
    li $a1, 28
    
    move $t0,$a0
    syscall
    
    move $a0, $t0
    jal print
    
    li $v0, 10
    syscall
    	
    
    print:
    	addi $sp, $sp, -20
    	sw $ra, 16($sp)
    	sw $a0, 12($sp)
    	
    	move $s1,$ra # I save the address in the $ra register to $k0
    	
    	addi $t4, $sp, 0
    	la $t1, ($a0)
    	
    	load_str:
	    lbu $t2, ($t1)
	    slti $t3, $t2, 1
	    beq $t2, 48, null
	    
	    resume:
    	    	
    	    	sb $t2, 0($t4)
    	    	addi $t4, $t4, 1
    	    	addi $t1, $t1, 1
    	    	bne $t3, 1, load_str
    	
    	    li $v0, 4
    	    syscall
    
    	    lw $ra 16($sp)
    	    lw $a0 12($sp)
    	    
    	   move $ra,$s1 # Before return, I restored the return address in $k0 to $ra
    	    jr $ra
    		
    	    null:
    		addi $t2, $t2, -48
    		j resume

print_a:
    la $a0, str
    li $v0, 4
    syscall
