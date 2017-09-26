TITLE Program Template     (template.asm)

; Author: Kim McLeod
; Course / Project ID: Program 3                 Date: 7.16.15
; Description: Prompt user for integer in range 1-400
; print user-specified amount of composit numbers
 
INCLUDE Irvine32.inc

UPPER EQU okNum

.data
hello		BYTE		"Composite Numbers 		by Kim McLeod", 0
instruct_1	BYTE		"Enter the number of composite numbers to be displayed", 0
instruct_2	BYTE		"Enter an integer from 1-400, inclusive: ", 0
userNum		DWORD	?
reinstruct	BYTE		"Out of range. Enter a number [1 - 400]: ", 0
okNum		DWORD	?
counter		DWORD	0
comp			DWORD	?
spaces		BYTE		"     ", 0
loopCount		DWORD	?
composite		DWORD	?
printCount	DWORD	0
tester		DWORD	10
goodbye		BYTE		"Goodbye!", 0



.code
main PROC

	call intro
	call getData
	
	; set the loop counter
	mov		ecx, UPPER

	call showComposites
	call farewell


	exit	; exit to operating system
main ENDP

intro	PROC

; display program title and author
	mov		edx, OFFSET hello
	call		WriteString
	call		CrLf 
	call		CrLf


; display instructions
	mov		edx, OFFSET instruct_1
	call		WriteString
	call		CrLf

	ret
intro	ENDP



getData	PROC

; prompt for integer from 1-400
; to display composite numbers
	mov		edx, OFFSET instruct_2
	call		WriteString
	call		ReadInt
	mov		userNum, eax
	call		CrLf
	call		validate


	validate	PROC

	; validate input 
	
		mov		eax, 1
		mov		ebx, userNum
		cmp		eax, ebx
		jg		outOfRange
		mov		eax, 400
		cmp		eax, userNum
		jl		outOfRange
		jmp		numOkay

		outOfRange:
		mov		edx, OFFSET reinstruct
		call		WriteString
		call		ReadInt
		mov		userNum, eax
		call		CrLf
		loop		validate

		numOkay:
		mov		eax, userNum
		mov		okNum, eax

		ret
	validate	ENDP

	
	ret
getData	ENDP



showComposites		PROC

	; set necessary variables and see if number is composite
	inc		counter
	mov		comp, 2
	call		isComposite
	

	; if number was composite, jump to print
	; otherwise, increment ecx to preserve the loop number, and loop again
	mov		eax, composite
	cmp		eax, 1
	je		print
	inc		ecx
	loop		showComposites
	jmp		return


	print:
	; increment printCount variable to see if newLine needs to be added
	; if printCount is multiple of 10, jump to newLine
	mov		eax, counter
	call		WriteDec
	mov		edx, OFFSET spaces
	call		WriteString
	inc		printCount
	mov		eax, printCount
	cmp		eax, tester
	je		newLine
	loop		showComposites
	jmp		return
	
			
	newLine:		
	;print new lines and increment tester
	call		CrLf
	add		tester, 10	
	loop		showComposites
	jmp		return
	
	return:
	ret

showComposites		ENDP


isComposite		PROC
		
	mov		composite, 0		; set print variable to 0

	; if number is less than 4, set print variable to 0 and exit
	cmp		counter, 4
	jl		return    

	comparison:
			
		; if the comparison value is greater than or equal to our number
		; set print variable to 0 and return
		mov		eax, counter
		cmp		comp, eax
		jge		return   

		; otherwise, divide our number by the comparison value
		; if the remainder is 0, set print variable to 1 and exit
		; it remainder is not 0, set print variable to 0, increment the comparison value
		; and loop through again		
		mov		eax, counter
		mov		ebx, comp
		mov		edx, 0
		div		ebx
		cmp		edx, 0
		mov		composite, 1
		je		return
		mov		composite, 0
		inc		comp
		jmp		comparison
		
		return:			
		ret

	isComposite		ENDP

farewell		PROC
	call		CrLf
	mov		edx, OFFSET goodbye
	call		WriteString
	call		CrLf
	ret
farewell		ENDP

END	main














	 	

