#In this exersise we will perform a double condition check. We as a number as input and if its between two bounds (10<=num<=20). If the number is in bounds we output a message "In bounds" otherwise, input is requested again. If a number in bounds is given then we output a message "In bounds with tries->" and we also output the number of unsuccessful tries.

.data
msg0: .asciiz "Enter a number->"
msg1: .asciiz "\nIn bounds with tries->"
msg2: .asciiz "\nTry again\n"

.text
	main:
	li $t0,0	#a register tha will count the unsuccessful tries
		input:	#this is the beginning of the input loop
			li $v0,4	#
			la $a0,msg0	#input message
			syscall		#
		
			li $v0,5	#
			syscall		#this regster will hold the input
			move $t1,$v0	#
			bge $t1, 10,continue 	#if the input is greater than 10 then we move on to the next condition(continue label)
			j error			#else we jump to the error label
		continue:
			ble $t1,20,inBounds		#if the input is less than 20 then the number is in bounds so we move to the next label
			j error				#else we jump to the error label
		inBounds:
			li $v0,4
			la $a0,msg1		#in bounds message
			syscall
		count:
			li $v0,1
			move $a0,$t0		#printing the number of tries 
			syscall
		
			li $v0,10	#exit
			syscall		#exit
		error:
			li $v0,4		#
			la $a0,msg2		#out of bounds message
			syscall			#
			add $t0,1		#raising count
			j input			#jumping to input
