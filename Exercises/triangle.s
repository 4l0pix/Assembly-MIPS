#Determine if a triangle is equilateral, isosceles, or scalene.
.data
equilateral: .asciiz "The triangle is equilateral"
isosceles: .asciiz "The triangle is isosceles"
scalene: .asciiz "The triangle is scalene"
msg: .asciiz "Enter a side->"

.text
	main:
    		li $t0,0		#equiterality points(count variable)
    		li $t4,1		#step variable(will raise the eq.points by one everytime a condition is true)
    
    		li $v0,4		#
    		la $a0,msg	#output mesasge for 1st side
    		syscall		#
    
    		li $v0,5		#
    		syscall		#input 1st side(a)
    		move $t1,$v0	#
    
    		li $v0,4		#
    		la $a0,msg	#output mesasge for 2nd side
    		syscall		#
    
    		li $v0,5		#
    		syscall		#input 2nd side(b)
    		move $t2,$v0	#
    
    		li $v0,4		#
    		la $a0,msg	#message for 3rd side
    		syscall		#
    
    		li $v0,5		#
    		syscall		#input 3rd side(c)
    		move $t3,$v0	#
    		
    		beq $t1,$t2,aEQb	
    		beq $t1,$t3,aEQc
    		beq $t2,$t3,bEQc
    			
    		
    		aEQb:
    			add $t0,$t0,$t4
    		aEQc:
    			add $t0,$t0,$t4
    		bEQc:
    			add $t0,$t0,$t4
    		
    		
    		count:
    			bge $t0,2,eq
    			bge $t0,1,isos
    			bge $t0,0,scal
    			
    		exit:
    			li $v0,10
    			syscall
    					
    		eq:
    			li $v0,4
    			la $a0,equilateral
    			syscall
    			j exit
    			
    		isos:
    			li $v0,4
    			la $a0,isosceles
    			syscall
    			j exit
    			
    		scal:
    			li $v0,4
    			la $a0,scalene
    			syscall
    			j exit
    			
    		
    		
    
