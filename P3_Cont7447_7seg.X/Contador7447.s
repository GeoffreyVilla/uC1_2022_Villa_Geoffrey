;--------------------------------------------------------------
; @file:	Contador7447.s
; @author:	Geoffrey Villa Vilela
; @date:	15/01/2023
; @ide:		MPLAB X IDE v6.00
; @brief:	Muestra numeros de 0-99 y si se presiona el boton se muestra
;		numeros descresientes hasta 0
; @OSC:		Se utilizo un oscilador de 4MHz.
;------------------------------------------------------------------
    
PROCESSOR 18F57Q84
    
#include "Bit_Config.inc"  //config statements should precede project file includes.
#include <xc.inc>
#include "Retardos.inc"

PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main 
    
PSECT CODE 
    
Main:
    CALL	Config_OSC,1
    CALL	Config_Port,1
    MOVLW	00000000B	    ;cargamos 0 a W
    MOVWF	TRISB		    ;movemos el 0 as TRISB par definir como OUTPUT
    MOVLW	10011001B	    ;cargamo 99 hexa a W
    MOVWF	0x508		    ;guardamos el 99 en 0x508

;Rutina que analiza si el programa inicia con el boton preionado    
Loop:
    CALL	Delay_1s
    BTFSC	PORTA,3,0	    ;PORTA<3> = 0? - Button press?
    GOTO	N0		    ;si no está presionado va a N0
    GOTO	N99		    ;Si está presionado va al N99
    
;si el programa inicia con el boton sin presionar
N0:
    MOVLW	0x00		    ;cargamos 0 a W
    MOVWF	PORTB		    ;ponemos 0 en PORTB
    MOVWF	0x504		    ;guardamos el cero en 0x504
    CALL	Delay_1s,0
    GOTO	button

;si el programa inicia con el boton presionado
N99:
    MOVLW	0x99		    ;cargamos 99 a W
    MOVWF	PORTB		    ;ponemos 99 en PORTB
    MOVWF	0x504		    ;guardamos el 99 en 0x504
    CALL	Delay_1s,0
    GOTO	button

;verifica si el estado del boton   
button:
    BTFSC	PORTA,3,0	    ;PORTA<3> = 0? - Button press?
    GOTO	ANAL_SUMA	    ;si no está presionado va al Anal_suma
    GOTO	ANAL_RESTA	    ;si está presionado val al Anal_resta

    
ANAL_SUMA:
    MOVF	0x504,0		    ;sube el número guardado a W
    CPFSEQ	0x508		    ;compara con 99
    GOTO	next		    ;si no es 99 va al siguiente análisis
    GOTO	button		    ;si es 99 va al botton
    
next:    
    BTFSC	0x504,3		    ;compara el bit3 del registro
    BTFSS	0x504,0		    ;compara el bit0 del registro
    GOTO	SUMA		    ;si no es 9, suma normal
    GOTO	SUMA2		    ;si es 9, hay una suma distinta
    
SUMA:
    MOVLW	0001B		    ;cargamos 1 a W
    ADDWF	0x504,0,0	    ;suma 1 al número del registro
    MOVWF	PORTB,1		    ;sube el resultado al PORTB
    MOVWF	0x504		    ;el nuevo número es guardado en el registro
    CALL	Delay_1s,0
    GOTO	button		    ;regresa al boton para verificar el estado del boton
    
SUMA2:
    MOVLW	0x07		    ;9+7 sale 10 en suma hexadecima
    ADDWF	0x504,0,0	    ;suma al número anterior
    MOVWF	PORTB		    ;sube el resultado al PORTB
    MOVWF	0x504		    ;el nuevo número es guardado en 0x504
    CALL	Delay_1s,0
    GOTO	button		    ;regresa al boton para verificar el estado del boton

ANAL_RESTA:
    MOVF	0x504,0		    ;sube el valor del registro a w
    MOVWF	0x510		    ;carga el número a registro 0x510
    TSTFSZ	0x510		    ;salta si el resultado es 0
    GOTO	next2
    GOTO	button		    ;regresa al boton para verificar el estado del boton
    
next2:    
    BTFSS	0x504,3		    ;compara el bit3 del registro
    BTFSC	0x504,0		    ;compara el bit0 del registro
    GOTO	RESTA		    ;si no es 9 hace una suma normal
    GOTO	ANAL_RESTA2	    ;si es 9 hace un analisis más
    
ANAL_RESTA2:
    BTFSS	0x504,2		    ;compara el bit2 del registro
    BTFSC	0x504,1		    ;compara el bit1 del registro
    GOTO	RESTA		    ;si no es 9 hace una suma normal
    GOTO	RESTA2		    ;si es 9 hace una resta diferente
    
RESTA:
    MOVLW	0001B		    ;resta 1 al valor
    SUBWF	0x504,0,0	    ;resta el valor de f con w 
    MOVWF	PORTB		    ;carga el valor al portb
    MOVWF	0x504		    ;guarda el resultado en 0x504
    CALL	Delay_1s,0
    GOTO	button		    ;regresa al boton para verificar el estado del boton
    
RESTA2:
    MOVLW	0x07		    ;resta 7 al valor -> 20-7=19
    SUBWF	0x504,0,0	    ;resta el valor de f con w 
    MOVWF	PORTB		    ;carga el valor al portb
    MOVWF	0x504		    ;pone el resultado en 0x504
    CALL	Delay_1s,0
    GOTO	button		    ;regresa al boton para verificar el estado del boton
    

    
    
Config_OSC:
    ;Configuracion del oscilador interno a una frecuencia de 4MHz
    BANKSEL	OSCCON1 
    MOVLW	0x60		    ;Seleccionamos el bloque del osc con un div:1
    MOVWF	OSCCON1
    MOVLW	0x02		    ;Seleccionamos una frecuencia de 4MHz
    MOVWF	OSCFRQ 
    RETURN
   
Config_Port:
    ;Config Led
    BANKSEL	PORTB
    CLRF	PORTB,1		    ;PORTF = 0 
    CLRF	ANSELB,1	    ;ANSELF<7:0> = 0 -PORT F DIGITAL

    ;Config Button
    BANKSEL	PORTA
    CLRF	PORTA,1		    ;PORTA<7:0> = 0
    CLRF	ANSELA,1	    ;PortA digital
    BSF		TRISA,3,1	    ;RA3 como entrada
    BSF		WPUA,3,1	    ;Activamos la resistencia Pull-Up del pin RA3
    RETURN 
    
Delay_1s:
    CALL    Delay_250ms
    CALL    Delay_250ms
    CALL    Delay_250ms
    CALL    Delay_250ms
    RETURN
    
END resetVect


