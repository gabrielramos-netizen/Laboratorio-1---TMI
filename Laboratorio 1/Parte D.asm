.include "m328pdef.inc"

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
	andi regA, 0x0F

	in regB, PINB
	andi regB, 0x0F     

	in selec, PINC
	andi selec, 0x07

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

	sbrc resF, 4           
	sec

	andi resF, 0x0F         
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
    sbrc resF, 4
    sec
    andi resF, 0x0F
    rjmp mostrar_resultado

op_inc:
    mov resF, regA
    inc resF
    andi resF, 0x0F
    rjmp mostrar_resultado

mostrar_resultado:
	in reg_flags, SREG   ; Guarda las banderas

	;====Resultado F====
	mov temp, resF
	lsl temp
	lsl temp
	lsl temp
	lsl temp
	ori temp, 0x0F
	out PORTD, temp 

	;====Banderas====
	mov temp, reg_flags
	lsl temp
	lsl temp
	lsl temp
	lsl temp
	ori temp, 0x0F
	out PORTB, temp

	;====Selector S====
	mov temp, selec
	lsl temp
	lsl temp
	lsl temp
	ori temp, 0x07
	out PORTC, temp

	rjmp bucle_principal
