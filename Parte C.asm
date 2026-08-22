.include "m328pbdef.inc"
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
	breq Secuencia_1

	cpi r17, 2
	breq Secuencia_2

	cpi r17, 3
	breq Secuencia_3

	cpi r17, 4
	breq Secuencia_4

	cpi r17, 5
	breq Secuencia_5

	cpi r17, 6
	breq Secuencia_6

	cpi r17, 7
	breq Secuencia_7

	cpi r17, 8
	breq Secuencia_8


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
	brne Selector
    ldi r17, 1
	rjmp Selector

Anterior: 
	dec r17
	cpi r17, 0
	brne Selector
	ldi r17, 8
	rjmp Selector 

Reset:
	ldi r17, 1
	rjmp Selector
