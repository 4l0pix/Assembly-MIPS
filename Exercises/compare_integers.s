#Comparing two numbers (num1 & num2) and figguring out if num1=num2 | num1>num2 | num1<num2 using the least possible conditions

#messages
.data
msg1: .asciiz "equal"
msg2: .asciiz "greater"
msg3: .asciiz "less"
msg4: .asciiz "enter num1"
msg5: .asciiz "enter num2"

.text
	main:
    #reading num1
    li $v0,4        #
	la $a0,msg4     #message4 output
	syscall         #

	li $v0,5        #
	syscall         #num1 input
	move $t0,$v0    #
	
    
    li $v0,4        #
	la $a0,msg5     #message5 output
	syscall         #

	li $v0,5        #
	syscall         #num2 input
	move $t1,$v0    #
	

	beq $t0,$t1,equal   #condition for num1=num2
	bgt $t0,$t1,greater #condition for num1>num2
	
    #if none of the above conditions is true then 'the less condition' will be true
    #by placing it after the other two bracnch conditions we save up time and resources
	li $v0,4        #            
	la $a0,msg3     #message3 output
	syscall         #
	
    #exit branch
	exit:
		li $v0,10
		syscall
	#equal branch
	equal:
	li $v0,4        #
	la $a0,msg1     #message1 ouput
	syscall         #
    #after execution of the branch the program will be terminated
	j exit
	
    #greater barnch
	greater:
	li $v0,4        #
	la $a0,msg2     #message2 output
	syscall         #
    #after execution of the branch the program will be terminated
	j exit
