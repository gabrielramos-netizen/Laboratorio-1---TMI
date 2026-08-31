
.include "m328pdef.inc"

.org 0x0000
    rjmp CONFIGURACION

; INICIALIZACIÓN Y CONFIGURACIÓN DE PUERTOS
CONFIGURACION:
    ; Configurar PORTB como salidas
    ldi r16, 0xFF
    out DDRB, r16
    clr r16
    out PORTB, r16     

    ; ERROR SINTÁCTICO 1: Intento de cargar un valor con 'ldi' en un registro no válido (< r16)
    ldi r10, 0x07
    out DDRC, r10
    clr r16
    out PORTC, r16     

    ; Configurar PORTD como entradas
    clr r16
    out DDRD, r16
    ldi r16, 0x0F
    out PORTD, r16

    clr r17           

; ESTADO 1: ESPERA Y SELECCIÓN DE CARGA (LISTO)
ESTADO_ESPERA:
    ldi r16, (1<<PB0)
    out PORTB, r16

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
    in r16, PIND

    sbrs r16, PD1
    rjmp CAMBIAR_CARGA

    sbrs r16, PD0
    rjmp VERIFICAR_SENSORES

    rjmp ESTADO_ESPERA

CAMBIAR_CARGA:
    ldi r21, 1
    rjmp DELAY_1SEC_LOOP

ANTIRREBOTE_RET:
    inc r17
    cpi r17, 3
    brne ESTADO_ESPERA
    clr r17
    rjmp ESTADO_ESPERA

VERIFICAR_SENSORES:
    in r16, PIND
    andi r16, (1<<PD2)
    cpi r16, (1<<PD2) | (1<<PD3)
    breq INICIAR_LAVADO
    rjmp ESTADO_ESPERA  

; ESTADO 2: PROCEDIMIENTO DE LAVADO
INICIAR_LAVADO:
    ldi r16, (1<<PB1)  
    out PORTB, r16
    ldi r22, 5         

CICLO_LAVADO:
    mov r21, r17
    subi r21, -2       
    rjmp DELAY_1SEC_LOOP

RET_GIRO_LAVADO:
    mov r21, r17
    subi r21, -1       
    clr r16            
    out PORTB, r16
    rjmp DELAY_1SEC_LOOP

RET_PAUSA_LAVADO:
    ldi r16, (1<<PB1)  
    out PORTB, r16
    dec r22
    brne CICLO_LAVADO_INCORRECTO
    rjmp INICIAR_CENTRIFUGADO

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
    brne DELAY_1SEC_LOOP

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