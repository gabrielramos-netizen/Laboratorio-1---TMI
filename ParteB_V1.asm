.include "m328pdef.inc"
.org 0x00

;CONFIGURACIÓN DE PUERTOS
    ; Configuramos el Puerto B completo como Salida 
    ldi r16, 0b01111111
    out DDRB, r16

    ; Configurar PD2, PD3 y PD4 como entradas
    ldi r16, 0b00000000
    out DDRD, r16
    
    ; Activar resistencias Pull-Up en PD2, PD3 y PD4
    ldi r16, (1 << PD2) | (1 << PD3) | (1 << PD4)
    out PORTD, r16

    ; r17 guardará el valor del contador que inicia en 0
    ldi r17, 0

;BUCLE PRINCIPAL
bucle_principal:
    cpi r17, 0
    brne verificar_1
    rjmp num_0
verificar_1:
    cpi r17, 1
    brne verificar_2
    rjmp num_1
verificar_2:
    cpi r17, 2
    brne verificar_3
    rjmp num_2
verificar_3:
    cpi r17, 3
    brne verificar_4
    rjmp num_3
verificar_4:
    cpi r17, 4
    brne verificar_5
    rjmp num_4
verificar_5:
    cpi r17, 5
    brne verificar_6
    rjmp num_5
verificar_6:
    cpi r17, 6
    brne verificar_7
    rjmp num_6
verificar_7:
    cpi r17, 7
    brne verificar_8
    rjmp num_7
verificar_8:
    cpi r17, 8
    brne verificar_9
    rjmp num_8
verificar_9:
    cpi r17, 9
    brne salto_leer_botones
    rjmp num_9

salto_leer_botones:
    rjmp leer_botones

num_0:
    ldi r16, ~0b00111111 ; podriamos haber usado "com" en lugar de "~" pero nos ahorra varias lineas de codigo
    rjmp mostrar_numero

num_1:
    ldi r16, ~0b00000110
    rjmp mostrar_numero

num_2:
    ldi r16, ~0b01011011
    rjmp mostrar_numero

num_3:
    ldi r16, ~0b01001111
    rjmp mostrar_numero

num_4:
    ldi r16, ~0b01100110
    rjmp mostrar_numero

num_5:
    ldi r16, ~0b01101101
    rjmp mostrar_numero

num_6:
    ldi r16, ~0b01111101
    rjmp mostrar_numero

num_7:
    ldi r16, ~0b00000111
    rjmp mostrar_numero

num_8:
    ldi r16, ~0b01111111
    rjmp mostrar_numero

num_9:
    ldi r16, ~0b01101111
    rjmp mostrar_numero

mostrar_numero:
    out PORTB, r16
    rjmp leer_botones

; --- ESCANEO DE BOTONES ---
leer_botones:
    sbic PIND, PD2          ; Presionaron Incremento? (0 = SÍ)
    rjmp verificar_dec
    rjmp boton_incrementar

verificar_dec:
    sbic PIND, PD3          ; Presionaron Decremento? (0 = SÍ)
    rjmp verificar_reiniciar
    rjmp boton_decrementar

verificar_reiniciar:
    sbic PIND, PD4          ; Presionaron Reinicio? (0 = SÍ)
    rjmp bucle_principal    ; Si nadie presiona, repite el ciclo
    rjmp boton_reiniciar

; --- BOTÓN INCREMENTAR ---
boton_incrementar:
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
    sbis PIND, PD2          ; Espera hasta que se suelte el botón
    rjmp esperar_soltar_inc

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

    cpi r17, 9              ; Límite superior
    brne incremento_correcto
    rjmp bucle_principal
incremento_correcto:
    inc r17
    rjmp bucle_principal

; --- BOTÓN DECREMENTAR ---
boton_decrementar:
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
    sbis PIND, PD3          ; Espera hasta que se libere el botón
    rjmp esperar_soltar_dec

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

    cpi r17, 0              ; Límite inferior
    brne decremento_correcto
    rjmp bucle_principal
decremento_correcto:
    dec r17
    rjmp bucle_principal

; --- BOTÓN REINICIAR ---
boton_reiniciar:
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
    sbis PIND, PD4          ; Espera hasta que se libere el botón
    rjmp esperar_soltar_rein

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

    ldi r17, 0              ; Restablece a 0
    rjmp bucle_principal