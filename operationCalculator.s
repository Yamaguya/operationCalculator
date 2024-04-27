#ΤΖΟΒΑΡΑΣ, ΑΛΕΞΑΝΔΡΟΣ, 3150171

.data

# PROMPTS ________________

intro: .asciiz "Addition: +\nSubtraction: -\nMultiplication: *\nDivision: /\nRemainder: %\n"
numprompt: .asciiz "Number: "
tel: .asciiz "Operation: "
resmsg: .asciiz "Result: "
errormsg: .asciiz "Error: Invalid Input"
cont: .asciiz "\nEnter '1' if you wish to calculate a new operation or '2' to exit\n"

# OPERATIONS _____________

oper: .space 1
addsign: .asciiz "+"
subsign: .asciiz "-"
mulsign: .asciiz "*"
divsign: .asciiz "/"
remsign: .asciiz "%"
eqsign: .asciiz "="

.text
.globl main
		
main:  
		li  $v0, 4			# Prints introductory prompt
        la $a0, intro
        syscall
		
		li  $v0, 4			# Prints number input prompt
        la $a0, numprompt
        syscall
		
		li $v0, 5			# Reads first integer
		syscall
		move $s0, $v0
		
		j loop
		
loop:
		li $v0, 4			# Prints "Operator: "
		la $a0, tel
		syscall
		
		li $v0, 8			# Reads operator
		la $a0, oper
		syscall
		
		lb $s1, oper
		
		li $t1, '+'				# Loads constant for addition
		li $t2, '-'				# Loads constant for subtraction
		li $t3, '*'				# Loads constant for multiplication
		li $t4, '/'				# Loads constant for division
		li $t5, '%'				# Loads constant for remainder
		li $t6, '='				# Loads constant for equals sign
		
		beq $s1, $t1, addition			# If user chose addition jump to addition
		beq $s1, $t2, subtraction		# If user chose subtraction jump to subtraction
		beq $s1, $t3, multiplication		# If user chose multiplication jump to multiplication
		beq $s1, $t4, division			# If user chose division jump to division
		beq $s1, $t5, remainder			# If user chose remainder jump to remainder
		beq $s1, $t6, result			# If user chose equals sign jump to result
		
		j error

addition:
		li  $v0, 4			# Prints number input prompt
        la $a0, numprompt
        syscall
		
		li $v0, 5			# Reads second integer
		syscall
		move $s2, $v0
		
		add $s0, $s0, $s2 

		j loop				# Back to loop

subtraction:
		li  $v0, 4			# Prints number input prompt
        la $a0, numprompt
        syscall
		
		li $v0, 5			# Reads second integer
		syscall
		move $s2, $v0
		
		sub $s0, $s0, $s2 

		j loop				# Back to loop

multiplication:
		li  $v0, 4			# Prints number input prompt
        la $a0, numprompt
        syscall
		
		li $v0, 5			# Reads second integer
		syscall
		move $s2, $v0
		
		mul  $s0, $s0, $s2 

		j loop				# Back to loop

division:
		li  $v0, 4			# Prints number input prompt
        la $a0, numprompt
        syscall
		
		li $v0, 5			# Reads second integer
		syscall
		move $s2, $v0
		
		div $s0, $s0, $s2 

		j loop				# Back to loop

remainder:
		li  $v0, 4			# Prints number input prompt
        la $a0, numprompt
        syscall
		
		li $v0, 5			# Reads second integer
		syscall
		move $s2, $v0
		
		rem $s0, $s0, $s2 

		j loop				# Back to loop

result:
		la $a0, resmsg			# Prints "Result: "
		li  $v0, 4
		syscall
		
		move $a0, $s0			# Prints result
		li $v0, 1
		syscall
		
		la $a0, cont			# Prints "Would you like to enter a new operation?"
		li  $v0, 4		
		syscall
		
		li $v0, 5			# Reads answer
		syscall
		move $s4, $v0
		
		beq $s4, 1, main
		
		j exit
		
error:
		li  $v0, 4			# Prints error message
		la $a0, errormsg
		syscall
		
		j exit
		
exit: 
		li $v0, 10
		syscall