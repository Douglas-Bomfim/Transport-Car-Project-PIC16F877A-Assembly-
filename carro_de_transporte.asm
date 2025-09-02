;*******************************************************************************
; UFSC- Universidade Federal de Santa Catarina
; Projeto: Carro de transporte
; Autor: Douglas Bomfim de Sousa
; Carro de transporte em assembly
;*******************************************************************************

#include <P16F877A.INC> 
__CONFIG  _CP_OFF & _CPD_OFF & _DEBUG_OFF & _LVP_OFF & _WRT_OFF & _BODEN_OFF & _PWRTE_OFF & _WDT_OFF & _XT_OSC
cblock 0x20
    tempo0		
    tempo1			; Vari?veis usadas na rotina de delay.
    tempo2
    filtro
        					
endc 

org 0x00		      ; Vetor de reset do uC.
goto inicio
    
;****************** Inicio do programa *****************************************   
inicio:
    CLRF PORTB		    ; Inicializa o Port B com zero
    CLRF PORTD		    ; Inicializa o Port D com zero
    BANKSEL TRISB	    ;Seleciona banco de memoria 1
    BSF TRISB, 0	    ; Configura o pino 0 da porta B como entrada 
    BSF TRISB, 1	    ; Configura o pino 1 da porta B como entrada
    BSF TRISB, 2	    ; Configura o pino 2 da porta B como entrada
    BSF TRISB, 3	    ; Configura o pino 3 da porta B como entrada
    BANKSEL TRISD	    ;Seleciona banco de memoria 1
    BCF TRISD, 0	    ; Configura o pino 0 da porta D como entrada
    BCF TRISD, 1	    ; Configura o pino 1 da porta D como entrada
    BCF TRISD, 2	    ; Configura o pino 2 da porta D como entrada
    BCF TRISD, 3	    ; Configura o pino 3 da porta D como entrada
    BCF TRISD, 4	    ; Configura o pino 4 da porta D como entrada
    BCF TRISD, 5	    ; Configura o pino 5 da porta D como entrada
    BCF TRISD, 6	    ; Configura o pino 6 da porta D como entrada
    BCF TRISD, 7	    ; Configura o pino 7 da porta D como entrada
    
;*********************** Loop principal ****************************************
esperando_comando:
    BANKSEL PORTD	    ;Seleciona banco de memoria 0
    BCF PORTD, 4	    ;Desliga o LED B
    BCF PORTD, 3	    ;Desliga o LED C
    BCF PORTD, 2	    ;Desliga o LED D
    BCF PORTD, 1	    ;Desliga o LED E
    BANKSEL PORTB	    ;Seleciona banco de memoria 1
    BTFSC PORTB, 3	    ;Verifica se o bit esta em 1
    GOTO esperando_comando  ;Se estiver vai para esperando_comando
    BANKSEL PORTD	    ;Seleciona banco de memoria 0
    BSF PORTD, 5	    ;Liga o LED A
    BANKSEL PORTB	    ;Seleciona banco de memoria o
    BTFSS PORTB, 0	    ;Verifica se o bit esta em 0
    GOTO indoab		    ;Se estiver vai para indoab
    GOTO esperando_comando  ;Se nao volta para o loop principal
    
;*********************Movimentando indo para direita****************************
indoab:
    BANKSEL PORTD	    ;Seleciona banco de memoria 0
    BSF PORTD, 4	    ;Liga o LED B
    BANKSEL PORTB	    ;Seleciona banco de momoria 0
    BTFSS PORTB, 1	    ;verifica se o bit esta em 0
    GOTO pontob		    ;Se estiver vai para o pontob
    CALL delay_pisca	    ;Se nao chama o delay_pisca
    BANKSEL PORTD	    ;Seleciona banco de memoria 0
    BCF PORTD, 4	    ;Desliga o LED B
    BCF PORTD, 5	    ;Desliga o LED A
    BSF PORTD, 3	    ;Liga o LED C
    BANKSEL PORTB	    ;Seleciona o banco de memoria 0
    BTFSS PORTB, 1	    ;Seleciona banco de momoria 0
    GOTO pontob		    ;Se estiver vai para o pontob
    CALL delay_pisca	    ;Se nao chama delay_pisca
    BANKSEL PORTD	    ;Seleciona banco de memoria 0
    BCF PORTD, 3	    ;Desliga o LED C
    BSF PORTD, 2	    ;Liga o LED D
    BANKSEL PORTB	    ;Seleciona banco de memoria 0
    BTFSS PORTB, 1	    ;verifica se o bit esta em 0
    GOTO pontob		    ;Se estiver vai para o pontob
    CALL delay_pisca	    ;Se nao chama delay_pisca
    BANKSEL PORTD	    ;Seleciona banco de memoria 0
    BCF PORTD, 2	    ;Desliga o LED D
    GOTO indoab		    ;Vai para o indoAB
    
;*********************Loop parado no b******************************************   
pontob:
    BANKSEL PORTD	    ;Seleciona banco de memoria 0
    BCF PORTD, 4	    ;Desliga o LED B
    BCF PORTD, 3	    ;Desliga o LED C
    BCF PORTD, 2	    ;Desliga o LED D	
    BSF PORTD, 0	    ;Liga o LED E
    CALL delay_um_segundo   ;Chama o delay de um segundo
    BSF PORTD, 7	    ;Liga o LED G
    BSF PORTD, 6	    ;Liga o LED F 
    CALL esperar_carregar   ;vai para esperar carregar
    BCF PORTD, 6	    ;Desliga o LED F
    CALL delay_cinco_segundos;Vai para o delay de 5 segundos
    BCF PORTD, 7	    ;Desliga o LED G
    goto indoba		    ; Vai para o indoab

;******************Movimentando para a esquerda*********************************   
indoba:
    BANKSEL PORTD	;Seleciona banco de memoria 0
    BSF PORTD, 2	;Liga o LED D
    BANKSEL PORTB	;Seleciona banco de memoria 0
    BTFSS PORTB, 3	;Verifica se o bit esta em 0
    GOTO esperando_comando;Se estiver vai para esperando comando
    CALL delay_pisca	;se nao chama o delay_pisca
    BANKSEL PORTD	;Seleciona banco de memoria 0
    BCF PORTD, 0	;Desliga o LED E
    BCF PORTD, 2	;Desliga o LED D
    BSF PORTD, 3	;Liga o LED C
    BANKSEL PORTB	;Seleciona o banco de memoria 0
    BTFSS PORTB, 3	;Verifica se o bit esta em 0
    GOTO esperando_comando;Se estiver vai para esperando comando
    CALL delay_pisca	;se nao chama delay_pisca
    BANKSEL PORTD	;Seleciona banco de memoria 0
    BCF PORTD, 3	;Desliga o lED C
    BSF PORTD, 4	;Liga o LED B
    BANKSEL PORTB	;Seleciona banco de memoria 0
    BTFSS PORTB, 3	;Verifica se o bit esta em 0
    GOTO esperando_comando;se estiver vai para esperando comanso
    CALL delay_pisca	;se nao delay_pisca
    BANKSEL PORTD	;Seleciona o banco de memoria 0
    BCF PORTD, 4	;Apaga o LED B
    GOTO indoba		;vai para indoab
    
;*********************Loop Sendo carregado**************************************    
esperar_carregar:
    BANKSEL PORTB	;Seleciona banco de memoria 0
    BTFSS PORTB, 2	;Verifica se o bit esta em 0
    RETURN		;se estiver retorna
    GOTO esperar_carregar;se n o vai para esperar_carregar
	
;*********************Delay para piscar*****************************************    
delay_pisca:
    movlw   .01		; vai carrega tempo2 com constante  
    movwf   tempo2	; carrega tempo2   
denovo2:
    movlw	.125	; vai carrega tempo1 com constante
    movwf	tempo1	; Carrega tempo1 
denovo:	
    movlw	.125    ; vai carregar tempo0 com constante
    movwf	tempo0	; Carrega tempo0 
volta:	
    nop			    ; gasta 1 ciclo de m?quina(1us para clock 4Mhz)
    decfsz	tempo0,F; Fim de tempo0 ? (gasta 2 us)
    goto	volta	; N?o - Volta (gasta 1us)
			; Sim - Passou-se 1ms. (4us x 250 = 1ms)
    decfsz	tempo1,F; Fim de tempo1?
    goto	denovo	; N?o - Volta 
			; Sim. 250 x 1ms = 250ms	
    decfsz	tempo2,F; Fim de tempo2?
    goto	denovo2	; N?o - Volta 
				        ; Sim. 4 x 250 = 1s				
return   		    	; Retorna.

;*********************Delay de um segundo***************************************
delay_um_segundo:
    movlw   .01		; vai carrega tempo2 com constante  
    movwf   tempo2	; carrega tempo2   
denovo21:
    movlw	.255	; vai carrega tempo1 com constante
    movwf	tempo1	; Carrega tempo1 
denovo1:	
    movlw	.255    ; vai carregar tempo0 com constante
    movwf	tempo0	; Carrega tempo0 
volta1:	
    nop			    ; gasta 1 ciclo de m?quina(1us para clock 4Mhz)
    decfsz	tempo0,F; Fim de tempo0 ? (gasta 2 us)
    goto	volta1	; N?o - Volta (gasta 1us)
			; Sim - Passou-se 1ms. (4us x 250 = 1ms)
    decfsz	tempo1,F; Fim de tempo1?
    goto	denovo1	; N?o - Volta 
				        ; Sim. 250 x 1ms = 250ms	
	    decfsz	tempo2,F; Fim de tempo2?
	    goto	denovo21	; N?o - Volta 
				        ; Sim. 4 x 250 = 1s				
 return   		    	; Retorna.
 
;*********************Delay de cinco segundos*********************************** 
delay_cinco_segundos:
    movlw   .05		; vai carrega tempo2 com constante  
    movwf   tempo2	; carrega tempo2   
denovo22:
    movlw	.255	; vai carrega tempo1 com constante
    movwf	tempo1	; Carrega tempo1 
denovo3:	
    movlw	.255    ; vai carregar tempo0 com constante
    movwf	tempo0	; Carrega tempo0 
volta2:	
    nop			    ; gasta 1 ciclo de m?quina(1us para clock 4Mhz)
    decfsz	tempo0,F; Fim de tempo0 ? (gasta 2 us)
    goto	volta2	; N?o - Volta (gasta 1us)
				        ; Sim - Passou-se 1ms. (4us x 250 = 1ms)
    decfsz	tempo1,F; Fim de tempo1?
    goto	denovo3	; N?o - Volta 
				        ; Sim. 250 x 1ms = 250ms	
    decfsz	tempo2,F; Fim de tempo2?
    goto	denovo22	; N?o - Volta 
				        ; Sim. 4 x 250 = 1s				
 return   		    	; Retorna.
    
END
