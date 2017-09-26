TITLE Random Array


; Author: Kim McLeod
; Date: 8.4.15
; Program 5 A
; Due Date: 8.9.15
; Class: CS271-400
; Email: mcleodki@onid.oregonstate.edu

; Description:  Implement ReadVal and WriteVal procedures for 
; unsigned integers. Implement macros getString and displayString.
; Test implementations by asking user for 10 valid integers, storing
; them into an array, display the numbers, their sum, and their average. 

; Implementation note: Parameters are passed on the system stack.

INCLUDE Irvine32.inc

displayString		MACRO	buffer
	push		edx
	mov		edx, buffer  ; OFFSET
	call		WriteString
	pop		edx
ENDM		

getString		MACRO	instructions, saveTo, inputSize
	push			 ecx
	push			 edx
	displayString	 instructions 
	mov			 edx, saveTo	; OFFSET
	mov			 ecx, inputSize
	call			 ReadString
	pop			 edx
	pop			 ecx
ENDM




MAXSIZE = 100

.data
userInput		BYTE		MAXSIZE DUP(?)
changedInput	DWORD	MAXSIZE DUP(?)
writeInput	BYTE		MAXSIZE DUP(?)
stringChar	DWORD	?
correctNums	DWORD	0
hello1		BYTE		"Fun with Macros, etc!      by Kim McLeod",0
prompt1		BYTE		"Please enter a positive integer: ",0
reinstruct	BYTE		"Invalid integer. Please try again: ",0
arraySize		DWORD	10
xVar			DWORD	0
check1		BYTE		" Check 1 ",0
check2		BYTE		" Check 2 ",0
check3		BYTE		" Check 3 ",0
check4		BYTE		" Check 4 ",0
check5		BYTE		" Check 5 ",0
check6		BYTE		" Check 6 ",0
check7		BYTE		" Check 7 ",0
check8		BYTE		" Check 8 ",0
goodbye		BYTE		"Thank you! Come again!",0

.code

main PROC
	push		OFFSET hello1
	call		intro


	push		xVar
	push		OFFSET stringChar	
	push		OFFSET changedInput
	push		correctNums
	push		MAXSIZE
	push		OFFSET userInput 
	push		OFFSET reinstruct
	push		OFFSET prompt1			
	call		ReadVal

	push		LENGTHOF changedInput	;[ebp+20]
	push		OFFSET writeInput		;[ebp+16]
	push		xVar					;[ebp+12]
	push		OFFSET changedInput		;[ebp+8]
	call		WriteVal


	exit			; exit to operating system
main ENDP


; ***************************************************************
; Procedure uses displayString macro to display introductions. 
; receives: nothing
; returns: nothing
; preconditions: none
; registers changed: edx
; ***************************************************************

intro	PROC
	push			ebp
	mov			ebp, esp
	displayString	[ebp + 8]
	call			CrLf
	pop			ebp
	ret	4
intro	ENDP


; ***************************************************************
; Procedure uses displayString macro to display introductions. 
;* receives: nothing
;* returns: nothing
;* preconditions: none
;************************************************************************** registers changed: edx
; ***************************************************************

ReadVal	PROC
	push		ebp
	mov		ebp, esp



	; loop to get 10 strings	
	again:

	cld
	mov		eax, [ebp+8]	; prompt
	mov		ecx, [ebp+16]	; userInput
	mov		ebx, [ebp+20]	; MAXSIZE 
	;mov		edx, [ebp+32] - 1	; reset second MAXSIZE
	;mov		[ebp+20], edx

	getString	eax, ecx, ebx    ;  ;[ebp+8], [ebp+16], [ebp+20]  prompt1, userInput, MAXSIZE

	mov		ebx, 0
	mov		[ebp+36], ebx	; reset x variable	(old edx)
	mov		esi, [ebp+16]	; move user input into esi
	mov		ecx, [ebp+28]	; changedInput array starting address
		displayString	OFFSET check2
	call	crlf
	





	; see if digit is from 48 to 57, inclusive
	numberCheck:
displayString	OFFSET check3
call	crlf
	xor		eax, eax
	lodsb
	cmp		eax, 0	;[ebp+32]
	je		moreNums
	mov		ebx, 48	;ebx
	cmp		eax, ebx	;eax, ebx
	jge		checkLow
	jmp		rePrompt

	checkLow:
	mov		ebx, 57
	cmp		eax, ebx
	jle		convert
;displayString	OFFSET check4
;call	crlf
	jmp		rePrompt




	; multiply x by ten and add the value in array[k]
	convert:
displayString	OFFSET check5
call	crlf
	mov		edi, eax	; move array[k] to bigger register
	sub		edi, 48	;ecx
	mov		eax, [ebp+36]	; x into eax (old edx)
	mov		ebx, 10
	mul		ebx		; x * 10
	add		eax, edi 	; x + array[k]
	mov		[ebp+36], eax
		call		WriteDec
	call	crlf
	mov		edx, [[ebp+32]]
	cmp		edx, 0
	jg		numberCheck
displayString	OFFSET check6
call	crlf
	



	moreNums:
	;mov		ebx, [ebp+28]	; @changedInput
	;add		ebx, 4

	mov		eax, [[ebp+36]]
	mov		[ecx], eax	; save number to new array
	add		ecx, 4		; move to next spot
	mov		ebx, [ebp+24]	; address of correctNums
	inc		ebx			; correctNums	
	mov		[ebp+24], ebx	
	cmp		ebx, 10
	jl		again



	jmp		exitNumCheck


	rePrompt:
displayString	OFFSET check7
call	crlf
	displayString		[ebp+12]
	jmp				again


	exitNumCheck:
displayString	OFFSET check8
call	crlf

	pop		ebp
	ret		32



ReadVal	ENDP



; ***************************************************************
; Procedure uses displayString macro to display introductions. 
; receives: nothing
; returns: nothing
; preconditions: none
; registers changed: edx
; ***************************************************************


	;push		OFFSET writeInput		;[ebp+16]
	;push		xVar					;[ebp+12]
	;push		OFFSET changedInput		;[ebp+8]


WriteVal	PROC

	push		ebp
	mov		ebp, esp
	std
	mov		edi, [ebp+16]		; @ writeInput
	mov		eax, [ebp+8]		; @ changedInput
	mov		ebx, 10
	mov		esi, 10
	displayString	OFFSET check1
	call	crlf

	again:
	xor		ecx, ecx
	call crlf
	cmp		esi, 0
	je		exitWrite

	convert:
	CDQ
	div		ebx
	;mov		eax, edx
	cmp		edx, 0	;eax

	displayString	OFFSET check2
	call	crlf

	jg		write
	add		al, 48
	;mov		al, dl

	displayString	OFFSET check3
	call	crlf

	stosb

	displayString	OFFSET check4
	call	crlf

	jmp		convert



	displayString	OFFSET check5
	call	crlf
	write:
	displayString		edi
	call	crlf
	displayString	OFFSET check6
	call	crlf
		dec		esi

	jmp		again

	displayString	OFFSET check7
	call	crlf

	exitWrite:
	pop		ebp
	ret		16
WriteVal	ENDP








END main