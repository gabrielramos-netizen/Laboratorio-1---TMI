.include "m328pdef.inc"

.org 0x0000
    rjmp CONFIGURACION

; INICIALIZACIÓN Y CONFIGURACIÓN DE PUERTOS
CONFIGURACION:
    ; Configurar PORTB como salidas (LEDs de Proceso y Motor)
    ldi r16, 0xFF
    out DDRB, r16
    clr r16
    out PORTB, r16     ; Apagar todos los LEDs de PORTB

    ; Configurar PORTC como salidas (LEDs de Selección de Carga)
    ldi r16, 0x07
    out DDRC, r16
    clr r16
    out PORTC, r16     ; Apagar todos los LEDs de PORTC

    ; Configurar PORTD como entradas
    clr r16
    out DDRD, r16
    ; Activar Pull-ups en PD0, PD1, PD2 y PD3
    ldi r16, 0x0F
    out PORTD, r16

    clr r17           ; Carga por defecto: Ligera (0)

; ESTADO 1: ESPERA Y SELECCIÓN DE CARGA (LISTO)
ESTADO_ESPERA:
    ; LED Listo para lavar (PB0) encendido
    ldi r16, (1<<PB0)
    out PORTB, r16

    ; Actualizar LEDs de Carga en PORTC
    cpi r17, 0
    breq LED_CARGA_LIGERA
    cpi r17, 1
    breq LED_CARGA_MEDIA
    rjmp LED_CARGA_PESADA

LED_CARGA_LIGERA:
    ldi r16, (1<<PC0)
    out PORTC, r16
    rjmp COMPROBAR_BOTONES

LED_CARGA_MEDIA:
    ldi r16, (1<<PC1)
    out PORTC, r16
    rjmp COMPROBAR_BOTONES

LED_CARGA_PESADA:
    ldi r16, (1<<PC2)
    out PORTC, r16

COMPROBAR_BOTONES:
    ; Leer entradas del PORTD
    in r16, PIND

    ; Verificar pulsador de Selección de Carga (PD1 - Activo en Bajo)
    sbrs r16, PD1
    rjmp CAMBIAR_CARGA

    ; Verificar pulsador de Inicio (PD0 - Activo en Bajo)
    sbrs r16, PD0
    rjmp VERIFICAR_SENSORES

    rjmp ESTADO_ESPERA

CAMBIAR_CARGA:
    ; Retardo antirrebote de 1 segundo
    ldi r21, 1
    rjmp DELAY_1SEC_LOOP

ANTIRREBOTE_RET:
    inc r17
    cpi r17, 3
    brne ESTADO_ESPERA
    clr r17           ; Reiniciar a Carga Ligera
    rjmp ESTADO_ESPERA

VERIFICAR_SENSORES:
    ; Verificar si Puerta Cerrada (PD2) y Agua Llena (PD3) están activados (en Alto)
    in r16, PIND
    andi r16, (1<<PD2) | (1<<PD3)
    cpi r16, (1<<PD2) | (1<<PD3)
    breq INICIAR_LAVADO
    rjmp ESTADO_ESPERA  ; No inicia si falta alguna condición

; ESTADO 2: PROCEDIMIENTO DE LAVADO
INICIAR_LAVADO:
    ldi r16, (1<<PB1)  ; LED Proceso Lavado y Motor activo
    out PORTB, r16
    ldi r22, 5         ; Repite el proceso 5 veces

CICLO_LAVADO:
    ; Tiempo de Giro = 2s + ajuste por carga
    mov r21, r17
    subi r21, -2       ; r21 = r17 + 2
    rjmp DELAY_1SEC_LOOP

RET_GIRO_LAVADO:
    ; Pausa = 1s + ajuste por carga 
    mov r21, r17
    subi r21, -1       ; r21 = r17 + 1
    clr r16            ; Apagar motor durante la pausa
    out PORTB, r16
    rjmp DELAY_1SEC_LOOP

RET_PAUSA_LAVADO:
    ldi r16, (1<<PB1)  ; Enciende el motor nuevamente
    out PORTB, r16

    dec r22
    brne CICLO_LAVADO
    rjmp INICIAR_CENTRIFUGADO

; ESTADO 3: PROCEDIMIENTO DE CENTRIFUGADO
INICIAR_CENTRIFUGADO:
    ldi r16, (1<<PB2)  ; LED Proceso Centrifugado
    out PORTB, r16

    ; Tiempo Base = 15s + (r17 * 3s)
    ldi r21, 15
    cpi r17, 0
    breq EXEC_CENTRIFUGADO
    cpi r17, 1
    breq CENT_MEDIO
    subi r21, -6       ; Carga Pesada: +6s
    rjmp EXEC_CENTRIFUGADO

CENT_MEDIO:
    subi r21, -3       ; Carga Media: +3s

EXEC_CENTRIFUGADO:
    rjmp DELAY_1SEC_LOOP

RET_CENTRIFUGADO:
    rjmp INICIAR_SECADO

; ESTADO 4: PROCEDIMIENTO DE SECADO
INICIAR_SECADO:
    ; Giro Derecha (PB3) 
    ldi r16, (1<<PB3)
    out PORTB, r16
    ldi r21, 5
    mov r16, r17
    lsl r16            ; Multiplicar carga por 2
    add r21, r16
    rjmp DELAY_1SEC_LOOP

RET_SEC_DER:
    ; Pausa  
    clr r16
    out PORTB, r16
    ldi r21, 3
    mov r16, r17
    lsl r16
    add r21, r16
    rjmp DELAY_1SEC_LOOP

RET_SEC_PAUSA:
    ; Giro Izquierda (PB4) 
    ldi r16, (1<<PB4)
    out PORTB, r16
    ldi r21, 5
    mov r16, r17
    lsl r16
    add r21, r16
    rjmp DELAY_1SEC_LOOP

RET_SEC_IZQ:
    rjmp FIN_PROCESO

; ESTADO 5: FIN DEL PROCESO
FIN_PROCESO:
    ldi r16, (1<<PB5)  ; LED Fin de proceso
    out PORTB, r16
    
    ; Esperar 5 segundos y regresar al estado de reposo
    ldi r21, 5
    rjmp DELAY_1SEC_LOOP

RET_FIN:
    rjmp ESTADO_ESPERA

; BUCLE DE RETARDO ÚNICO Y RUTINA DE RETORNO 

DELAY_1SEC_LOOP:
    ldi r18, 100
D_L1:
    ldi r19, 200
D_L2:
    ldi r20, 250
D_L3:
    dec r20
    brne D_L3
    dec r19
    brne D_L2
    dec r18
    brne D_L1
    dec r21
    brne DELAY_1SEC_LOOP

; Conmutador de Retorno basado en el Estado de Salida Actual 
DEVOLVER_RETARDO:
    in r16, PORTB
    cpi r16, (1<<PB0)
    breq ANTIRREBOTE_RET
    cpi r16, (1<<PB1)
    breq RET_GIRO_LAVADO
    cpi r16, 0x00
    breq EVALUAR_PAUSA
    cpi r16, (1<<PB2)
    breq RET_CENTRIFUGADO
    cpi r16, (1<<PB3)
    breq RET_SEC_DER
    cpi r16, (1<<PB4)
    breq RET_SEC_IZQ
    cpi r16, (1<<PB5)
    breq RET_FIN
    rjmp ESTADO_ESPERA

EVALUAR_PAUSA:
    cpi r22, 0
    brne RET_PAUSA_LAVADO
    rjmp RET_SEC_PAUSA