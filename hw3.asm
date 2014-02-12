.data
	msg1: .asciiz "Initial array is:\n"
	msg2: .asciiz "Insertion sort is finished!\n"
	
	printarray1: .asciiz "["
	printarray2: .asciiz " ]/n"
	space: .asciiz " "
	
		.align 5
	data:	.asciiz "Joe"
		.align 5
		.asciiz "Jenny"
		.align 5
		.asciiz "Jill"
		.align 5
		.asciiz "John"
		.align 5
		.asciiz "Jeff"
		.align 5
		.asciiz "Joyce"
		.align 5
		.asciiz "Jerry"
		.align 5
		.asciiz "Janice"
		.align 5
		.asciiz "Jake"
		.align 5
		.asciiz "Jonna"
		.align 5
		.asciiz "Jack"
		.align 5
		.asciiz "Jocelyn"
		.align 5
		.asciiz "Jessie"
		.align 5
		.asciiz "Jess"
		.align 5
		.asciiz "Janet"
		.align 5
		.asciiz "Jane"
		
		.align 2
	array: .space 64 # 16 pointers to strings: 16*4 = 64

.text

.globl main

main:
	jal initialize			# {char * data[] = {"Joe", "Jenny", "Jill", "John", "Jeff", "Joyce",
					#	"Jerry", "Janice", "Jake", "Jonna", "Jack", "Jocelyn",
					#	"Jessie", "Jess", "Janet", "Jane"};

 					
	la $a0, msg1			# printf("Initial array is:\n");
	li $v0, 4
	syscall
	
	la $a0, array			# print_array(data, size);
	jal print_array
					
	la $a0, array			# insertSort(data, size);
	jal insertSort
					
	la $a0, msg2			# printf("Insertion sort is finished!\n");
	li $v0, 4
	syscall

	la $a0, array			# print_array(data, size);
	jal print_array
	
	li $v0, 10			# exit(0);
	syscall
	
initialize:
	mul $t3, $t0, 32
	la $t1, data($t3)
		
	mul $t2, $t0, 4
	sw $t1, array($t2)
		
	addi $t0, $t0, 1
	blt $t0, 16, initialize
	
	jr $ra
	
print_array:
	move $t0, $a0
	la $t1, 16
	
	la $a0, printarray1		# printf("[");
	li $v0, 4
	syscall
	
	li $t2, 0			# int i=0;
	
	print_array_loop:
		mul $t3, $t2, 4
		add $t4, $t3, $t0
		
		la $a0, space		# printf("  %s"	
		li $v0, 4
		syscall
		
		lw $a0, ($t4)
		li $v0, 4
		syscall
		
		addi $t2, $t2, 1 	# a[i++]
		 
		bne $t2, $t1 print_array_loop # i < size
		
	la $a0, printarray2		 # printf(" ]\n");

	li $v0, 4
	syscall
	
	jr $ra	
      		
str_lt:
	
	move $t0, $a0
	move $t1, $a1
	
	str_lt_loop:
	    	lb $t2, 0($t0)
   		lb $t3, 0($t1)
   		
		beqz $t2, str_lt_endloop # *x!='\0'
		beqz $t3, str_lt_endloop # *y!='\0'
		
		blt $t2, $t3, return1	 # if ( *x < *y ) return 1;
		blt $t3, $t2, return0	 # if ( *y < *x ) return 0;
		
		addi $t0, $t0, 1	 # x++
		addi $t1, $t1, 1	 # y++
		
		j str_lt_loop
		
	str_lt_endloop:
		beqz $t1, return0	# if ( *y == '\0' ) return 0;
		j return1
		
	return0:
		la $v0, 0
		j str_lt_end
	
	return1:
		la $v0 1
		
	str_lt_end:

		jr $ra
	
insertSort:
	addi $sp, $sp, -12				
	sw $ra, 0($sp)     				
  	sw $a0, 4($sp)   				
  	la $a1, 16
  	sw $a1, 8($sp)     				
  
  	li $s0, 1          			# $s0 = i = i
  
  	outer_loop:
    		la $t0, 16
    		ble $t0, $s0, outer_end
    
    		mul $t1, $s0, 4
    		lw $t0, 4($sp)
    		add $s2, $t0, $t1
    		lw $s2, ($s2)
  
    		addi $s1, $s0, -1  		#s0 = j = i - 1
    
    	inner_loop:
      		bltz  $s1, inner_loop_end	# i < length
      
      		mul $t1, $s1 4
      		lw $t0, 4($sp)
      		add $t0, $t0, $t1
		move $a0, $s2
      		lw $t0, ($t0)
      		move $a1, $t0
      
      		jal str_lt			# str_lt(value, a[j])
      
      		beqz $v0 inner_loop_end
      
      						# a[j+1] = a[j]
      		lw $t0, 4($sp)
      		mul $t1, $s1, 4
      		add $t0, $t1, $t0
      		add $t1, $t0, 4  		# a[j+1]
      		
      		lw $t2, 0($t0)
      		sw $t2, 0($t1)
      
      		addi $s1, $s1, -1  		# j--
      		j inner_loop
    
    	inner_loop_end:
   						# a[j+1] = value
   		mul $t1, $s1, 4
   		lw $t0, 4($sp)
    		add $t0, $t0, $t1
    		add $t0, $t0, 4
    		sw $s2, 0($t0)
    
    		add $s0, $s0, 1  		# i++
    		j outer_loop
  
  	outer_end:
    		lw $ra, 0($sp)    
    		addi $sp, $sp, 12
    		jr $ra
	
	