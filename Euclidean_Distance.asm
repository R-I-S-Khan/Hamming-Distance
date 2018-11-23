.data
	x1: .asciiz "\nEnter x1: "
	y1: .asciiz "\nEnter y1: "
	x2: .asciiz "\nEnter x2: "
	y2: .asciiz "\nEnter y2: "
	result: .asciiz "\nThe Euclidean distance is: "
.text
	main:
		
		li $v0,4	#loading v0=4 to print string "Enter x1:"
		la $a0,x1	#loading address of string "Enter x1" into a0
		syscall		#execute the printing process     
		
		li $v0,5	#loading v0=5 to read int into v0
		syscall 	#execute the command
		move $t1,$v0	# t1 = x1
		
		li $v0,4	#loading v0=4 to print string "Enter y1:"
		la $a0,y1	#loading address of string "Enter y1" into a0
		syscall		#execute the printing process
		
		li $v0,5	#loading v0=5 to read int into v0
		syscall		#execute the command
		move $t2,$v0	#t2 = y1
		
		li $v0,4	#loading v0=4 to print string "Enter x2:"
		la $a0,x2	#loading address of string "Enter x2" into a0
		syscall		#execute the printing process  
		
		li $v0,5	#loading v0=5 to read int into v0
		syscall		#execute the command
		move $t3,$v0	#t3 = x2
		
		li $v0,4	#loading v0=4 to print string "Enter y2:"
		la $a0,y2	#loading address of string "Enter y2" into a0
		syscall		#execute the printing process  
			
		li $v0,5	#loading v0=5 to read int into v0
		syscall		#execute the command
		move $t4,$v0	#t4 = y1
		
	
		sub $s0,$t1,$t2 #s0 = x1-y1
		sub $s1,$t3,$t4 #s1 = x2-y2
		
		mul $s0,$s0,$s0 #s0 = (x1-y1)^2
		mul $s1,$s1,$s1 #s1 = (x2-y2)^2
		
		add $s2,$s0,$s1 #s2 = (x1 - y1)^2 + (x2 - y2)^2 --> s2 = n
		
		addi $t0,$t0,1 # t0 = 1 --> k = 1
		while:
			mul $t6,$t0,$t0 # t6 = k*k
			sub $s3,$t6,$s2 # s3 = k*k -n
			sub $s4,$s2,$t6 # s4 = n - k*k
			
			bgt $s3,0,update # if s3 > 0, update the value of k 
			bgt $s4,0,update # if s4 > 0, update the value of k
			
			ble $s3,0,exit   #if s3 < 0, it means both and s3 and s4 are not greater than 0 as conditions have been checked earlier, so exit
			ble $s4,0,exit
			
		
		exit:
		
			li $v0,4 	
			la $a0,result
			syscall		#print the result prompt
			
			li $v0,1
			move $a0,$t0
			syscall		#printing the square root stored in t0, which is actually the value of k
			
			li $v0,10
			syscall 	#terminate the program
		update:
			li $t7,2	# t7 = 2
			div $t5,$s2,$t0 # t5 = n / k
			add $t0,$t0,$t5 # k = k + n/k
			div $t0,$t0,$t7  # k = k/2
			j while 	#go to while
			