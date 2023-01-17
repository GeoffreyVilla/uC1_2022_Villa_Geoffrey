;--------------------------------------------------------------
; @file:	Display.s
; @author:	Geoffrey Villa Vilela
; @date:	15/01/2023
; @ide:		MPLAB X IDE v6.00
; @brief:	Muestra numeros del 0-9 y si se presiona el boton se muestran letras
;		desde la A-F
; @OSC:		Se utilizo un oscilador de 4MHz.
;------------------------------------------------------------------
    
PROCESSOR 18F57Q84

#include "Bit_Config.inc"	//config statements should precede project file includes.
#include <xc.inc>
#include "Retardos.inc"
    
PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
    
PSECT CODE
    
Main:
    CALL	Config_OSC,1	    ;Llamamos la confguracion del oscilador
    CALL	Config_Port,1	    ;Llamamos la configuracion de los puertos
    MOVLW	00000000B	    ;cargamos 0 a W
    MOVWF	TRISD		    ;TRISD = 0 - OUTPUT
    
Num0:
    MOVLW	11000000B	    ;cargamos Segmentos a encender de 0 en W
    MOVWF	PORTD		    ;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	    ;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num1		    ;si no está presionado va al numero 1
    GOTO	Alfa		    ;si está presionado va a la letra A
    
Num1:
    MOVLW	11111001B	    ;cargamos Segmentos a encender de 1 en W
    MOVWF	PORTD		    ;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	    ;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num2		    ;si no está presionado va al numero 2
    GOTO	Alfa		    ;si está presionado va a la letra A
    
Num2:
    MOVLW	10100100B	    ;cargamos Segmentos a encender de 2 en W
    MOVWF	PORTD		    ;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	    ;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num3		    ;si no está presionado va al numero 3
    GOTO	Alfa		    ;si está presionado va a la letra A
    
Num3:
    MOVLW	10110000B	    ;cargamos Segmentos a encender de 3 en W
    MOVWF	PORTD		    ;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	    ;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num4		    ;si no está presionado va al numero 4
    GOTO	Alfa		    ;si está presionado va a la letra A
    
Num4:
    MOVLW	10011001B	    ;cargamos Segmentos a encender de 4 en W
    MOVWF	PORTD		    ;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	    ;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num5		    ;si no está presionado va al numero 5
    GOTO 	Alfa		    ;si está presionado va a la letra A
    
Num5:
    MOVLW	10010010B	    ;cargamos Segmentos a encender de 5 en W
    MOVWF	PORTD		    ;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	    ;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num6		    ;si no está presionado va al numero 6
    GOTO	Alfa		    ;si está presionado va a la letra A

Num6:
    MOVLW	10000010B	    ;cargamos Segmentos a encender de 6 en W
    MOVWF	PORTD		    ;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	    ;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num7		    ;si no está presionado va al numero 7
    GOTO	Alfa		    ;si está presionado va a la letra A
    
Num7:
    MOVLW	11111000B	    ;cargamos Segmentos a encender de 7 en W
    MOVWF	PORTD		    ;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	    ;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num8		    ;si no está presionado va al numero 8
    GOTO	Alfa		    ;si está presionado va a la letra A

Num8:
    MOVLW	10000000B	    ;cargamos Segmentos a encender de 8 en W
    MOVWF	PORTD		    ;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	    ;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num9		    ;si no está presionado va al numero 9
    GOTO	Alfa		    ;si está presionado va a la letra A

Num9:
    MOVLW	10010000B	    ;cargamos Segmentos a encender de 9 en W
    MOVWF	PORTD		    ;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	    ;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num0		    ;si no está presionado va al numero 1
    GOTO	Alfa		    ;si está presionado va a la letra A
    
Alfa:
    MOVLW	00001000B	    ;cargamos Segmentos a encender de A en W
    MOVWF	PORTD		    ;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	    ;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num0		    ;si no está presionado va al numero 0
    GOTO	Alfb		    ;si está presionado va a la letra B
    
    
Alfb:
    MOVLW	00000011B	    ;cargamos Segmentos a encender de b en W
    MOVWF	PORTD		    ;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	    ;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num0		    ;si no está presionado va al numero 0
    GOTO	Alfc		    ;si está presionado va a la letra C


Alfc:
    MOVLW	01000110B	    ;cargamos Segmentos a encender de C en W
    MOVWF	PORTD		    ;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	    ;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num0		    ;si no está presionado va al numero 0
    GOTO	Alfd		    ;si está presionado va a la letra D

    
Alfd:
    MOVLW	00100001B	    ;cargamos Segmentos a encender de d en W
    MOVWF	PORTD		    ;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	    ;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num0		    ;si no está presionado va al numero 0
    GOTO	Alfe		    ;si está presionado va a la letra E

    
Alfe:
    MOVLW	00000110B	    ;cargamos Segmentos a encender de E en W
    MOVWF	PORTD,1		    ;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	    ;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num0		    ;si no está presionado va al numero 0
    GOTO	Alff		    ;si está presionado va a la letra F
 
    
Alff:
    MOVLW	00001110B	    ;cargamos Segmentos a encender de F en W
    MOVWF	PORTD,1		    ;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	    ;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num0		    ;si no está presionado va al numero 0
    GOTO	Alfa		    ;si está presionado va a la letra A


Config_OSC:
    ;configuración del oscilador interno a una frecuencia de 8MHz
    BANKSEL	OSCCON1
    MOVLW	0x60		    ;seleccionamos el bloque del oscilador interno con un div:1
    MOVWF	OSCCON1,1
    MOVLW	0x02		    ;seleccionamos una frecuencia de 8MHz
    MOVWF	OSCFRQ,1 
    RETURN

Config_Port:
    ;config PORTD
    BANKSEL	PORTD
    CLRF	PORTD,1		    ;PORTD = 0 
    BSF		LATD,7,1	    ;LATF = 1
    CLRF	ANSELD,1	    ;ANSELF = 0 -  DIGITAL

    
    ;config Button
    BANKSEL	PORTA
    CLRF	PORTA,1		    ;PORTA> = 0 
    CLRF	ANSELA,1	    ;PORTA digital
    BSF		TRISA,3,1	    ;RA3 como entrada
    BSF		WPUA,3,1	    ;Activamos la resistencia pull-up del pin RA3
    RETURN
    
END resetVect





