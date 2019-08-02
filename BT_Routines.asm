_BT_Configure:
;BT_Routines.c,9 :: 		void  BT_Configure() {
SUB	SP, SP, #4
STR	LR, [SP, #0]
;BT_Routines.c,11 :: 		do {
L_BT_Configure0:
;BT_Routines.c,12 :: 		UART3_Write_Text("$$$");                  // Enter command mode
MOVW	R0, #lo_addr(?lstr1_BT_Routines+0)
MOVT	R0, #hi_addr(?lstr1_BT_Routines+0)
BL	_UART3_Write_Text+0
;BT_Routines.c,13 :: 		Delay_ms(500);
MOVW	R7, #45225
MOVT	R7, #40
NOP
NOP
L_BT_Configure3:
SUBS	R7, R7, #1
BNE	L_BT_Configure3
NOP
NOP
;BT_Routines.c,14 :: 		} while (BT_Get_Response() != BT_CMD);
BL	_BT_Get_Response+0
MOVW	R1, _BT_CMD
MOVT	R1, _BT_CMD+2
CMP	R0, R1
IT	NE
BNE	L_BT_Configure0
;BT_Routines.c,16 :: 		do {
L_BT_Configure5:
;BT_Routines.c,17 :: 		UART3_Write_Text("SN,GEKO");   // Name of device
MOVW	R0, #lo_addr(?lstr2_BT_Routines+0)
MOVT	R0, #hi_addr(?lstr2_BT_Routines+0)
BL	_UART3_Write_Text+0
;BT_Routines.c,18 :: 		UART3_Write(13);                          // CR
MOVS	R0, #13
BL	_UART3_Write+0
;BT_Routines.c,19 :: 		Delay_ms(500);
MOVW	R7, #45225
MOVT	R7, #40
NOP
NOP
L_BT_Configure8:
SUBS	R7, R7, #1
BNE	L_BT_Configure8
NOP
NOP
;BT_Routines.c,20 :: 		} while (BT_Get_Response() != BT_AOK);
BL	_BT_Get_Response+0
MOVW	R1, _BT_AOK
MOVT	R1, _BT_AOK+2
CMP	R0, R1
IT	NE
BNE	L_BT_Configure5
;BT_Routines.c,22 :: 		do {
L_BT_Configure10:
;BT_Routines.c,23 :: 		UART3_Write_Text("SO,Slave");             // Extended status string
MOVW	R0, #lo_addr(?lstr3_BT_Routines+0)
MOVT	R0, #hi_addr(?lstr3_BT_Routines+0)
BL	_UART3_Write_Text+0
;BT_Routines.c,24 :: 		UART3_Write(13);                          // CR
MOVS	R0, #13
BL	_UART3_Write+0
;BT_Routines.c,25 :: 		Delay_ms(500);
MOVW	R7, #45225
MOVT	R7, #40
NOP
NOP
L_BT_Configure13:
SUBS	R7, R7, #1
BNE	L_BT_Configure13
NOP
NOP
;BT_Routines.c,26 :: 		} while (BT_Get_Response() != BT_AOK);
BL	_BT_Get_Response+0
MOVW	R1, _BT_AOK
MOVT	R1, _BT_AOK+2
CMP	R0, R1
IT	NE
BNE	L_BT_Configure10
;BT_Routines.c,28 :: 		do {
L_BT_Configure15:
;BT_Routines.c,29 :: 		UART3_Write_Text("SM,0");                 // Set mode (0 = slave, 1 = master, 2 = trigger, 3 = auto, 4 = DTR, 5 = ANY)
MOVW	R0, #lo_addr(?lstr4_BT_Routines+0)
MOVT	R0, #hi_addr(?lstr4_BT_Routines+0)
BL	_UART3_Write_Text+0
;BT_Routines.c,30 :: 		UART3_Write(13);                          // CR
MOVS	R0, #13
BL	_UART3_Write+0
;BT_Routines.c,31 :: 		Delay_ms(500);
MOVW	R7, #45225
MOVT	R7, #40
NOP
NOP
L_BT_Configure18:
SUBS	R7, R7, #1
BNE	L_BT_Configure18
NOP
NOP
;BT_Routines.c,32 :: 		} while (BT_Get_Response() != BT_AOK);
BL	_BT_Get_Response+0
MOVW	R1, _BT_AOK
MOVT	R1, _BT_AOK+2
CMP	R0, R1
IT	NE
BNE	L_BT_Configure15
;BT_Routines.c,34 :: 		do {
L_BT_Configure20:
;BT_Routines.c,35 :: 		UART3_Write_Text("SA,1");                 // Authentication (1 to enable, 0 to disable)
MOVW	R0, #lo_addr(?lstr5_BT_Routines+0)
MOVT	R0, #hi_addr(?lstr5_BT_Routines+0)
BL	_UART3_Write_Text+0
;BT_Routines.c,36 :: 		UART3_Write(13);                          // CR
MOVS	R0, #13
BL	_UART3_Write+0
;BT_Routines.c,37 :: 		Delay_ms(500);
MOVW	R7, #45225
MOVT	R7, #40
NOP
NOP
L_BT_Configure23:
SUBS	R7, R7, #1
BNE	L_BT_Configure23
NOP
NOP
;BT_Routines.c,38 :: 		} while (BT_Get_Response() != BT_AOK);
BL	_BT_Get_Response+0
MOVW	R1, _BT_AOK
MOVT	R1, _BT_AOK+2
CMP	R0, R1
IT	NE
BNE	L_BT_Configure20
;BT_Routines.c,40 :: 		do {
L_BT_Configure25:
;BT_Routines.c,41 :: 		UART3_Write_Text("SP,1234");              // Security pin code (mikroe)
MOVW	R0, #lo_addr(?lstr6_BT_Routines+0)
MOVT	R0, #hi_addr(?lstr6_BT_Routines+0)
BL	_UART3_Write_Text+0
;BT_Routines.c,42 :: 		UART3_Write(13);                          // CR
MOVS	R0, #13
BL	_UART3_Write+0
;BT_Routines.c,43 :: 		Delay_ms(500);
MOVW	R7, #45225
MOVT	R7, #40
NOP
NOP
L_BT_Configure28:
SUBS	R7, R7, #1
BNE	L_BT_Configure28
NOP
NOP
;BT_Routines.c,44 :: 		} while (BT_Get_Response() != BT_AOK);
BL	_BT_Get_Response+0
MOVW	R1, _BT_AOK
MOVT	R1, _BT_AOK+2
CMP	R0, R1
IT	NE
BNE	L_BT_Configure25
;BT_Routines.c,46 :: 		do {
L_BT_Configure30:
;BT_Routines.c,47 :: 		UART3_Write_Text("---");                  // Security pin code (mikroe)
MOVW	R0, #lo_addr(?lstr7_BT_Routines+0)
MOVT	R0, #hi_addr(?lstr7_BT_Routines+0)
BL	_UART3_Write_Text+0
;BT_Routines.c,48 :: 		UART3_Write(13);                          // CR
MOVS	R0, #13
BL	_UART3_Write+0
;BT_Routines.c,49 :: 		Delay_ms(500);
MOVW	R7, #45225
MOVT	R7, #40
NOP
NOP
L_BT_Configure33:
SUBS	R7, R7, #1
BNE	L_BT_Configure33
NOP
NOP
;BT_Routines.c,50 :: 		} while (BT_Get_Response() != BT_END);
BL	_BT_Get_Response+0
MOVW	R1, _BT_END
MOVT	R1, _BT_END+2
CMP	R0, R1
IT	NE
BNE	L_BT_Configure30
;BT_Routines.c,51 :: 		}
L_end_BT_Configure:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _BT_Configure
