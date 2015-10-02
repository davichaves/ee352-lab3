# Title: 	Lab3 assignment - Bubble sort & Stack
# Author: 	Davi Rodrigues Chaves
# Due Date:	11:00:00 AM. PST., Oct. 2nd, 2015, in Blackbaord
# Description:	1) Bubblesort the positive numbers in 'theArray' in ascending order 
#		2) and push the sorted positive numbers on 'theStack', the smallest first.
# Date:
.data
space: 		.asciiz " "
theArray: 	.word 31, 17, 92, 46, 172, 208, 13, 93, -1
theStack: 	.space 400
stackPointer: 	.word 0

string1:	.asciiz "\nOriginal array:\n"
string2:	.asciiz "\nSorted array:\n"
string3:	.asciiz "\nStack contents:\n"
	
.text
main:   
	la $t0, theStack 	# Load the address of the stack into $t0.
	la $t1, stackPointer	# Load the address of the stack pointer.
	sw $t0,($t1)		# Initialize the stack pointer with the stack address.
	
	la $a0, string1	# Load the address of 'string1' in to $a0.
	li $v0, 4	# Print the string in $a0.
	syscall
	
	jal PrintArray 	# Print the array.
	jal BubbleSort 	# Bubble sort.
	
	la $a0, string2	# Load the address of 'string2' in to $a0.
	li $v0, 4	# Print the string in $a0.
	syscall
	
	jal PrintArray
	
	jal pushStack   	# Push on the stack.     
	
	la $a0, string3	# Load the address of 'string1' in to $a0.
	li $v0, 4	# Print the string in $a0.
	syscall
	
    	jal printStack 	# Pop and print the stack.
    	li $v0, 10  	# Exit the program.   
    	syscall 

PrintArray:
	la $t0, theArray # Load the address of 'theArray'.
Cont1:	lw $t1, ($t0)	 # Load the value at $t0 into $t1.
	bltz $t1, ExitPrintArray # Exit the loop.
	
	add $a0,$t1,$0	# Move $t1 to $a0.
    	li $v0, 1      	# Print integer.              
    	syscall

    	la $a0, space	# Load a space:  " ".
    	li $v0, 4     	# Print string.               
    	syscall
	
	addi $t0,$t0,4	# Increment the address of 'theArray' by 4.
	j Cont1 	# Jump to 'Cont1'.
	
    	ExitPrintArray:	jr $ra		#return

BubbleSort:
	#########################
	# WRITE YOUR CODE HERE!	#
	#########################
	la	$t0, theArray     # move address of the array into $t0
	li      $s0, 1      # boolean swap = false.  0 --> false, 1 --> true
	li      $t1, 0      # j = 0;
	li      $t2, 0      # i = 0;
	li      $s1, 9      # array length
loop:
	beqz    $s0, exit       # exit if swap = false
	li      $s0, 0          # swap = false;
	addiu   $t1, $t1, 1  # j++;
	move    $t2, $0      # i = 0;
	subu    $s2, $s1, $t1  # s2 = length - j
forLoop:
	bge     $t2, $s2, exitForLoop   # if i>=s2, exit
	lw      $a0, 0($t0)         # a0 = array[i]
	lw      $a1, 4($t0)         # a1 = array[i+1]
	ble     $a0, $a1, update        # if array[i]<=array[i+1] skip
	sw      $a1, 0($t0)         # a[i+1] = a[i]
	sw      $a0, 4($t0)         # a[i] = a[i+1]
	li      $s0, 1                 # swap = true;
update:
	addiu   $t2, $t2, 1         # i++
	sll     $t3, $t2, 2         # t3 = i*4
	addu    $t0, $t0, $t3        # point to next element -->
	j       forLoop
exitForLoop:
	j   loop
exit:
	jr      $ra
	#########################
	# WRITE YOUR CODE HERE!	#
	#########################


pushStack:
	#########################
	# WRITE YOUR CODE HERE!	#
	#########################
	jr $ra		# Return

printStack:
	la $t0, theStack     # Load the address of stack.
	la $t1, stackPointer # Load the address of the stackpointer.
	lw $t2, ($t1)        # Load the value of the stack pointer.
	subi, $t2,$t2,4 # Decrement the stack pointer.
Cont3:	bgt $t0,$t2,ExitPrintStack
	lw $t3,($t2) # Load the stack value pointed by the stack pointer.
	add $a0,$t3,$0	# Move $t1 to $a0.
    	li $v0, 1      	# Print integer.              
    	syscall
    	la $a0, space	# Load a space:  " ".
    	li $v0, 4     	# Print string.               
    	syscall
    	subi, $t2,$t2,4 # Decrement the stack pointer.
    	j  Cont3 
	ExitPrintStack:
	sw $t2,($t1) # Update the stack pointer.
	jr $ra		# Return
