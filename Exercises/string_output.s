#This excersise will output a string message#
.text
    main:

li $v0,4    #calling the output function
la $a0,msg  #printing out the message
syscall     #calling the system function

li $v0,10   #calling the exit function
syscall     #calling the system function

.data       
msg: .asciiz "Hello World!"
