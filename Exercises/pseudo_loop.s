#Print the message Hello World! 10 times without using a loop command

.data
msg: .asciiz "Hello World!\n"

.text
	main:
		li $t0,1				#a count variable
		li $t1,1				#a step variable
		
		start:				#start of the "loop" label
		
			li $v0,4			#
			la $a0,msg		#output the message
			syscall			#
			
			add $t0,$t0,$t1	#raise the count variable by 1
			
			ble $t0,10,start	#check the condition and if the count variable is less than 10 then continue
			
		li $v0,10				#
		syscall				#exit
