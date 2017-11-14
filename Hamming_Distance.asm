.data
	string1: .asciiz "\nEnter the first string: "
	string2: .asciiz "\nEnter the second string: "
	hamming: .asciiz "\nThe hamming distance between the two strings is: "
	newLine: .asciiz "\n"
	buffer1: .space 100
	buffer2: .space 100
	
.text
	main:
	li $v0,4 #v0 coded to 4 printing string
	la $a0, string1 #loading the address of the string1 text
	syscall #printing the string1 text prompt
	
	li $v0,8 #take in input string
	la $a0,buffer1 #load byte space into address
	li $a1, 100 #allot the byte space for the string input
	move $s1,$a0 # save string input1 to s1
	syscall #execute the command
	
	#la $a0,buffer1 #reload byte space to primary address
	#move $a0,$s1 #loading the first input string taken into a0 register
	#li $v0,4 #v0 coded to 4 printing string
	#syscall #print the first input string
	
	li $v0,4 #v0 coded to 4 printing string
	la $a0, string2 #loading the string2 text in a0
	syscall #printing the string2 prompt
	
	li $v0,8 #take in input string
	la $a0,buffer2 #load byte space into address
	li $a1, 100 #allot the byte space for the string input
	move $s2,$a0 # save string input2 to s2
	syscall
	
	#la $a0,buffer2 #reload byte space to primary address
	#move $a0,$s2 #loading the first input string taken into a0 register
	#li $v0,4 #v0 coded to 4 printing string
	#syscall #print the second input string
	
	
	li $t0,0 #i=0
	li $t1,0 # count=0
	
	loop:
	
		lb   $s3, 0($s1) #s3 = input1[i]
		lb   $s4, 0($s2) #s4 = input2[i]
    		beq  $s3, $zero exit #if loop reaches end of string, go to exit
	
		
		bne $s3,$s4,count #if input1[i] != input2[i] go to count
		
		addi $s1,$s1,1 #go to the next character in the input_string1 
		addi $s2,$s2,1 #go to the next character in the input_string2
		j loop #go to beginning of the loop
		
	count:
		addi $t1,$t1,1 # count = count+1
		addi $s1,$s1,1 #go to the next character in the input_string1
		addi $s2,$s2,1 #go to the next character in the input_string2
		
		j loop #go to beginning of the loop
	
	exit:
	
		li $v0,4 #v0 coded in 4 to print the hamming text prompt
		la $a0,hamming #save address of the hamming text
		syscall # tell to print the hamming text
		
		li $v0,1 #v0 coded with 0 to print int
		move $a0,$t1 # hamming dist is stored in a0
		syscall #print the hamming distance
		
		li $v0,10 #end program
		syscall
	
	
	
	
	
	
	
	