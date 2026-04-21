;***********************************************************; 
;程式名稱 : Homework 1;  
;***********************************************************;
        ORG     00H
        JMP     START
        ORG     30H
START:
        MOV     R0, #10          ; R0 : 迴圈計數
        MOV     R1, #06          
        MOV     R2, #08          
        MOV     DPTR, #LED_TABLE ; DPTR 指向 LED 顯示資料表
LOOP1:
        CALL    SEND_LEDCODE
        CALL    DELAY_05S         
        ; Delay time 0.5 SEC
        DJNZ    R0, LOOP1
LOOP2:
        CALL    SEND_LEDCODE
        CALL    DELAY_025S        
        ; Delay time 0.25 SEC
        DJNZ    R1, LOOP2
LOOP3:
        CALL    SEND_LEDCODE
        CALL    DELAY_1S          
        ; Delay time 1 SEC
        DJNZ    R2, LOOP3
        JMP     START            
        ; Jump to START

;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; 副程式名稱 ︰ READ_LEDCODE
; 功  能    ︰ 讀LED 碼儲存在累積器 ACC 中
;使用暫存器  ︰ A,DPTR
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

READ_LEDCODE:
        MOV     A,#0            ;
        MOVC    A,@A+DPTR       ; 將查表所得之資料送至 P0
        RET;
		
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; Subprogram Name: SEND_LEDCODE
; Function: Send LED code to corresponding PORT
; Register: A, P0, P1, P2, P3
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
SEND_LEDCODE:
        CALL    READ_LEDCODE     
        ; Read LED code
        MOV     P0, A            
        ; Send LED code to PORT-0
        INC     DPTR             
        ; Point to the next LED data
        CALL    READ_LEDCODE     
        ; Read LED code
        MOV     P1, A            
        ; Send LED code to PORT-1
        INC     DPTR             
        ; Point to the next LED data
        CALL    READ_LEDCODE     
        ; Read LED code
        MOV     P2, A            
        ; Send LED code to PORT-2
        INC     DPTR             
        ; Point to the next LED data
        CALL    READ_LEDCODE     
        ; Read LED code
        MOV     P3, A            
        ; Send LED code to PORT-3
        INC     DPTR             
        ; Point to the next LED data
        RET                      
        ; Return

;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; Subprogram Name: DELAY_025S
; Function: Delay time 0.25 SEC
; Register: R5, R4, R3
; Delay Time: T=1+R5*[1+R4*(1+R3*2+2)+2]+2
;              =T=1+2*[1+254*(1+245*2+2)+2]+2
;              =250499 us
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

DELAY_025S:
        MOV     R5, #02        
LOOP6:
        MOV     R4,#254
LOOP5:
        MOV     R3,#245
        NOP
LOOP4:
        DJNZ    R3, LOOP4       
        DJNZ    R4, LOOP5       
        DJNZ    R5, LOOP6       
        RET                     
        ; Return
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; Subprogram Name: DELAY_1S
; Function: Delay time 1 SEC
; Register: R2
; Delay Time: T=0.25*4 = 1 SEC
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
DELAY_1S:
        MOV     R6, #04         
LOOP7:
        CALL    DELAY_025S
        DJNZ    R6, LOOP7
		RET

;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; Subprogram Name: DELAY_05S
; Function: Delay time 0.5 SEC
; Register: R1
; Delay Time: T=0.25*2 = 0.5 SEC
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

DELAY_05S:
        MOV     R7, #02       
LOOP8:
        CALL    DELAY_025S
        DJNZ    R7, LOOP8
		RET
	
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
; LED_TABLE  
;@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


LED_TABLE:               
; LED 顯示資料表(資料開頭需為數字)

        DB      01010101B,01010101B,01010101B,01010101B
        DB      10101010B,10101010B,10101010B,10101010B
        DB      00110011B,00110011B,00110011B,00110011B
        DB      11001100B,11001100B,11001100B,11001100B
        DB      00001111B,00001111B,00001111B,00001111B
        DB      11110000B,11110000B,11110000B,11110000B
        DB      00000000B,11111111B,00000000B,11111111B
        DB      11111111B,00000000B,11111111B,00000000B
        DB      11111111B,11111111B,00000000B,00000000B
        DB      00000000B,00000000B,11111111B,11111111B


        DB      00H,00H,00H,00H
        DB      0FFH,0FFH,0FFH,0FFH
        DB      00H,00H,00H,00H
        DB      0FFH,0FFH,0FFH,0FFH
        DB      00H,00H,00H,00H
        DB      0FFH,0FFH,0FFH,0FFH


        DB      00010001B,00010001B,00010001B,00010001B
        DB      00110011B,00110011B,00110011B,00110011B
        DB      01110111B,01110111B,01110111B,01110111B
        DB      0FFH,0FFH,0FFH,0FFH
        DB      11101110B,11101110B,11101110B,11101110B
        DB      11001100B,11001100B,11001100B,11001100B
        DB      10001000B,10001000B,10001000B,10001000B
        DB     	00H,00H,00H,00H

END