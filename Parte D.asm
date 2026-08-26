.include "m328pbdef.inc

; --- Definición de nombres para los registros ---
.def regA = r16
.def regB = r17
.def selec = r18
.def temp = r19
.def resF = r20

.cseg
.org 0x00

;====ENTRADAS====;
clr temp
out DDRD, temp
out DDRB, temp
out DDRC, temp

bucle_principal:
	in regA, PIND
	in regB, PINB
	in selec, PINC

	cpi selec, 0
	breq op_clear

	cpi selec, 1
	breq op_resta

	cpi selec, 2
	breq op_suma

	cpi selec, 3
	breq op_xor

	cpi selec, 4
	breq op_and

	cpi selec, 5
	breq op_or

	cpi selec, 6
	breq op_shl

	cpi selec, 7
	breq op_inc

	;====OPERACIONES====;
op_clear:
	clr resF


