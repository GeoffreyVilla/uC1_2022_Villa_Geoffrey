;--------------------------------------------------------------
; @file:	CorrLeds.s
; @author:	Geoffrey Villa Vilela
; @date:	15/01/2023
; @ide:		MPLAB X IDE v6.00
; @brief:	Corrimiento de led en el PORTC con estado de led par e impar
; @OSC:		Se utilizo un oscilador de 4MHz.
;------------------------------------------------------------------
    
PROCESSOR 18F57Q84
    
#include "BitConfig.inc"	//config statements should precede project file includes
#include <xc.inc>
#include "Retardos.inc"
     
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main 
    
PSECT CODE 
    
Main:
    CALL    Config_OSC,1	;Llamamos la configuracion del oscilador
    CALL    Config_Port,1	;Llamamos la configuracion del puerto

Apagao:
    CLRF    LATC		;LATC = 0  - Leds apagados
    CLRF    LATE		;LATE = 0  - Leds apagados
    BTFSC   PORTA,3,0		;PORTA <3> = 0? - BUTTON PRESS?
    GOTO    Apagao		;si no está presionado va a la rutina Apagado
    GOTO    Corrimiento		;si está presionado va a la rutina Corrimiento
    
Loop:
    BTFSC   PORTA,3,0		;PORTA<3> = 0? - Button press?
    RETURN			;si no está presionado retorna
    CALL    Delay_100ms		;si está presionado hace un delay
    GOTO    stop
    
stop:
    BTFSC   PORTA,3,0		;PORTA<3> = 0? - Button press?
    GOTO    stop		;si no se presiona va al stop generandod un Loop
    RETURN			;si se presiona, retorna al corrimiento
    
Corrimiento:
    N1:
    MOVLW   00000001B		;Cargamos el numero a W
    MOVWF   LATC		;Movemos al LATC para encender el primer led
    MOVLW   00000001B		;Cargamos el numero al W
    MOVWF   LATE,1		;Movemos al LATE para encender el led indicador de corrimiento
    CALL    Loop		;Llamamos al Loop para ver el estado del boton
    CALL    Delay_250ms,1
   
    N2:
    CALL    Loop
    MOVLW   00000010B		;Cargamos el numero a W
    MOVWF   LATC		;Movemos al LATC para encender el segundo led
    MOVLW   00000010B		;Cargamos el numero a W
    MOVWF   LATE,1		;Movemos al LATE para encender el led indicador de corrimiento
    CALL    Loop		;Llamamos al Loop para ver el estado del boton
    CALL    Delay_250ms,1
    CALL    Loop
    CALL    Delay_250ms,1
    
    N3:
    CALL    Loop		;Llamamos al Loop para ver el estado del boton
    MOVLW   00000100B		;Cargamos el numero a W
    MOVWF   LATC		;Movemos al LATC para encender el tercer led
    MOVLW   00000001B		;Cargamos el numero a W
    MOVWF   LATE,1		;Movemos al LATE para encender el led indicador de corrimiento
    CALL    Loop		;Llamamos al Loop para ver el estado del boton
    CALL    Delay_250ms,1
    
    N4:
    CALL    Loop		;Llamamos al Loop para ver el estado del boton
    MOVLW   00001000B		;Cargamos el numero a W
    MOVWF   LATC		;Movemos al LATC para encender el cuarto led
    MOVLW   00000010B		;Cargamos el numero a W
    MOVWF   LATE,1		;Movemos al LATE para encender el led indicador de corrimiento
    CALL    Loop		;Llamamos al Loop para ver el estado del boton
    CALL    Delay_250ms,1
    CALL    Loop
    CALL    Delay_250ms,1
    
    N5:
    CALL    Loop		;Llamamos al Loop para ver el estado del boton
    MOVLW   00010000B		;Cargamos el numero a W
    MOVWF   LATC		;Movemos al LATC para encender el quinto led
    MOVLW   00000001B		;Cargamos el numero a W
    MOVWF   LATE,1		;Movemos al LATE para encender el led indicador de corrimiento
    CALL    Loop		;Llamamos al Loop para ver el estado del boton
    CALL    Delay_250ms,1
    
    N6:
    CALL    Loop		;Llamamos al Loop para ver el estado del boton
    MOVLW   00100000B		;Cargamos el numero a W
    MOVWF   LATC		;Movemos al LATC para encender el sexto led
    MOVLW   00000010B		;Cargamos el numero a W
    MOVWF   LATE,1		;Movemos al LATE para encender el led indicador de corrimiento
    CALL    Loop		;Llamamos al Loop para ver el estado del boton
    CALL    Delay_250ms,1
    CALL    Loop
    CALL    Delay_250ms,1
    
    N7:
    CALL    Loop		;Llamamos al Loop para ver el estado del boton
    MOVLW   01000000B		;Cargamos el numero a W
    MOVWF   LATC		;Movemos al LATC para encender el setimo led
    MOVLW   00000001B		;Cargamos el numero a W
    MOVWF   LATE,1		;Movemos al LATE para encender el led indicador de corrimiento
    CALL    Loop		;Llamamos al Loop para ver el estado del boton
    CALL    Delay_250ms,1
    
    N8:
    CALL    Loop		;Llamamos al Loop para ver el estado del boton
    MOVLW   10000000B		;Cargamos el numero a W
    MOVWF   LATC		;Movemos al LATC para encender el octavo led
    MOVLW   00000010B		;Cargamos el numero a W
    MOVWF   LATE,1		;Movemos al LATE para encender el led indicador de corrimiento
    CALL    Loop		;Llamamos al Loop para ver el estado del boton
    CALL    Delay_250ms,1
    CALL    Loop
    CALL    Delay_250ms,1
    CALL    Loop
    GOTO    N1
    

Config_OSC:
    ;Configuracion del oscilador interno a una frecuencia de 4MHz
    BANKSEL OSCCON1 
    MOVLW   0x60		;Seleccionamos el bloque del osc con un div:1
    MOVWF   OSCCON1
    MOVLW   0x02		; Seleccionamos una frecuencia de 4MHz
    MOVWF   OSCFRQ 
    RETURN
   
Config_Port:
    ;Config PortC
    BANKSEL PORTC
    CLRF    PORTC,1		; PORTC = 0 
    CLRF    ANSELC,1		; ANSELC = 0 - DIGITAL
    CLRF    TRISC		; TRISC = 0 - OUTPUT
    
    ;Config PortE
    BANKSEL PORTE
    CLRF    PORTE,1		; PORTE = 0 
    CLRF    ANSELE,1		; ANSELE = 0 - DIGITAL
    CLRF    TRISE		; TRISE = 0 - OUTPUT
    
    ;Config Button
    BANKSEL PORTA
    CLRF    PORTA,1		; PORTA = 0
    CLRF    ANSELA,1		; PortA digital
    BSF	    TRISA,3,1		; RA3 como entrada
    BSF	    WPUA,3,1		; Activamos la resistencia Pull-Up del pin RA3
    RETURN
    
END resetVect







