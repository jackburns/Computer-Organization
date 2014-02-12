
.data
	prompt: .asciiz "Positive Integer: "
	msgp1: .asciiz "The value of factorial("
	mgsp2: .asciiz ") is: "
.text

main:
	#printf("Positive integer: ");
	la $a0, prompt
	li $v0, 4
	syscall
	
	#scanf("%d", &number);
	li $v0, 5
	syscall
	move $a0, $v0

	bltz $a0, main
	sw $a0, 8($sp)
	
	jal factorial
	
	move $t0, $v0
	lw $t1, 8($sp)
	#printf("The value of 'factorial(%d)' is:  %d\n",
	# number, factorial(number));
	la $a0, msgp1
	li $v0, 4
	syscall
	
	move $a0, $t1
	li $v0, 1
	syscall
	
	la $a0, mgsp2
	li $v0, 4
	syscall
	
	move $a0, $t0
	li $v0, 1
	syscall
	
	#return 0;
	li $v0, 10
	syscall
	
factorial:
	#if (x == 0)
	bgt $a0, 0, loop
	#return 1;
	li $v0, 1
	jr $ra
	
	
loop:		
	addi $sp, $sp -12
	sw $ra 0($sp)
	sw $a0, 4($sp)

	#x-1
	addi $a0, $a0, -1
	
	jal factorial

	lw $ra, 0($sp)	
	lw $a0, 4($sp)
	addi $sp, $sp, 12
	
	#x * factorial(x-1);
	mul $v0, $v0, $a0
	
	#return
	jr $ra

	
	

	
