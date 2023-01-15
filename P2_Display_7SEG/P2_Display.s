;--------------------------------------------------------------
; @file:	     P2_Display.s
; @author:	Geoffrey Villa Vilela
; @date:	     1408/01/2023
; @ide:		MPLAB X IDE v6.00
; @brief:	     Hace un conteo de 0 - 9 y si se preiona el boton muestra letras desde la A -F.
;------------------------------------------------------------------

PROCESSOR 18F57Q84

#include "Bit_config.inc"	// config statements should precede project file includes.
#include <xc.inc>
#include "Retardos.inc"

PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main
    
PSECT CODE
    
Main:
    CALL	Config_OSC,1
    CALL	Config_Port,1
    MOVLW	00000000B
    MOVWF	TRISD

Num1:
    MOVLW	11111001B	;cargamos Numero 1 en binario a W
    MOVWF	PORTD		;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num2		;si no está presionado va al numero 2
    GOTO	Alfa		;si está presionado va a la letra A
    
Num2:
    MOVLW	10100100B	;cargamos Numero 2 en binario a W
    MOVWF	PORTD		;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num3		;si no está presionado va al numero 3
    GOTO	Alfa		;si está presionado va a la letra A
    
Num3:
    MOVLW	10110000B	;cargamos Numero 3 en binario a W
    MOVWF	PORTD		;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num4		;si no está presionado va al numero 4
    GOTO	Alfa		;si está presionado va a la letra A
    
Num4:
    MOVLW	10011001B	;cargamos Numero 4 en binario a W
    MOVWF	PORTD		;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num5		;si no está presionado va al numero 5
    GOTO 	Alfa		;si está presionado va a la letra A
    
Num5:
    MOVLW	10010010B	;cargamos Numero 5 en binario a W
    MOVWF	PORTD		;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num6		;si no está presionado va al numero 6
    GOTO	Alfa		;si está presionado va a la letra A

Num6:
    MOVLW	10000010B	;cargamos Numero 6 en binario a W
    MOVWF	PORTD		;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num7		;si no está presionado va al numero 7
    GOTO	Alfa		;si está presionado va a la letra A
    
Num7:
    MOVLW	11111000B	;cargamos Numero 7 en binario a W
    MOVWF	PORTD		;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num8		;si no está presionado va al numero 8
    GOTO	Alfa		;si está presionado va a la letra A

Num8:
    MOVLW	10000000B	;cargamos Numero 8 en binario a W
    MOVWF	PORTD		;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num9		;si no está presionado va al numero 9
    GOTO	Alfa		;si está presionado va a la letra A

Num9:
    MOVLW	10010000B	;cargamos Numero 9 en binario a W
    MOVWF	PORTD		;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num1		;si no está presionado va al numero 1
    GOTO	Alfa		;si está presionado va a la letra A
    
Alfa:
    MOVLW	00001000B	;cargamos letra A en binario a W
    MOVWF	PORTD		;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num1		;si no está presionado va al numero 1
    GOTO	Alfb		;si está presionado va a la letra B
    
    
Alfb:
    MOVLW	00000011B	;cargamos letra B en binario a W
    MOVWF	PORTD		;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num1		;si no está presionado va al numero 1
    GOTO	Alfc		;si está presionado va a la letra C


Alfc:
    MOVLW	01000110B	;cargamos letra C en binario a W
    MOVWF	PORTD		;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num1		;si no está presionado va al numero 1
    GOTO	Alfd		;si está presionado va a la letra D

    
Alfd:
    MOVLW	00100001B	;cargamos letra D en binario a W
    MOVWF	PORTD		;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num1		;si no está presionado va al numero 1
    GOTO	Alfe		;si está presionado va a la letra E

    
Alfe:
    MOVLW	00000110B	;cargamos letra E en binario a W
    MOVWF	PORTD,1		;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num1		;si no está presionado va al numero 1
    GOTO	Alff		;si está presionado va a la letra F
 
    
Alff:
    BANKSEL	PORTD
    SETF	LATD,1
    MOVLW	00001110B	;cargamos letra F en binario a W
    MOVWF	PORTD,1		;movemos el W al puerto D
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    CALL	Delay_250ms
    BTFSC	PORTA,3,0	;PORTA <3> = 0  -  BUTTON PRESS
    GOTO	Num1		;si no está presionado va al numero 1
    GOTO	Alfa		;si está presionado va a la letra A


Config_OSC:
    ;configuración del oscilador interno a una frecuencia de 8MHz
    BANKSEL	OSCCON1
    MOVLW	0x60		;seleccionamos el bloque del oscilador interno con un div:1
    MOVWF	OSCCON1,1
    MOVLW	0x02		;seleccionamos una frecuencia de 8MHz
    MOVWF	OSCFRQ,1 
    RETURN

Config_Port:
    ;config PORTD
    BANKSEL	PORTD
    CLRF	PORTD,1		;PORTD = 0 
    BSF		LATD,7,1	;LATF = 1
    CLRF	ANSELD,1	;ANSELF = 0 -  DIGITAL

    
    ;config Button
    BANKSEL PORTA
    CLRF    PORTA,1		;PORTA> = 0 
    CLRF    ANSELA,1		;PORTA digital
    BSF	    TRISA,3,1		;RA3 como entrada
    BSF	    WPUA,3,1		;Activamos la resistencia pull-up del pin RA3
    RETURN
    
END resetVect




