
PSECT udata_acs
contador1: DS	1		;reserva un bit en acces ram
contador2: DS	1		;reserva un bit en acces ram
    
PSECT CODE
 
 
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
    



