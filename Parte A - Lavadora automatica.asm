; LAVADORA AUTOMATICA - PARTE A
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
    rjmp REVISAR_BOTONES  ;

MOSTRAR_MEDIA:
    ldi r16, 0b00000010   ; PC1 / Pin A1
    out PORTC, r16
    rjmp REVISAR_BOTONES  ; 

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
    rcall DELAY_CORTO   ; Esperar a que se estabilice el rebote inicial
    
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
;Definimos el delay antirrebote
DELAY_CORTO:
    ldi r20, 150
    ldi r21, 250
L2: dec r21
    brne L2
    dec r20
    brne L2
    ret
