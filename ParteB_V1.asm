.include "m328pdef.inc"
.org 0x00

;CONFIGURACIÓN DE PUERTOS
    ; Configuramos el Puerto B completo como Salida 
    ldi r16, 0b01111111
    out DDRB, r16

    ; Configurar PD2, PD3 y PD4 como entradas
    ldi r16, 0b00000000
    out DDRD, r16
    
    ; Activar resistencias Pull-Up en PD2 (Incremento), PD3 (Decremento) y PD4 (Reiniciar)
    ldi r16, (1 << PD2)  (1 << PD3) | (1 << PD4)
    out PORTD, r16

    ; r17 guardará el valor del contador que inicia en 0
    ldi r17, 0

;BUCLE PRINCIPAL
bucle_principal:
;En este caso comparamos el valor que contiene el r17 con un valor entero usando cpi
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
    rjmp leer_botones ;esta etiqueta la usaremos para definiri que botones se presionaron  

