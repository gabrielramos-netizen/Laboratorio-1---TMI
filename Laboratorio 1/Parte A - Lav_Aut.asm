; LAVADORA AUTOMATICA - PARTE A
; Hicimos cambios, ahora decidimos hacerlo usando la pila, asi podemos usar rcall y ret. Además, se reduce la cantidad de lineas de codigo
; Anteriormente no funcionaba 
.include "m328pdef.inc"

.org 0x0000
    rjmp INICIO

; CONFIGURACIÓN DE PUERTOS
INICIO:
    ; Configuramos el Stack Pointer inicializandolo  
    ldi r16, LOW(RAMEND)
    out SPL, r16
    ldi r16, HIGH(RAMEND)
    out SPH, r16

    clr r16
    out PORTB, r16
    out PORTC, r16

    ; Puerto B (Pines 8 al 12 en el arduino): Salidas LEDs de Proceso
    ldi r16, 0b00011111
    out DDRB, r16

    ; Puerto C (Pines A0 al A2): Salidas LEDs de Carga 
    ldi r16, 0b00000111
    out DDRC, r16

    ; Puerto D (Pines 2 al 5): Entradas con Pull-Up activados
    clr r16
    out DDRD, r16
    ldi r16, 0b00111100   ; Activar Pull-ups en PD2, PD3, PD4, PD5
    out PORTD, r16

    clr r17               ; Inicializar Tipo de Carga en 0 (Ligera)

;definimos el bucle principal 
REPOSO:
    ; Encendemos el LED "Listo para lavar" (PB0 / Pin 8)
    ldi r16, 0b00000001
    out PORTB, r16

    ; Evaluamos el registro de carga r17 y saltamos al bloque que corresponda
    cpi r17, 0
    breq MOSTRAR_LIGERA

    cpi r17, 1
    breq MOSTRAR_MEDIA

    cpi r17, 2
    breq MOSTRAR_PESADA

    ; Control de seguridad: Si r17 no es 0, 1 o 2, reiniciar
    clr r17
    rjmp MOSTRAR_LIGERA

MOSTRAR_LIGERA:
    ldi r16, 0b00000001   ; PC0 / Pin A0
    out PORTC, r16
    rjmp REVISAR_BOTONES  

MOSTRAR_MEDIA:
    ldi r16, 0b00000010   ; PC1 / Pin A1
    out PORTC, r16
    rjmp REVISAR_BOTONES  

MOSTRAR_PESADA:
    ldi r16, 0b00000100   ; PC2 / Pin A2
    out PORTC, r16
    rjmp REVISAR_BOTONES  ;

REVISAR_BOTONES:
    ; Leer Botón Carga (PD3 / Pin 3)
    sbis PIND, 3
    rjmp CAMBIAR_CARGA

    ; Leer Botón Inicio (PD2 / Pin 2)
    sbis PIND, 2
    rjmp VALIDAR_SENSORES

    rjmp REPOSO

; CAMBIO DE CARGA 
CAMBIAR_CARGA:
    rcall DELAY_CORTO   
    
    inc r17               ; Incrementar selección
    cpi r17, 3            ; ¿Llegó a 3?
    brne ESPERAR_SOLTAR
    clr r17               ; Reiniciar a 0

ESPERAR_SOLTAR:
    rcall DELAY_CORTO   ; Esperar en cada lectura
    sbis PIND, 3          ; ¿Sigue presionado el botón?
    rjmp ESPERAR_SOLTAR   ; Quedarse aca mientras el botón siga presionado

    rcall DELAY_CORTO   ; Esperar a que el rebote final termine
    rjmp REPOSO

	; 
; VALIDACIÓN DE SENSORES (PUERTA Y AGUA)
VALIDAR_SENSORES:
    rcall DELAY_PEQUENO
    sbic PIND, 4          ; Puerta (PD4 / Pin 4) - Debe estar a GND
    rjmp REPOSO
    sbic PIND, 5          ; Agua (PD5 / Pin 5) - Debe estar a GND
    rjmp REPOSO

    rjmp PROCESO_LAVADO

; ETAPA 1: LAVADO (5 ciclos)

PROCESO_LAVADO:
    ldi r18, 5
BUCLE_LAVADO:
    ; Motor Giro Derecha, LED Lavado (PB1 / Pin 9)
    ldi r16, 0b00000010
    out PORTB, r16
    ldi r19, 2
    add r19, r17
    rcall ESPERAR_SEGUNDOS

    ; Pausa, Apagado
    clr r16
    out PORTB, r16
    ldi r19, 1
    add r19, r17
    rcall ESPERAR_SEGUNDOS

    dec r18
    brne BUCLE_LAVADO

; ETAPA 2: CENTRIFUGADO

PROCESO_CENTRIFUGADO:
    ; LED Centrifugado (PB2 / Pin 10)
    ldi r16, 0b00000100
    out PORTB, r16

    ldi r19, 15
    cpi r17, 1
    breq CENTRIFUGADO_MEDIA
    cpi r17, 2
    breq CENTRIFUGADO_PESADA
    rjmp EJECUTAR_CENTRIFUGADO

CENTRIFUGADO_MEDIA:
    ldi r19, 18
    rjmp EJECUTAR_CENTRIFUGADO

CENTRIFUGADO_PESADA:
    ldi r19, 21

EJECUTAR_CENTRIFUGADO:
    rcall ESPERAR_SEGUNDOS

; ETAPA 3: SECADO
PROCESO_SECADO:
    ; 1. Giro Derecha: LED Secado + LED Lavado (PB3 + PB1)
    ldi r16, 0b00001010
    out PORTB, r16
    ldi r19, 5
    add r19, r17
    add r19, r17
    rcall ESPERAR_SEGUNDOS

    ; 2. Pausa: Solo LED Secado (PB3 / Pin 11)
    ldi r16, 0b00001000
    out PORTB, r16
    ldi r19, 3
    add r19, r17
    add r19, r17
    rcall ESPERAR_SEGUNDOS

    ; 3. Giro Izquierda: LED Secado + LED Fin/Izq (PB3 + PB4)
    ldi r16, 0b00011000
    out PORTB, r16
    ldi r19, 5
    add r19, r17
    add r19, r17
    rcall ESPERAR_SEGUNDOS

;
; FIN DE PROCESO
PROCESO_FIN:
    ; Solo LED Fin del Proceso (PB4 / Pin 12)
    ldi r16, 0b00010000
    out PORTB, r16
    
    ldi r19, 4
    rcall ESPERAR_SEGUNDOS
    rjmp REPOSO
; AQUÍ SE DEFINEN LAS SUBRUTINAS

ESPERAR_SEGUNDOS:
    rcall DELAY_1S
    dec r19
    brne ESPERAR_SEGUNDOS
    ret

DELAY_1S:
    ldi r20, 82
    ldi r21, 43
    ldi r22, 0
L1: dec r22
    brne L1
    dec r21
    brne L1
    dec r20
    brne L1
    ret

DELAY_CORTO:
    ldi r20, 150
    ldi r21, 250
L2: dec r21
    brne L2
    dec r20
    brne L2
    ret