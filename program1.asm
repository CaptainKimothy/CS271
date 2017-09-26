TITLE Program1					(program1.asm)

; Author: Kim McLeod
; Course / Project ID: Program 1		Date: 7.2.15 
; Description: Print name and title, get numbers from user,
; manipulate numbers and print again

INCLUDE Irvine32.inc

.data
Name		BYTE		"Kim McLeod", 0
Prog		BYTE		"Program 1", 0
num1		DWORD	?	; integer to be entered by user
num2		DWORD	?	; integer to be entered by user
sum		DWORD	?	; sum of ints
diff		DWORD	?	; dufference of ints
prod		DWORD	?	; product of ints
quo		DWORD	?	; quotient of ints
remain	DWORD	?	; remainder of quotient
goodBye	BYTE		"Goodbye!", 0


.code
main PROC

; print name and title

; display instructions for user

; prompt user to enter two numbers

; calculate sum, difference, product, integer quotient and remainder of nums
;results must be stored in named variables before output

; say goodbye
	

	exit     ; exit to operating system
main ENDP

END main