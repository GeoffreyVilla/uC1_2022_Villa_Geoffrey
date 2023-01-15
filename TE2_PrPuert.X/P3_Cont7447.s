PROCESSOR 18F57Q84
#include "Bit_config.inc"  /config statements should precede project file includes./
#include <xc.inc>
     
PSECT udata_acs
 contador1: DS 1
 contador2: DS 1
 contador3: DS 1


PSECT resetVect,class=CODE,reloc=2
resetVect:
    goto Main 
    
PSECT CODE 
    
Main:
    CALL Config_OSC,1
    CALL Config_Port,1
    MOVLW 00000000B
    MOVWF TRISB
    MOVLW 10011001B
    MOVWF 0X508
    
Loop:
    CALL    Delay_1s
    BTFSC   PORTA,3,0		;PORTA<3> = 0? - Button press?
    GOTO    N0			;va al cero si el botón no está presionado
    GOTO    N99			;Si el botón está presionado va al 99
    
;0-9
N0:
    MOVLW   0x00
    MOVWF   PORTB		;ponemos 0 en PORTB
    movwf   0x504		;guardamos el cero en 0x504
    CALL    Delay_1s,0
    GOTO    button		;va al botón
    
N99:
    MOVLW   0x99		;ponemos 99 en PORTB
    MOVWF   PORTB
    movwf   0x504		;guardamos el 99 en 0x504
    CALL    Delay_1s,0
    GOTO    button
    
button:
    BTFSC   PORTA,3,0	    ;PORTA<3> = 0? - Button press?
    goto    ANAL_SUMA	    ;si no está presionado el botón suma
    goto    ANAL_RESTA	    ;si está presionado el botón resta
    
SUMA:
    MOVLW   0001B
    ADDWF   0x504,0,0	    ;suma 1 al número
    BANKSEL PORTB
    MOVWF   PORTB,1	    ;sube el resultado al PORTB
    movwf   0x504	    ; el nuevo número es guardado en el registro 0x504
    CALL    Delay_1s,0
    GOTO    button
    
SUMA2:
    MOVLW   0x07	    ;9+7 sale 10 en suma hexadecima
    ADDWF   0x504,0,0	    ;suma al número anterior
    MOVWF   PORTB	    ;sube el resultado al PORTB
    MOVWF   0x504	    ;el nuevo número es guardado en 0x504
    CALL    Delay_1s,0
    GOTO    button  
    
ANAL_SUMA:
    movf    0x504,0	    ;sube el número al w
    CPFSEQ  0x508	    ;compara con 99
    goto    next	    ;si no es 99 va al siguiente análisis
    goto    button
    
next:    
    BTFSC   0X504,3
    btfss   0X504,0	    ;compara si no es 9
    goto    SUMA	    ;si no es 9 suma normal
    goto    SUMA2	    ;si es 9 hay una suma distinta
    
RESTA:
    MOVLW   0001B	    ;resta 1 al valor
    SUBWF   0x504,0,0	    ;resta el valor de f con w 
    MOVWF   PORTB	    ;carga el valor al portb
    MOVWF   0x504	    ;pone el resultado en 0x504
    CALL    Delay_1s,0
    GOTO    button
    
RESTA2:
    MOVLW   0x07	    ;resta 7 al valor
    SUBWF   0x504,0,0	    ;resta el valor de f con w 
    MOVWF   PORTB	    ;carga el valor al portb
    MOVWF   0x504	    ;pone el resultado en 0x504
    CALL    Delay_1s,0
    GOTO    button
    
ANALISIS_RESTA:
    movf    0x504,0	    ;sube el valor de 504 al w
    MOVWF   0X510	    ;carga el número a registro 0x510
    TSTFSZ 0X510	    ;salta si el resultado es 0
    GOTO    next2
    goto    button
    
next2:    
    BTFSS   0X504,3	    ;salta si el valor es 1
    BTFSC   0X504,0	    ;salta si el valor es 0
    goto    RESTA
    goto    ANAL_RESTA2
    
ANAL_RESTA2:
    BTFSS   0X504,2	    ;salta si el valor es 1
    BTFSC   0X504,1	    ;salta si el valor es 0
    goto    RESTA
    goto    RESTA2
    
    
    
 Config_OSC:
    ;Configuracion del oscilador interno a una frecuencia de 4MHz
    BANKSEL OSCCON1 
    MOVLW   0x60        ;Seleccionamos el bloque del osc con un div:1
    MOVWF   OSCCON1
    MOVLW   0x02        ; Seleccionamos una frecuencia de 4MHz
    MOVWF   OSCFRQ 
    RETURN
   
 Config_Port:  ;PORT-LAT-ANSEL-TRIS	    LED:RF3	BUTTON:RA3
    ;Config Led
    BANKSEL PORTB
    CLRF    PORTB,1	; PORTF = 0 
    CLRF    ANSELB,1	; ANSELF<7:0> = 0 -PORT F DIGITAL

    ;Config Button
    BANKSEL PORTA
    CLRF    PORTA,1	; PORTA<7:0> = 0
    CLRF    ANSELA,1	; PortA digital
    BSF	    TRISA,3,1	; RA3 como entrada
    BSF	    WPUA,3,1	; Activamos la resistencia Pull-Up del pin RA3
    RETURN 
    
Delay_1s:
    Call Delay_250ms
    Call Delay_250ms
    Call Delay_250ms
    Call Delay_250ms
    Return
Delay_250ms:		    ;2Tcy -- Call
    MOVLW   250		    ;1Tcy
    MOVWF   contador2,0	    ;1Tcy
 

Ext_Loop_250ms:
    MOVLW   248		    ;n*TcyTcy
    MOVWF   contador1,0	    ;n*Tcy
    
Int_Loop_250ms:
    NOP				    ;k*Tcy
    DECFSZ  contador1,1,0	    ;((k-1) + 3)*n*Tcy
    GOTO    Int_Loop_250ms	    ;(k-1)*2*n*Tcy
    NOP				    ;n*Tcy
    NOP				    ;n*Tcy
    NOP				    ;n*Tcy
    DECFSZ  contador2,1,0	    ;(n-1) + 3Tcy
    GOTO    Ext_Loop_250ms	    ;(n-1)*2Tcy
    RETURN			    ;2Tcy
     
END resetVect