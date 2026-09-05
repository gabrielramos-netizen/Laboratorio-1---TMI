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
    rcall leer_botones
    rcall cargar_puntero_z
    rcall mostrar_imagen
    rjmp main

leer_botones:
    sbic pinc, 0
    rjmp probar_boton2
    inc r20
    cpi r20, 5
    brne fin_b1
    clr r20
fin_b1:
    ret

probar_boton2:
    sbic pinc, 1
    ret
    inc r20
    ret

cargar_puntero_z:
    cpi r20, 0
    breq cargar_sonrisa
    cpi r20, 1
    breq cargar_guino
    cpi r20, 2
    breq cargar_corazon
    cpi r20, 3
    breq cargar_asterisco
    
cargar_xd:
    ldi zl, low(figura_xd << 1)
    ldi zh, high(figura_xd << 1)
    ret

cargar_sonrisa:
    ldi zl, low(carita_sonrisa << 1)
    ldi zh, high(carita_sonrisa << 1)
    ret

cargar_guino:
    ldi zl, low(carita_guino << 1)
    ldi zh, high(carita_guino << 1)
    ret

cargar_corazon:
    ldi zl, low(corazon << 1)
    ldi zh, high(corazon << 1)
    ret

cargar_asterisco:
    ldi zl, low(asterisco << 1)
    ldi zh, high(asterisco << 1)
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

carita_guino:
    .db 0b00000000, 0b01100000
    .db 0b01100110, 0b00000000
    .db 0b10000001, 0b01000010
    .db 0b00111100, 0b00000000

corazon:
    .db 0b01100110, 0b11111111
    .db 0b11111111, 0b11111111
    .db 0b01111110, 0b00111100
    .db 0b00011000, 0b00000000

asterisco:
    .db 0b00011000, 0b10011001
    .db 0b01011010, 0b11111111
    .db 0b11111111, 0b01011010
    .db 0b10011001, 0b00011000

figura_xd:
    .db 0b00000000, 0b10101110
    .db 0b01001001, 0b01001001
    .db 0b01001001, 0b01001001
    .db 0b10101110, 0b00000000
