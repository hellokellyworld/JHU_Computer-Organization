Loop:

add $t0, $zero, enteredint # i is initialized to enterint, $t0 = 0
# stuff start



#stuff end
addi $t0, $t0, 1 # i ++
slti $t1, $t0, 100 # $t1 = 1 if i < 100
bne $t1, $zero, Loop # go to Loop if i < 100


li $t0, enteredint # we set counter starts from entereint
li $t1, 0 # we set sum = 0

Loop:
	beq $t0, 100, exit # 
	mult $s2, $t0, $t0 # set s2 equals to t0 times t0
	add $t1, $t1, $s2 # sum = sum + square
	addi $t0, $t0, 1 #increment counter
	j Loop
exit:
li $v0,10
syscall



