TITLE MASM Template						(main.asm)

; Description: Project 1
; print to screen, get data from user, manipulate data
; 
; Revision date: 7.2.15

INCLUDE Irvine32.inc
.data
Name byte "Kim McLeod",0
Prog byte "Program 1",0




.code

main PROC
	call Clrscr
	call GetMaxXY

	exit
main ENDP

END main