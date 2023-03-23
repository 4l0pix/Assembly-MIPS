#Adding two integers#
.text
    main:

li $t0,4        #loading the number 4 at the t0 variable
li $t1,8        #loading the number 8 at the t1 variable

add $t2,$t0,$t1 #using the add function and saving the result at the t2 variable

li $v0,4        #string_output
la $a0,msg      #printing out the message
syscall         #calling the system function

li $v0,1        #int_output
move $a0,$t2    #moving the t2 value to the output parameter
syscall         #calling the system function

li $v0,10   #
syscall     #exit

.data
msg: .asciiz "The result is->"
