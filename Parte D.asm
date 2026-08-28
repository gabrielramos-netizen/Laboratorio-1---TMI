.include "m328pbdef.inc"

; --- Definición de nombres para los registros ---
.def regA = r16
.def regB = r17
.def selec = r18
.def temp = r19
.def resF = r20
.def reg_flags = r21

.cseg
.org 0x00

;====Entradas y Salidas====;
ldi temp, 0xF0
out DDRD, temp         
ldi temp, 0x0F
out PORTD, temp        

ldi temp, 0x70
out DDRB, temp         
ldi temp, 0x0F
out PORTB, temp         

ldi temp, 0x38
out DDRC, temp          
ldi temp, 0x07
out PORTC, temp        

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
	rjmp mostrar_resultado

op_resta:
    mov resF, regA
    sub resF, regB
    rjmp mostrar_resultado

op_suma:
	mov resF, regA
	add resF, regB
	rjmp mostrar_resultado

op_xor:
    mov resF, regA
    eor resF, regB
    rjmp mostrar_resultado

op_and:
    mov resF, regA
    and resF, regB
    rjmp mostrar_resultado

op_or:
    mov resF, regA
    or resF, regB
    rjmp mostrar_resultado

op_shl:
    mov resF, regA
    lsl resF
    rjmp mostrar_resultado

op_inc:
    mov resF, regA
    inc resF
    rjmp mostrar_resultado

mostrar_resultado:
	;===Banderas de estados===;
	in reg_flags, SREG

	;===Resultado F===;
	out PORTC, resF

	rjmp bucle_principal
