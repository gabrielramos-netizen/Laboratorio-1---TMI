.include "m328pdef.inc"

.org 0x0000
    rjmp reset

reset:
    ; === config pila ===
    ldi r16, low(ramend)
    out spl, r16
    ldi r16, high(ramend)
    out sph, r16

    ; === salidas ===
    ldi r16, 0xff
    out ddrd, r16 ; pines D
    out ddrb, r16 ; pines B
    
    ; === entradas y pull-ups ===
    ldi r16, 0x00
    out ddrc, r16 ; pines C entrada
    
    ldi r16, 0x03
    out portc, r16 ; pull up en PC0 y PC1
    
    clr r20 ; contador

; === loop principal ===
main:
    rcall leer_botones
    rcall cargar_puntero_z
    rcall mostrar_imagen
    rjmp main

; === rutinas de botones ===
leer_botones:
    sbic pinc, 0 ; chequeo btn 1
    rjmp probar_boton2
    
    inc r20
    cpi r20, 5
    brne esperar1
    clr r20

esperar1:
    ; antirrebote btn 1
    rcall retardo_50ms
    sbis pinc, 0
    rjmp esperar1
    ret

probar_boton2:
    sbic pinc, 1 ; chequeo btn 2
    ret
    
    ; xor para alternar la pareja
    ldi r16, 0x01
    eor r20, r16

esperar2:
    ; antirrebote btn 2
    rcall retardo_50ms
    sbis pinc, 1
    rjmp esperar2
    ret

; === cargar de imagen ===
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

; === barrido de la matriz ===
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

; === retardos ===
retardo_2ms:
    ldi r19, 200
l1: dec r19
    brne l1
    ret

retardo_50ms:
    ldi r21, 100
k1: ldi r22, 200
k2: dec r22
    brne k2
    dec r21
    brne k1
    ret

; === tablas de datos ===
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
