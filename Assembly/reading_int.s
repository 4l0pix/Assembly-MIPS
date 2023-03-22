#Enter a number and then output it on the screen#
.text
    main:

li $v0,4    #string_output
la $a0,msg  #printing out the message
syscall     #calling the system function

li $v0,5     #reading integer
syscall      #calling system function
move $t0,$v0 #moving the v0 value to t0 variable

li $v0,1     #int_output
move $a0,$t0 #moving the value to the output parameter
syscall      #calling the system function

li $v0,10   #calling the exit function
syscall     #calling the system function

.data
msg: .asciiz "Enter a number->"
