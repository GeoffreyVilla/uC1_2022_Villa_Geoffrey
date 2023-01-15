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
    CALL    Config_OSC,1
    CALL    Config_Port,1

Apagao:
    CLRF    LATC	    ;LATC<7:0> = 0  - Leds apagados
    CLRF    LATE	    ;LATE<7:0> = 0  - Leds apagados
    BTFSC   PORTA,3,0	    ;PORTA<3> = 0? - BUTTON PRESS?
    GOTO    Apagao	    ;Loop
    GOTO    Corrimiento   
    
Loop:
    BTFSC   PORTA,3,0	    ;PORTA<3> = 0? - Button press?
    RETURN
    call    Delay_100ms
    goto    stop
    
stop:
    BTFSC   PORTA,3,0	    ;PORTA<3> = 0? - Button press?
    goto    stop	    ;Loop
    RETURN
    
Corrimiento:
  
    N1:
    MOVLW   00000001B	    ; w = 00000001
    MOVWF   LATC	    ; LED ON
    MOVLW   00000001B	    ; w = 00000001
    MOVWF   LATE,1	    ; LED ON	
    Call    Loop
    CALL    Delay_250ms1,1
   
    N2:
    Call    Loop
    MOVLW   00000010B	    ; w = 00000010
    MOVWF   LATC	    ; LED ON   
    MOVLW   00000010B	    ; w = 00000010
    MOVWF   LATE,1	    ; LED ON
    Call    Loop
    CALL    Delay_250ms,1
    Call    Loop
    CALL    Delay_250ms,1
    
    N3:
    Call    Loop
    MOVLW   00000100B	    ; w = 00000100
    MOVWF   LATC	    ; LED ON
    MOVLW   00000001B	    ; w = 00000001
    MOVWF   LATE,1	    ; LED ON
    Call    Loop
    CALL    Delay_250ms,1
    
    N4:
    Call    Loop
    MOVLW   00001000B	    ; w = 00001000
    MOVWF   LATC	    ; LED ON
    MOVLW   00000010B	    ; w = 00000010
    MOVWF   LATE,1	    ; LED ON
    Call    Loop
    CALL    Delay_250ms,1
    Call    Loop
    CALL   Delay_250ms,1
    
    N5:
    Call    Loop
    MOVLW   00010000B	    ; w = 00010000
    MOVWF   LATC	    ; LED ON
    MOVLW   00000001B	    ; w = 00000001
    MOVWF   LATE,1	    ; LED ON
    Call    Loop
    CALL    Delay_250ms,1
    
    N6:
    Call    Loop
    MOVLW   00100000B	    ; w = 00100000
    MOVWF   LATC	    ; LED ON
    MOVLW   00000010B	    ; w = 00000010
    MOVWF   LATE,1	    ; LED ON
    Call    Loop
    CALL    Delay_250ms,1
    Call    Loop
    CALL    Delay_250ms,1
    N7:
    Call    Loop
    MOVLW   01000000B	    ; w = 01000000
    MOVWF   LATC	    ; LED ON
    MOVLW   00000001B	    ; w = 00000001
    MOVWF   LATE,1	    ; LED ON
    Call    Loop
    CALL    Delay_250ms,1
    
    N8:
    Call    Loop
    MOVLW   10000000B	    ; w = 10000000
    MOVWF   LATC	    ; LED ON
    MOVLW   00000010B	    ; w = 00000010
    MOVWF   LATE,1	    ; LED ON
    Call    Loop
    CALL    Delay_250ms,1
    Call    Loop
    CALL    Delay_250ms,1
    Call    Loop
    goto    N1
    

Config_OSC:
    ;Configuracion del oscilador interno a una frecuencia de 4MHz
    BANKSEL OSCCON1 
    MOVLW   0x60		;Seleccionamos el bloque del osc con un div:1
    MOVWF   OSCCON1
    MOVLW   0x02		; Seleccionamos una frecuencia de 4MHz
    MOVWF   OSCFRQ 
    RETURN
   
Config_Port:  ;PORT-LAT-ANSEL-TRIS	    LED:RF3	BUTTON:RA3
    ;Config Led
    BANKSEL PORTC
    CLRF    PORTC,1		; PORTC = 0 
    CLRF    ANSELC,1		; ANSELC = 0 - DIGITAL
    CLRF    TRISC		; TRISC = 0 - OUTPUT
    
    ;Config Led
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
    

Delay_250ms:			    ;2Tcy -- Call
    MOVLW   100			    ;1Tcy
    MOVWF   contador2,0		    ;1Tcy
 

Ext_Loop_250ms:
    MOVLW   245			    ;n*TcyTcy
    MOVWF   contador1,0		    ;n*Tcy
    
Int_Loop_250ms:
    NOP				    ;k*Tcy
    DECFSZ  contador1,1,0	    ;((k-1) + 3)*n*Tcy
    GOTO    Int_Loop_250ms	    ;(k-1)*2*n*Tcy
    NOP				    ;n*Tcy
    NOP				    ;n*Tcy
    NOP				    ;n*Tcy
    DECFSZ  contador2,1,0	    ;(n-1) + 3Tcy
    GOTO    Ext_Loop_250ms	    ;(n-1)*2Tcy
    RETURN
    
Delay_250ms1:			    ;2Tcy -- Call
    MOVLW   250			    ;1Tcy
    MOVWF   contador2,0		    ;1Tcy
 

Ext_Loop_250ms1:
    MOVLW   247			    ;n*TcyTcy
    MOVWF   contador1,0		    ;n*Tcy
    
Int_Loop_250ms1:
    NOP				    ;k*Tcy
    DECFSZ  contador1,1,0	    ;((k-1) + 3)*n*Tcy
    GOTO    Int_Loop_250ms1	    ;(k-1)*2*n*Tcy
    NOP				    ;n*Tcy
    NOP				    ;n*Tcy
    NOP				    ;n*Tcy
    DECFSZ  contador2,1,0	    ;(n-1) + 3Tcy
    GOTO    Ext_Loop_250ms1	    ;(n-1)*2Tcy
    RETURN		

    
Delay_100ms:			    ;2Tcy -- Call
    MOVLW   100			    ;1Tcy
    MOVWF   contador2,0		    ;1Tcy

Ext_Loop_100ms:
    MOVLW   248			    ;n*Tcy
    MOVWF   contador1,0		    ;n*Tcy
    NOP				    ;n*Tcy
Int_Loop_100ms:
    NOP				    ;k*n*Tcy
    DECFSZ  contador1,1,0	    ;((k-1) + 3)*n*Tcy
    GOTO    Int_Loop_100ms	    ;(k-1)* 2*n*Tcy
    NOP				    ;n*Tcy 
    NOP				    ;n*Tcy
    DECFSZ  contador2,1,0	    ;(n-1) + 3Tcy
    GOTO    Ext_Loop_100ms	    ;(n-1) *2Tcy
    RETURN			    ;2Tcy
    
END resetVect





