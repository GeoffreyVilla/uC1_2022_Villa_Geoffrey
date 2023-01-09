;--------------------------------------------------------------
; @file:	Retardos.inc
; @author:	Geoffrey Villa Vilela
; @date:	08/01/2023
; @ide:		MPLAB X IDE v6.00
; @brief:	Libreria de Delays con diferentes tiempos desde 10us hasta 250ms.
; @OSC:		Se utilizo un oscilador de 4MHz para obtener los retardos pedidos.
;------------------------------------------------------------------

PSECT udata_acs
contador1: DS	1		;reserva un bit en acces ram
contador2: DS	1		;reserva un bit en acces ram
    
PSECT CODE

    
;----------10us---------	T = 6+4k
Delay_10us:			;2Tcy -- Call
    MOVLW   1			;1Tcy
    MOVWF   contador1,0		;1Tcy

Delay_Loop_10us:
    NOP				;k*Tcy
    DECFSZ  contador1,1,0	;(k-1) + 3Tcy
    GOTO    Delay_Loop_10us	;(k-1) + 2Tcy
    RETURN			;2Tcy

    
;----------25us---------	T = 7+3k
Delay_25us:			;2Tcy -- Call
    MOVLW   6			;1Tcy
    MOVWF   contador1,0		;1Tcy
    NOP				;1Tcy

Delay_Loop_25us:		
    DECFSZ  contador1,1,0	;(k-1) + 3Tcy
    GOTO    Delay_Loop_25us	;(k-1) + 2Tcy
    RETURN			;2Tcy

    
;----------50us---------	T = 6+4k
Delay_50us:			;2Tcy -- Call
    MOVLW   11			;1Tcy
    MOVWF   contador1,0		;1Tcy

Delay_Loop_50us:
    NOP				;k*Tcy
    DECFSZ  contador1,1,0	;(k-1) + 3Tcy
    GOTO    Delay_Loop_50us	;(k-1)*2Tcy
    RETURN			;2Tcy

    
;----------100us---------	T = 8+4k
Delay_100us:			;2Tcy -- Call
    MOVLW   23		    	;1Tcy
    MOVWF   contador1,0		;1Tcy
    NOP				;1Tcy
    NOP				;1Tcy

Delay_Loop_100us:
    NOP				;k*Tcy
    DECFSZ  contador1,1,0	;(k-1) + 3Tcy
    GOTO    Delay_Loop_100us	;(k-1)*2Tcy
    RETURN			;2Tcy

    
;----------200us---------	T = 8+3k
Delay_200us:			;2Tcy -- Call
    MOVLW   64			;1Tcy
    MOVWF   contador1,0		;1Tcy
    NOP				;1Tcy
    NOP				;1Tcy

Delay_Loop_200us:
    DECFSZ  contador1,1,0	;(k-1) + 3Tcy
    GOTO    Delay_Loop_200us	;(k-1)*2Tcy
    RETURN			;2Tcy

    
;----------250us---------	T = 6+4k
Delay_250us:			;2Tcy -- Call
    MOVLW   61			;1Tcy
    MOVWF   contador1,0		;1Tcy

Delay_Loop_250us:
    NOP				;k*Tcy
    DECFSZ  contador1,1,0	;(k-1) + 3Tcy
    GOTO    Delay_Loop_250us	;(k-1)*2Tcy
    RETURN			;2Tcy

    
;----------500us---------	T = 8+4k
Delay_500us:			;2Tcy -- Call
    MOVLW   123			;1Tcy
    MOVWF   contador1,0		;1Tcy
    NOP				;1Tcy
    NOP				;1Tcy

Delay_Loop_500us:
    NOP				;k*Tcy
    DECFSZ  contador1,1,0	;(k-1) + 3Tcy
    GOTO    Delay_Loop_500us	;(k-1)*2Tcy
    RETURN			;2Tcy

    
    
;----------1ms---------		T = 8+4k
Delay_1ms:			;2Tcy -- Call
    MOVLW   248			;1Tcy
    MOVWF   contador1,0		;1Tcy
    NOP				;1Tcy
    NOP				;1Tcy

Delay_Loop_1ms:
    NOP				;k*Tcy
    DECFSZ  contador1,1,0	;(k-1) + 3Tcy
    GOTO    Delay_Loop_1ms	;(k-1)*2Tcy
    RETURN			;2Tcy

    
    
;----------5ms---------		    T = 10+6n+4nk
Delay_5ms:			    ;2Tcy -- Call
    MOVLW   5			    ;1Tcy
    MOVWF   contador2,0		    ;1Tcy
    NOP				    ;1Tcy
    NOP				    ;1Tcy

Ext_Loop_5ms:
    MOVLW   248			    ;n*Tcy
    MOVWF   contador1,0		    ;n*Tcy
    
Int_Loop_5ms:
    NOP				    ;n*k*Tcy
    DECFSZ  contador1,1,0	    ;n*[(k-1) + 3Tcy]
    GOTO    Int_Loop_5ms	    ;n*(k-1)*2Tcy
    NOP				    ;n*Tcy
    DECFSZ  contador2,1,0	    ;(n-1) + 3Tcy
    GOTO    Ext_Loop_5ms	    ;(n-1)*2Tcy
    NOP				    ;1Tcy
    NOP				    ;1Tcy
    RETURN			    ;2Tcy

    
;----------10ms---------	    T = 10+7n+4nk
Delay_10ms:			    ;2Tcy -- Call
    MOVLW   10			    ;1Tcy
    MOVWF   contador2,0		    ;1Tcy
    NOP				    ;1Tcy
    NOP				    ;1Tcy

Ext_Loop_10ms:
    MOVLW   248			    ;n*Tcy
    MOVWF   contador1,0		    ;n*Tcy
    
Int_Loop_10ms:
    NOP				    ;n*k*Tcy
    DECFSZ  contador1,1,0	    ;n*[(k-1) + 3Tcy]
    GOTO    Int_Loop_10ms	    ;n*(k-1)*2Tcy
    NOP				    ;n*Tcy
    NOP				    ;n*Tcy
    DECFSZ  contador2,1,0	    ;(n-1) + 3Tcy
    GOTO    Ext_Loop_10ms	    ;(n-1)*2Tcy
    NOP				    ;1Tcy
    NOP				    ;1Tcy
    RETURN			    ;2Tcy    

    
;----------25ms---------	    T = 6+8n+4nk
Delay_25ms:			    ;2Tcy -- Call
    MOVLW   25			    ;1Tcy
    MOVWF   contador2,0		    ;1Tcy

Ext_Loop_25ms:
    MOVLW   248			    ;n*Tcy
    MOVWF   contador1,0		    ;n*Tcy
    NOP				    ;n*Tcy
    
Int_Loop_25ms:
    NOP				    ;n*k*Tcy
    DECFSZ  contador1,1,0	    ;n*[(k-1) + 3Tcy]
    GOTO    Int_Loop_25ms	    ;n*(k-1)*2Tcy
    NOP				    ;n*Tcy
    NOP				    ;n*Tcy
    DECFSZ  contador2,1,0	    ;(n-1) + 3Tcy
    GOTO    Ext_Loop_25ms	    ;(n-1)*2Tcy
    RETURN			    ;2Tcy        

    
;----------50ms---------	    T = 6+8n+4nk
Delay_50ms:			    ;2Tcy -- Call
    MOVLW   50			    ;1Tcy
    MOVWF   contador2,0		    ;1Tcy

Ext_Loop_50ms:
    MOVLW   248			    ;n*Tcy
    MOVWF   contador1,0		    ;n*Tcy
    NOP				    ;n*Tcy
    
Int_Loop_50ms:
    NOP				    ;n*k*Tcy
    DECFSZ  contador1,1,0	    ;n*[(k-1) + 3Tcy]
    GOTO    Int_Loop_50ms	    ;n*(k-1)*2Tcy
    NOP				    ;n*Tcy
    NOP				    ;n*Tcy
    DECFSZ  contador2,1,0	    ;(n-1) + 3Tcy
    GOTO    Ext_Loop_50ms	    ;(n-1)*2Tcy
    RETURN			    ;2Tcy        

    
;----------100ms---------	    T = 6+8n+4nk
Delay_100ms:			    ;2Tcy -- Call
    MOVLW   100			    ;1Tcy
    MOVWF   contador2,0		    ;1Tcy

Ext_Loop_100ms:
    MOVLW   248			    ;n*Tcy
    MOVWF   contador1,0		    ;n*Tcy
    NOP				    ;n*Tcy
    
Int_Loop_100ms:
    NOP				    ;n*k*Tcy
    DECFSZ  contador1,1,0	    ;n*[(k-1) + 3Tcy]
    GOTO    Int_Loop_100ms	    ;n*(k-1)*2Tcy
    NOP				    ;n*Tcy
    NOP				    ;n*Tcy
    DECFSZ  contador2,1,0	    ;(n-1) + 3Tcy
    GOTO    Ext_Loop_100ms	    ;(n-1)*2Tcy
    RETURN			    ;2Tcy        

    
;----------200ms---------	    T = 6+8n+4nk
Delay_200ms:			    ;2Tcy -- Call
    MOVLW   200			    ;1Tcy
    MOVWF   contador2,0		    ;1Tcy

Ext_Loop_200ms:
    MOVLW   248			    ;n*Tcy
    MOVWF   contador1,0		    ;n*Tcy
    NOP				    ;n*Tcy
    
Int_Loop_200ms:
    NOP				    ;n*k*Tcy
    DECFSZ  contador1,1,0	    ;n*[(k-1) + 3Tcy]
    GOTO    Int_Loop_200ms	    ;n*(k-1)*2Tcy
    NOP				    ;n*Tcy
    NOP				    ;n*Tcy
    DECFSZ  contador2,1,0	    ;(n-1) + 3Tcy
    GOTO    Ext_Loop_200ms	    ;(n-1)*2Tcy
    RETURN			    ;2Tcy        

    
;----------250ms---------	    T = 6+8n+4nk
Delay_250ms:			    ;2Tcy -- Call
    MOVLW   250			    ;1Tcy
    MOVWF   contador2,0		    ;1Tcy

Ext_Loop_250ms:
    MOVLW   248			    ;n*Tcy
    MOVWF   contador1,0		    ;n*Tcy
    
Int_Loop_250ms:
    NOP				    ;n*k*Tcy
    DECFSZ  contador1,1,0	    ;n*[(k-1) + 3Tcy]
    GOTO    Int_Loop_250ms	    ;n*(k-1)*2Tcy
    NOP				    ;n*Tcy
    NOP				    ;n*Tcy
    NOP				    ;n*Tcy
    DECFSZ  contador2,1,0	    ;(n-1) + 3Tcy
    GOTO    Ext_Loop_250ms	    ;(n-1)*2Tcy
    RETURN			    ;2Tcy
    
