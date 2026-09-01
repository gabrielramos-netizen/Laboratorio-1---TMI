.include "m328pdef.inc"
.org 0x00

    ; Salidas:
    ldi r16, 0b01111111
    out DDRD, r16

    ; Entradas
    ldi r16, 0b00000000
    out DDRC, r16
    
    ;====Pull-Up====
    ldi r16, (1 << 0) | (1 << 1) | (1 << 2)
    out PORTC, r16

    ;==Contador==
    ldi r17, 0


bucle_principal:
    cpi r17, 0
    breq num_0
    cpi r17, 1
    breq num_1
    cpi r17, 2
    breq num_2
    cpi r17, 3
    breq num_3
    cpi r17, 4
    breq num_4
    cpi r17, 5
    breq num_5
    cpi r17, 6
    breq num_6
    cpi r17, 7
    breq num_7
    cpi r17, 8
    breq num_8
    cpi r17, 9
    breq num_9
    rjmp leer_botones

;====Display====
num_0:
    ldi r16, 0b00111111
    rjmp mostrar_numero

num_1:
    ldi r16, 0b00000110
    rjmp mostrar_numero

num_2:
    ldi r16, 0b01011011
    rjmp mostrar_numero

num_3:
    ldi r16, 0b01001111
    rjmp mostrar_numero

num_4:
    ldi r16, 0b01100110
    rjmp mostrar_numero

num_5:
    ldi r16, 0b01101101
    rjmp mostrar_numero

num_6:
    ldi r16, 0b01111101
    rjmp mostrar_numero

num_7:
    ldi r16, 0b00000111
    rjmp mostrar_numero

num_8:
    ldi r16, 0b01111111
    rjmp mostrar_numero

num_9:
    ldi r16, 0b01101111
    rjmp mostrar_numero

mostrar_numero:
    out PORTD, r16

leer_botones:
    sbic PINC, 0
    rjmp verificar_dec
    rjmp boton_incrementar

verificar_dec:
    sbic PINC, 1
    rjmp verificar_reiniciar
    rjmp boton_decrementar

verificar_reiniciar:
    sbic PINC, 2
    rjmp bucle_principal
    rjmp boton_reiniciar

;====INCREMENTO====
boton_incrementar:
    ; Antirrebote al presionar
    ldi r18, 2
    ldi r19, 150
    ldi r20, 0
retardo_inc1:
    dec r20
    brne retardo_inc1
    dec r19
    brne retardo_inc1
    dec r18
    brne retardo_inc1

esperar_soltar_inc:
    sbis PINC, 0
    rjmp esperar_soltar_inc

    ; Antirrebote al soltar
    ldi r18, 2
    ldi r19, 150
    ldi r20, 0
retardo_inc2:
    dec r20
    brne retardo_inc2
    dec r19
    brne retardo_inc2
    dec r18
    brne retardo_inc2

    cpi r17, 9
    breq fin_inc
    inc r17
fin_inc:
    rjmp bucle_principal

;====Decremento===
boton_decrementar:
    ; Antirrebote al presionar
    ldi r18, 2
    ldi r19, 150
    ldi r20, 0
retardo_dec1:
    dec r20
    brne retardo_dec1
    dec r19
    brne retardo_dec1
    dec r18
    brne retardo_dec1

esperar_soltar_dec:
    sbis PINC, 1
    rjmp esperar_soltar_dec

    ; Antirrebote al soltar
    ldi r18, 2
    ldi r19, 150
    ldi r20, 0
retardo_dec2:
    dec r20
    brne retardo_dec2
    dec r19
    brne retardo_dec2
    dec r18
    brne retardo_dec2

    cpi r17, 0
    breq fin_dec
    dec r17
fin_dec:
    rjmp bucle_principal


boton_reiniciar:
    ; Antirrebote al presionar
    ldi r18, 2
    ldi r19, 150
    ldi r20, 0
retardo_rein1:
    dec r20
    brne retardo_rein1
    dec r19
    brne retardo_rein1
    dec r18
    brne retardo_rein1

esperar_soltar_rein:
    sbis PINC, 2
    rjmp esperar_soltar_rein

    ; Antirrebote al soltar
    ldi r18, 2
    ldi r19, 150
    ldi r20, 0
retardo_rein2:
    dec r20
    brne retardo_rein2
    dec r19
    brne retardo_rein2
    dec r18
    brne retardo_rein2

    ldi r17, 0
    rjmp bucle_principal
