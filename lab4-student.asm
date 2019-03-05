;Lab 4
;Computes T(n) = 2T(n-1)+ n, T(0) = 0
;Assume that n >=0

;Stack starts at 0x4000 (change as desired).

;A simple example of calling a subroutine that computes the Factorial of a number

	.orig 0x3000
Main
	LD R6,STACKBASE			;initialize stack pointer to 0x4000

	LD R1,n				;get n

	ADD R6,R6,#-1			;push n (argument) onto stack
	STR R1,R6,#0

	ADD R6,R6,#-1			;set aside one word on stack for return value

	JSR MyFunc			;call Sum subroutine

	;PUT YOUR CODE HERE TO GET RETURN VALUE AND STORE in R1
	LDR R1,R6,#0
	;PUT YOUR CODE HERE TO REMOVE ACTIVATION RECORD
	ADD R6,R6,#2

	HALT				;stop program

;-----------------------------------------------------------------
;subroutine Sum recursively computes sum from 1 up to argument given in R5+1
;Data Dictionary
;R0 - This register will hold the value to be put into the return value slot
;R1 - The value of the argument to this function. That is the content at R5+1
;R2 . This is the argument to the recursive subroutine call. Should be R1-1
;R5 - Frame pointer
;R6 - Stack Pointer

;Stack Contents:
;R5+0 - return value
;R5+1 - Parameter 1

MyFunc
	ADD R6,R6,#-1			;save R5, important since this routine may be called from another routine.
	STR R5,R6,#0

	ADD R5,R6,#1			;make R5 point to return value

	ADD R6,R6,#-1			;save R0 (since we will be using it)
	STR R0,R6,#0

	ADD R6,R6,#-1			;save R1 (since we will be using it)
	STR R1,R6,#0


	ADD R6,R6,#-1			;save R2 (since we will be using it)
	STR R2,R6,#0

	ADD R6,R6,#-1			;save R7 (since we will be doing recursive calls)
	STR R7,R6,#0

;PUT YOUR CODE HERE TO COMPUTE T(n)
	LDR R1,R5,#1
	BRp Recurse

Base
	STR R1,R5,#0
	BR Done
Recurse
	ADD R2,R1,#-1
	ADD R6,R6,#-1
	STR R2,R6,#0
	ADD R6,R6,#-1

	JSR MyFunc

	LDR R0,R6,#0
	ADD R6,R6,#2	;remove argumant and ret val from stack
	ADD R0,R0,R0	;2T(n-1)
	ADD R0,R0,R1	;+n

	STR R0,R5,#0	;store sum in ret val place
	;restoring register values
Done

	LDR R7,R6,#0			;restore R7
	ADD R6,R6,#1

	LDR R2,R6,#0			;restore R2
	ADD R6,R6,#1

	LDR R1,R6,#0			;restore R1
	ADD R6,R6,#1

	LDR R0,R6,#0			;restore R0
	ADD R6,R6,#1

	LDR R5,R6,#0			;restore R5
	ADD R6,R6,#1
	RET				;return from subroutine

;End of Subroutine Sum



STACKBASE	.FILL	0x4000
n		.FILL	5	;assume this value must be >= 0

		.END
