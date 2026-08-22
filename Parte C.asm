.include "m328pbdef.inc"

.equ PB0 = 0
.equ PB1 = 1
.equ PB2 = 2
.equ PB3 = 3
.equ PB4 = 4
.equ PB5 = 5
.equ PB6 = 6
.equ PB7 = 7

.equ PD0 = 0
.equ PD1 = 1
.equ PD2 = 2

.org 0x00

INICIO:
;======= Punteto de pila =======;
	ldi r16, low(RAMEND)
	out SPL, r16
	ldi r16, high(RAMEND)
	out SPH, r16

;======= configuracion de leds (salidas)======
	ldi r16, (1<<PB0 | 1<<PB1 | 1<<PB2 | 1<<PB3 | 1<<PB4 | 1<<PB5 | 1<<PB6 | 1<<PB7)
	out DDRB, r16
 
;======= Configuracion de Botones (entradas)======
	ldi r16, (0<<PD0 | 0<<PD1 | 0<<PD2)
	out DDRD, r16

;===== PULL-UPS =====
	ldi r16, (1<<PD0 | 1<<PD1 | 1<<PD2)
	out PORTD, r16

	ldi r17, 1


Selector:
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
	ldi  r16, (1<<PB0 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi  r16, (1<<PB1 | 1<<PB6)
	out PORTB, r16
	rcall Pausa

	ldi  r16, (1<<PB2 | 1<<PB5)
	out PORTB, r16
	rcall Pausa

	ldi  r16, (1<<PB3 | 1<<PB4)
	out PORTB, r16
	rcall Pausa

	ldi  r16, (1<<PB2 | 1<<PB5)
	out PORTB, r16
	rcall Pausa

	ldi  r16, (1<<PB1 | 1<<PB6)
	out PORTB, r16
	rcall Pausa

	ldi  r16, (1<<PB0 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	rjmp Secuencia_1

Secuencia_2:
	ldi r16, (1<<PB0 | 1<<PB4)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB1 | 1<<PB5)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB2 | 1<<PB6)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB3 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB2 | 1<<PB6)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB1 | 1<<PB5)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB4)
	out PORTB, r16
	rcall Pausa

	rjmp Secuencia_2

Secuencia_3:
	ldi r16, (1<<PB0 | 1<<PB2 | 1<<PB4 |  1<<PB6)
	out PORTB, r16
	rcall Pausa

	ldi r16, ( 1<<PB1 | 1<<PB3| 1<<PB5 | 1<<PB7)
	out PORTB, r16
	rcall Pausa 

	rjmp Secuencia_3

Secuencia_4:
	ldi r16, (1<<PB0)
	out PORTB, r16
	rcall Pausa

	ldi r16, 0
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB1)
	out PORTB, r16
	rcall Pausa

	ldi r16, 0
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB1 | 1<<PB2)
	out PORTB, r16
	rcall Pausa

	ldi r16, 0
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB1 | 1<<PB2 | 1<<PB3)
	out PORTB, r16
	rcall Pausa

	ldi r16, 0
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB1 | 1<<PB2 | 1<<PB3 | 1<<PB4)
	out PORTB, r16
	rcall Pausa

	ldi r16, 0
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB1 | 1<<PB2 | 1<<PB3 | 1<<PB4 | 1<<PB5)
	out PORTB, r16
	rcall Pausa

	ldi r16, 0
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB1 | 1<<PB2 | 1<<PB3 | 1<<PB4 | 1<<PB5 | 1<<PB6)
	out PORTB, r16
	rcall Pausa

	ldi r16, 0
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB1 | 1<<PB2 | 1<<PB3 | 1<<PB4 | 1<<PB5 | 1<<PB6 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, 0
	out PORTB, r16
	rcall Pausa

	rjmp Secuencia_4

Secuencia_5:
	ldi r16, (1<<PB0)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB1)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB1 | 1<<PB2)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB1 | 1<<PB2 | 1<<PB3)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB2 | 1<<PB3 | 1<<PB4)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB3 | 1<<PB4 | 1<<PB5)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB4 | 1<<PB5 | 1<<PB6)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB5 | 1<<PB6 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB6 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB6 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB5 | 1<<PB6 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB4 | 1<<PB5 | 1<<PB6)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB3 | 1<<PB4 | 1<<PB5)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB2 | 1<<PB3 | 1<<PB4)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB1 | 1<<PB2 | 1<<PB3)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB1 | 1<<PB2)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB1)
	out PORTB, r16
	rcall Pausa

	rjmp Secuencia_5

Secuencia_6:
	ldi r16, (1<<PB0)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB1)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB1 | 1<<PB2)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB2 | 1<<PB3)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB3 | 1<<PB4)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB1 | 1<<PB4 | 1<<PB5)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB1 | 1<<PB2 | 1<<PB5 | 1<<PB6)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB2 | 1<<PB3 | 1<<PB6 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB3 | 1<<PB4 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB1 | 1<<PB4 | 1<<PB5)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB1 | 1<<PB2 | 1<<PB5 | 1<<PB6)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB2 | 1<<PB3 | 1<<PB6 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB3 | 1<<PB4 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB4 | 1<<PB5)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB5 | 1<<PB6)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB6 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB7)
	out PORTB, r16
	rcall Pausa

	rjmp Secuencia_6

Secuencia_7:
	ldi r16, (1<<PB0 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB1 | 1<<PB6 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB1 | 1<<PB2 | 1<<PB5 | 1<<PB6 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB1 | 1<<PB2 | 1<<PB3 | 1<<PB4 | 1<<PB5 | 1<<PB6 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB1 | 1<<PB2 | 1<<PB3 | 1<<PB4 | 1<<PB5 | 1<<PB6)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB2 | 1<<PB3 | 1<<PB4 | 1<<PB5)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB3 | 1<<PB4)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB2 | 1<<PB3 | 1<<PB4 | 1<<PB5)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB1 | 1<<PB2 | 1<<PB3 | 1<<PB4 | 1<<PB5 | 1<<PB6)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB1 | 1<<PB2 | 1<<PB3 | 1<<PB4 | 1<<PB5 | 1<<PB6 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB1 | 1<<PB2 | 1<<PB5 | 1<<PB6 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB1 | 1<<PB6 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, 0
	out PORTB, r16
	rcall Pausa

	rjmp Secuencia_7

Secuencia_8:
	ldi r16, (1<<PB0 | 1<<PB1 | 1<<PB2 | 1<<PB3 | 1<<PB4 | 1<<PB5 | 1<<PB6 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, 0
	out PORTB, r16
	rcall Pausa

	ldi r16, (1<<PB0 | 1<<PB1 | 1<<PB2 | 1<<PB3 | 1<<PB4 | 1<<PB5 | 1<<PB6 | 1<<PB7)
	out PORTB, r16
	rcall Pausa

	ldi r16, 0
	out PORTB, r16
	rcall Pausa
	rcall Pausa
	rcall Pausa

	rjmp Secuencia_8

Pausa:
	ldi r18, 20   

bucle_principal:
	ldi r19, 54 
	ldi r20, 250

L1:
	dec r20
	brne L1
	dec r19
	brne L1	

	sbis PIND, PD0
	rjmp Siguiente

	sbis PIND, PD1
	rjmp Anterior 

	sbis PIND, PD2
	rjmp Reset

	dec r18
	brne bucle_principal

	ret

Siguiente:
	inc r17
	cpi r17, 9
	brne no_vuelve1
	ldi r17, 1
no_vuelve1:
	rjmp Selector

Anterior: 
	dec r17
	cpi r17, 0
	brne no_vuelve8
	ldi r17, 8
no_vuelve8:
	rjmp Selector 

Reset:
	ldi r17, 1
	rjmp Selector
