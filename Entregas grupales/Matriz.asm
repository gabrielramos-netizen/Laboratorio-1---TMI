.include "m328pdef.inc"

.org 0x0000
    rjmp reset

reset:
    ldi r16, low(ramend)
    out spl, r16
    ldi r16, high(ramend)
    out sph, r16

    ldi r16, 0xff
    out ddrd, r16
    out ddrb, r16
    
    ldi r16, 0x00
    out ddrc, r16
    ldi r16, 0x03
    out portc, r16
    
    clr r20

main:
    rcall leer_boton1
    rcall cargar_puntero_z
    rcall mostrar_imagen
    rjmp main

leer_boton1:
    sbic pinc, 0
    ret
    inc r20
    cpi r20, 5
    brne fin_b1
    clr r20
fin_b1:
    ret

cargar_puntero_z:
    ldi zl, low(carita_sonrisa)
    ldi zh, high(carita_sonrisa)
    ret

mostrar_imagen:
    ldi r17, 0b00000001
    ldi r18, 8

bucle_filas:
    out portd, r17
    lpm r16, z+
    out portb, r16
    rcall retardo_2ms
    
    ldi r16, 0x00
    out portb, r16
    
    lsl r17
    dec r18
    brne bucle_filas
    ret

retardo_2ms:
    ldi r19, 200
l1: dec r19
    brne l1
    ret

carita_sonrisa:
    .db 0b00000000, 0b01100110
    .db 0b01100110, 0b00000000
    .db 0b10000001, 0b01000010
    .db 0b00111100, 0b00000000