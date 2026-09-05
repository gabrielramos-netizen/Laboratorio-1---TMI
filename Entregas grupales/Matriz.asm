.include "m328pdef.inc"

.org 0x0000
    rjmp reset

reset:
    ldi r16, 0xff
    out ddrd, r16
    out ddrb, r16

main:
    rcall barrido_matriz
    rjmp main

barrido_matriz:
    ldi r17, 0b00000001
    ldi r18, 8

bucle_filas:
    out portd, r17
    ldi r16, 0xff
    out portb, r16
    rcall retardo_2ms
    
    lsl r17
    dec r18
    brne bucle_filas
    ret

retardo_2ms:
    ldi r19, 200
l1: dec r19
    brne l1
    ret
