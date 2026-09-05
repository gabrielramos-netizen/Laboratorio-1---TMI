.include "m328pbdef.inc"

.equ PD0 = 0
.equ PD1 = 1
.equ PD2 = 2
.equ PD3 = 3
.equ PD4 = 4
.equ PD5 = 5
.equ PD6 = 6
.equ PD7 = 7

.equ PC0 = 0
.equ PC1 = 1
.equ PC2 = 2

.org 0x00
rjmp INICIO

INICIO:
;======= Puntero de pila =======;
	ldi r16, low(RAMEND)
	out SPL, r16
	ldi r16, high(RAMEND)
	out SPH, r16

;======= configuracion de leds (salidas)======
	ldi r16, 0xFF
	out DDRD, r16
	clr r16
	out PORTD, r16
 
;======= Configuracion de Botones (entradas)======
	clr r16
	out DDRC, r16
	out PORTC, r16          

	ldi r17, 1   

Selector:
;======= Limpieza de Pila =======;
	ldi r16, low(RAMEND)
	out SPL, r16
	ldi r16, high(RAMEND)
	out SPH, r16

	cpi r17, 1
	brne no_es1
	rjmp Secuencia_1
no_es1:

	cpi r17, 2
	brne no_es2
	rjmp Secuencia_2
no_es2:

	cpi r17, 3
	brne no_es3
	rjmp Secuencia_3
no_es3:

	cpi r17, 4
	brne no_es4
	rjmp Secuencia_4
no_es4:

	cpi r17, 5
	brne no_es5
	rjmp Secuencia_5
no_es5:

	cpi r17, 6
	brne no_es6
	rjmp Secuencia_6
no_es6:

	cpi r17, 7
	brne no_es7
	rjmp Secuencia_7
no_es7:

	cpi r17, 8
	brne no_es8
	rjmp Secuencia_8
no_es8:

	ldi r17, 1
	rjmp Selector


Secuencia_1:
	ldi r16, (1<<PD0 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD1 | 1<<PD6)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD2 | 1<<PD5)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD3 | 1<<PD4)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD2 | 1<<PD5)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD1 | 1<<PD6)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	rjmp Secuencia_1

Secuencia_2:
	ldi r16, (1<<PD0 | 1<<PD4)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD1 | 1<<PD5)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD2 | 1<<PD6)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD3 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD2 | 1<<PD6)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD1 | 1<<PD5)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD4)
	out PORTD, r16
	rcall Pausa

	rjmp Secuencia_2

Secuencia_3:
	ldi r16, (1<<PD0 | 1<<PD2 | 1<<PD4 | 1<<PD6)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD1 | 1<<PD3 | 1<<PD5 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	rjmp Secuencia_3

Secuencia_4:
	ldi r16, (1<<PD0)
	out PORTD, r16
	rcall Pausa

	ldi r16, 0
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD1)
	out PORTD, r16
	rcall Pausa

	ldi r16, 0
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD1 | 1<<PD2)
	out PORTD, r16
	rcall Pausa

	ldi r16, 0
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD1 | 1<<PD2 | 1<<PD3)
	out PORTD, r16
	rcall Pausa

	ldi r16, 0
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD1 | 1<<PD2 | 1<<PD3 | 1<<PD4)
	out PORTD, r16
	rcall Pausa

	ldi r16, 0
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD1 | 1<<PD2 | 1<<PD3 | 1<<PD4 | 1<<PD5)
	out PORTD, r16
	rcall Pausa

	ldi r16, 0
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD1 | 1<<PD2 | 1<<PD3 | 1<<PD4 | 1<<PD5 | 1<<PD6)
	out PORTD, r16
	rcall Pausa

	ldi r16, 0
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD1 | 1<<PD2 | 1<<PD3 | 1<<PD4 | 1<<PD5 | 1<<PD6 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, 0
	out PORTD, r16
	rcall Pausa

	rjmp Secuencia_4

Secuencia_5:
	ldi r16, (1<<PD0)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD1)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD1 | 1<<PD2)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD1 | 1<<PD2 | 1<<PD3)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD2 | 1<<PD3 | 1<<PD4)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD3 | 1<<PD4 | 1<<PD5)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD4 | 1<<PD5 | 1<<PD6)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD5 | 1<<PD6 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD6 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD6 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD5 | 1<<PD6 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD4 | 1<<PD5 | 1<<PD6)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD3 | 1<<PD4 | 1<<PD5)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD2 | 1<<PD3 | 1<<PD4)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD1 | 1<<PD2 | 1<<PD3)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD1 | 1<<PD2)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD1)
	out PORTD, r16
	rcall Pausa

	rjmp Secuencia_5

Secuencia_6:
	ldi r16, (1<<PD0)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD1)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD1 | 1<<PD2)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD2 | 1<<PD3)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD3 | 1<<PD4)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD1 | 1<<PD4 | 1<<PD5)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD1 | 1<<PD2 | 1<<PD5 | 1<<PD6)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD2 | 1<<PD3 | 1<<PD6 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD3 | 1<<PD4 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD1 | 1<<PD4 | 1<<PD5)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD1 | 1<<PD2 | 1<<PD5 | 1<<PD6)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD2 | 1<<PD3 | 1<<PD6 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD3 | 1<<PD4 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD4 | 1<<PD5)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD5 | 1<<PD6)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD6 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD7)
	out PORTD, r16
	rcall Pausa

	rjmp Secuencia_6

Secuencia_7:
	ldi r16, (1<<PD0 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD1 | 1<<PD6 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD1 | 1<<PD2 | 1<<PD5 | 1<<PD6 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD1 | 1<<PD2 | 1<<PD3 | 1<<PD4 | 1<<PD5 | 1<<PD6 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD1 | 1<<PD2 | 1<<PD3 | 1<<PD4 | 1<<PD5 | 1<<PD6)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD2 | 1<<PD3 | 1<<PD4 | 1<<PD5)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD3 | 1<<PD4)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD2 | 1<<PD3 | 1<<PD4 | 1<<PD5)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD1 | 1<<PD2 | 1<<PD3 | 1<<PD4 | 1<<PD5 | 1<<PD6)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD1 | 1<<PD2 | 1<<PD3 | 1<<PD4 | 1<<PD5 | 1<<PD6 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD1 | 1<<PD2 | 1<<PD5 | 1<<PD6 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD1 | 1<<PD6 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, 0
	out PORTD, r16
	rcall Pausa

	rjmp Secuencia_7

Secuencia_8:
	ldi r16, (1<<PD0 | 1<<PD1 | 1<<PD2 | 1<<PD3 | 1<<PD4 | 1<<PD5 | 1<<PD6 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, 0
	out PORTD, r16
	rcall Pausa

	ldi r16, (1<<PD0 | 1<<PD1 | 1<<PD2 | 1<<PD3 | 1<<PD4 | 1<<PD5 | 1<<PD6 | 1<<PD7)
	out PORTD, r16
	rcall Pausa

	ldi r16, 0
	out PORTD, r16
	rcall Pausa
	rcall Pausa
	rcall Pausa

	rjmp Secuencia_8

Pausa:
	ldi r18, 50

bucle_principal:
	ldi r19, 100
bucle_interno:
	ldi r20, 200
L1:
	dec r20
	brne L1
	dec r19
	brne bucle_interno

	sbic PINC, PC0
	rjmp Siguiente

	sbic PINC, PC1
	rjmp Anterior

	sbic PINC, PC2
	rjmp Reset

	dec r18
	brne bucle_principal
	ret

Siguiente:
esperar_soltar_sig:
	sbic PINC, PC0         
	rjmp esperar_soltar_sig

	inc r17
	cpi r17, 9
	brne no_vuelve1
	ldi r17, 1
no_vuelve1:
	rjmp Selector

Anterior:
esperar_soltar_ant:
	sbic PINC, PC1          
	rjmp esperar_soltar_ant

	dec r17
	cpi r17, 0
	brne no_vuelve8
	ldi r17, 8
no_vuelve8:
	rjmp Selector

Reset:
esperar_soltar_res:
	sbic PINC, PC2         
	rjmp esperar_soltar_res

	ldi r17, 1
	rjmp Selector
