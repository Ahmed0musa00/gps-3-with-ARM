_DrawScr:
;Bluetooth_click.c,23 :: 		void DrawScr(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Bluetooth_click.c,24 :: 		TFT_Fill_Screen(CL_WHITE);
MOVW	R0, #65535
BL	_TFT_Fill_Screen+0
;Bluetooth_click.c,25 :: 		TFT_Set_Pen(CL_Black, 1);
MOVS	R1, #1
MOVW	R0, #0
BL	_TFT_Set_Pen+0
;Bluetooth_click.c,26 :: 		TFT_Line(20, 220, 300, 220);
MOVS	R3, #220
SXTH	R3, R3
MOVW	R2, #300
SXTH	R2, R2
MOVS	R1, #220
SXTH	R1, R1
MOVS	R0, #20
SXTH	R0, R0
BL	_TFT_Line+0
;Bluetooth_click.c,27 :: 		TFT_LIne(20,  46, 300,  46);
MOVS	R3, #46
SXTH	R3, R3
MOVW	R2, #300
SXTH	R2, R2
MOVS	R1, #46
SXTH	R1, R1
MOVS	R0, #20
SXTH	R0, R0
BL	_TFT_Line+0
;Bluetooth_click.c,28 :: 		TFT_Set_Font(&HandelGothic_BT21x22_Regular, CL_RED, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #63488
MOVW	R0, #lo_addr(_HandelGothic_BT21x22_Regular+0)
MOVT	R0, #hi_addr(_HandelGothic_BT21x22_Regular+0)
BL	_TFT_Set_Font+0
;Bluetooth_click.c,29 :: 		TFT_Write_Text("Bluetooth  TEST", 75, 14);
MOVW	R0, #lo_addr(?lstr1_Bluetooth_click+0)
MOVT	R0, #hi_addr(?lstr1_Bluetooth_click+0)
MOVS	R2, #14
MOVS	R1, #75
BL	_TFT_Write_Text+0
;Bluetooth_click.c,30 :: 		TFT_Set_Font(&Verdana12x13_Regular, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_Verdana12x13_Regular+0)
MOVT	R0, #hi_addr(_Verdana12x13_Regular+0)
BL	_TFT_Set_Font+0
;Bluetooth_click.c,31 :: 		TFT_Write_Text("EasyMX PRO v7", 19, 223);
MOVW	R0, #lo_addr(?lstr2_Bluetooth_click+0)
MOVT	R0, #hi_addr(?lstr2_Bluetooth_click+0)
MOVS	R2, #223
MOVS	R1, #19
BL	_TFT_Write_Text+0
;Bluetooth_click.c,32 :: 		TFT_Set_Font(&Verdana12x13_Regular, CL_RED, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #63488
MOVW	R0, #lo_addr(_Verdana12x13_Regular+0)
MOVT	R0, #hi_addr(_Verdana12x13_Regular+0)
BL	_TFT_Set_Font+0
;Bluetooth_click.c,33 :: 		TFT_Write_Text("www.mikroe.com", 200, 223);
MOVW	R0, #lo_addr(?lstr3_Bluetooth_click+0)
MOVT	R0, #hi_addr(?lstr3_Bluetooth_click+0)
MOVS	R2, #223
MOVS	R1, #200
BL	_TFT_Write_Text+0
;Bluetooth_click.c,34 :: 		TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Bluetooth_click.c,35 :: 		}
L_end_DrawScr:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _DrawScr
_interrupt:
;Bluetooth_click.c,40 :: 		void interrupt() iv IVT_INT_USART3 ics ICS_AUTO{
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Bluetooth_click.c,41 :: 		tmp = UART3_Read();                          // Get received byte
BL	_UART3_Read+0
MOVW	R1, #lo_addr(_tmp+0)
MOVT	R1, #hi_addr(_tmp+0)
STRB	R0, [R1, #0]
;Bluetooth_click.c,43 :: 		if (CMD_mode){
MOVW	R0, #lo_addr(_CMD_mode+0)
MOVT	R0, #hi_addr(_CMD_mode+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interrupt0
;Bluetooth_click.c,60 :: 		switch (BT_state) {
IT	AL
BAL	L_interrupt1
;Bluetooth_click.c,61 :: 		case  0: {
L_interrupt3:
;Bluetooth_click.c,62 :: 		response = 0;                   // Clear response
MOVS	R1, #0
MOVW	R0, #lo_addr(_response+0)
MOVT	R0, #hi_addr(_response+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,63 :: 		if (tmp == 'C')                 // We have 'C', it could be CMD<cr><lf>  or CONN
MOVW	R0, #lo_addr(_tmp+0)
MOVT	R0, #hi_addr(_tmp+0)
LDRB	R0, [R0, #0]
CMP	R0, #67
IT	NE
BNE	L_interrupt4
;Bluetooth_click.c,64 :: 		BT_state = 1;                 // Expecting 'M' or 'N'
MOVS	R1, #1
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
L_interrupt4:
;Bluetooth_click.c,65 :: 		if (tmp == 'A')                 // We have 'A', it could be AOK<cr><lf>
MOVW	R0, #lo_addr(_tmp+0)
MOVT	R0, #hi_addr(_tmp+0)
LDRB	R0, [R0, #0]
CMP	R0, #65
IT	NE
BNE	L_interrupt5
;Bluetooth_click.c,66 :: 		BT_state = 11;                // expecting 'O'
MOVS	R1, #11
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
L_interrupt5:
;Bluetooth_click.c,67 :: 		if (tmp == 'E')                 // We have 'E', it could be END<cr><lf>
MOVW	R0, #lo_addr(_tmp+0)
MOVT	R0, #hi_addr(_tmp+0)
LDRB	R0, [R0, #0]
CMP	R0, #69
IT	NE
BNE	L_interrupt6
;Bluetooth_click.c,68 :: 		BT_state = 31;                // expecting 'N'
MOVS	R1, #31
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
L_interrupt6:
;Bluetooth_click.c,69 :: 		break;                          // ...
IT	AL
BAL	L_interrupt2
;Bluetooth_click.c,72 :: 		case  1: {
L_interrupt7:
;Bluetooth_click.c,73 :: 		if (tmp == 'M')
MOVW	R0, #lo_addr(_tmp+0)
MOVT	R0, #hi_addr(_tmp+0)
LDRB	R0, [R0, #0]
CMP	R0, #77
IT	NE
BNE	L_interrupt8
;Bluetooth_click.c,74 :: 		BT_state = 2;
MOVS	R1, #2
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
IT	AL
BAL	L_interrupt9
L_interrupt8:
;Bluetooth_click.c,75 :: 		else if (tmp == 'O')
MOVW	R0, #lo_addr(_tmp+0)
MOVT	R0, #hi_addr(_tmp+0)
LDRB	R0, [R0, #0]
CMP	R0, #79
IT	NE
BNE	L_interrupt10
;Bluetooth_click.c,76 :: 		BT_state = 22;
MOVS	R1, #22
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
IT	AL
BAL	L_interrupt11
L_interrupt10:
;Bluetooth_click.c,78 :: 		BT_state = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
L_interrupt11:
L_interrupt9:
;Bluetooth_click.c,79 :: 		break;
IT	AL
BAL	L_interrupt2
;Bluetooth_click.c,82 :: 		case  2: {
L_interrupt12:
;Bluetooth_click.c,83 :: 		if (tmp == 'D') {
MOVW	R0, #lo_addr(_tmp+0)
MOVT	R0, #hi_addr(_tmp+0)
LDRB	R0, [R0, #0]
CMP	R0, #68
IT	NE
BNE	L_interrupt13
;Bluetooth_click.c,84 :: 		response = BT_CMD;           // CMD
MOVS	R1, #1
MOVW	R0, #lo_addr(_response+0)
MOVT	R0, #hi_addr(_response+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,85 :: 		BT_state = 40;
MOVS	R1, #40
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,86 :: 		}
IT	AL
BAL	L_interrupt14
L_interrupt13:
;Bluetooth_click.c,88 :: 		BT_state = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
L_interrupt14:
;Bluetooth_click.c,89 :: 		break;
IT	AL
BAL	L_interrupt2
;Bluetooth_click.c,92 :: 		case 11: {
L_interrupt15:
;Bluetooth_click.c,93 :: 		if (tmp == 'O')
MOVW	R0, #lo_addr(_tmp+0)
MOVT	R0, #hi_addr(_tmp+0)
LDRB	R0, [R0, #0]
CMP	R0, #79
IT	NE
BNE	L_interrupt16
;Bluetooth_click.c,94 :: 		BT_state = 12;
MOVS	R1, #12
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
IT	AL
BAL	L_interrupt17
L_interrupt16:
;Bluetooth_click.c,96 :: 		BT_state = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
L_interrupt17:
;Bluetooth_click.c,97 :: 		break;
IT	AL
BAL	L_interrupt2
;Bluetooth_click.c,100 :: 		case 12: {
L_interrupt18:
;Bluetooth_click.c,101 :: 		if (tmp == 'K'){
MOVW	R0, #lo_addr(_tmp+0)
MOVT	R0, #hi_addr(_tmp+0)
LDRB	R0, [R0, #0]
CMP	R0, #75
IT	NE
BNE	L_interrupt19
;Bluetooth_click.c,102 :: 		response = BT_AOK;            // AOK
MOVS	R1, #2
MOVW	R0, #lo_addr(_response+0)
MOVT	R0, #hi_addr(_response+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,103 :: 		BT_state = 40;
MOVS	R1, #40
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,104 :: 		}
IT	AL
BAL	L_interrupt20
L_interrupt19:
;Bluetooth_click.c,106 :: 		BT_state = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
L_interrupt20:
;Bluetooth_click.c,107 :: 		break;
IT	AL
BAL	L_interrupt2
;Bluetooth_click.c,110 :: 		case 22: {
L_interrupt21:
;Bluetooth_click.c,111 :: 		if (tmp == 'N')
MOVW	R0, #lo_addr(_tmp+0)
MOVT	R0, #hi_addr(_tmp+0)
LDRB	R0, [R0, #0]
CMP	R0, #78
IT	NE
BNE	L_interrupt22
;Bluetooth_click.c,112 :: 		BT_state = 23;
MOVS	R1, #23
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
IT	AL
BAL	L_interrupt23
L_interrupt22:
;Bluetooth_click.c,114 :: 		BT_state = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
L_interrupt23:
;Bluetooth_click.c,115 :: 		break;
IT	AL
BAL	L_interrupt2
;Bluetooth_click.c,118 :: 		case 23: {
L_interrupt24:
;Bluetooth_click.c,119 :: 		if (tmp == 'N') {
MOVW	R0, #lo_addr(_tmp+0)
MOVT	R0, #hi_addr(_tmp+0)
LDRB	R0, [R0, #0]
CMP	R0, #78
IT	NE
BNE	L_interrupt25
;Bluetooth_click.c,120 :: 		response = BT_CONN;           // SlaveCONNECTmikroE
MOVS	R1, #3
MOVW	R0, #lo_addr(_response+0)
MOVT	R0, #hi_addr(_response+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,121 :: 		response_rcvd = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_response_rcvd+0)
MOVT	R0, #hi_addr(_response_rcvd+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,122 :: 		responseID = response;
MOVS	R1, #3
MOVW	R0, #lo_addr(_responseID+0)
MOVT	R0, #hi_addr(_responseID+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,123 :: 		}
L_interrupt25:
;Bluetooth_click.c,124 :: 		BT_state = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,125 :: 		break;
IT	AL
BAL	L_interrupt2
;Bluetooth_click.c,128 :: 		case 31: {
L_interrupt26:
;Bluetooth_click.c,129 :: 		if (tmp == 'N')
MOVW	R0, #lo_addr(_tmp+0)
MOVT	R0, #hi_addr(_tmp+0)
LDRB	R0, [R0, #0]
CMP	R0, #78
IT	NE
BNE	L_interrupt27
;Bluetooth_click.c,130 :: 		BT_state = 32;
MOVS	R1, #32
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
IT	AL
BAL	L_interrupt28
L_interrupt27:
;Bluetooth_click.c,132 :: 		BT_state = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
L_interrupt28:
;Bluetooth_click.c,133 :: 		break;
IT	AL
BAL	L_interrupt2
;Bluetooth_click.c,136 :: 		case 32: {
L_interrupt29:
;Bluetooth_click.c,137 :: 		if (tmp == 'D') {
MOVW	R0, #lo_addr(_tmp+0)
MOVT	R0, #hi_addr(_tmp+0)
LDRB	R0, [R0, #0]
CMP	R0, #68
IT	NE
BNE	L_interrupt30
;Bluetooth_click.c,138 :: 		response = BT_END;           // END
MOVS	R1, #4
MOVW	R0, #lo_addr(_response+0)
MOVT	R0, #hi_addr(_response+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,139 :: 		BT_state = 40;
MOVS	R1, #40
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,140 :: 		}
IT	AL
BAL	L_interrupt31
L_interrupt30:
;Bluetooth_click.c,142 :: 		BT_state = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
L_interrupt31:
;Bluetooth_click.c,143 :: 		break;
IT	AL
BAL	L_interrupt2
;Bluetooth_click.c,146 :: 		case 40: {
L_interrupt32:
;Bluetooth_click.c,147 :: 		if (tmp == 13)
MOVW	R0, #lo_addr(_tmp+0)
MOVT	R0, #hi_addr(_tmp+0)
LDRB	R0, [R0, #0]
CMP	R0, #13
IT	NE
BNE	L_interrupt33
;Bluetooth_click.c,148 :: 		BT_state = 41;
MOVS	R1, #41
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
IT	AL
BAL	L_interrupt34
L_interrupt33:
;Bluetooth_click.c,150 :: 		BT_state = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
L_interrupt34:
;Bluetooth_click.c,151 :: 		break;
IT	AL
BAL	L_interrupt2
;Bluetooth_click.c,154 :: 		case 41: {
L_interrupt35:
;Bluetooth_click.c,155 :: 		if (tmp == 10){
MOVW	R0, #lo_addr(_tmp+0)
MOVT	R0, #hi_addr(_tmp+0)
LDRB	R0, [R0, #0]
CMP	R0, #10
IT	NE
BNE	L_interrupt36
;Bluetooth_click.c,156 :: 		response_rcvd = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_response_rcvd+0)
MOVT	R0, #hi_addr(_response_rcvd+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,157 :: 		responseID = response;
MOVW	R0, #lo_addr(_response+0)
MOVT	R0, #hi_addr(_response+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_responseID+0)
MOVT	R0, #hi_addr(_responseID+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,158 :: 		}
L_interrupt36:
;Bluetooth_click.c,159 :: 		BT_state = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,160 :: 		break;
IT	AL
BAL	L_interrupt2
;Bluetooth_click.c,163 :: 		default: {
L_interrupt37:
;Bluetooth_click.c,164 :: 		BT_state = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,165 :: 		break;
IT	AL
BAL	L_interrupt2
;Bluetooth_click.c,167 :: 		}
L_interrupt1:
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_interrupt3
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	EQ
BEQ	L_interrupt7
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	EQ
BEQ	L_interrupt12
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
LDRB	R0, [R0, #0]
CMP	R0, #11
IT	EQ
BEQ	L_interrupt15
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
LDRB	R0, [R0, #0]
CMP	R0, #12
IT	EQ
BEQ	L_interrupt18
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
LDRB	R0, [R0, #0]
CMP	R0, #22
IT	EQ
BEQ	L_interrupt21
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
LDRB	R0, [R0, #0]
CMP	R0, #23
IT	EQ
BEQ	L_interrupt24
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
LDRB	R0, [R0, #0]
CMP	R0, #31
IT	EQ
BEQ	L_interrupt26
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
LDRB	R0, [R0, #0]
CMP	R0, #32
IT	EQ
BEQ	L_interrupt29
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
LDRB	R0, [R0, #0]
CMP	R0, #40
IT	EQ
BEQ	L_interrupt32
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
LDRB	R0, [R0, #0]
CMP	R0, #41
IT	EQ
BEQ	L_interrupt35
IT	AL
BAL	L_interrupt37
L_interrupt2:
;Bluetooth_click.c,168 :: 		}
IT	AL
BAL	L_interrupt38
L_interrupt0:
;Bluetooth_click.c,170 :: 		if (tmp == 13) {
MOVW	R0, #lo_addr(_tmp+0)
MOVT	R0, #hi_addr(_tmp+0)
LDRB	R0, [R0, #0]
CMP	R0, #13
IT	NE
BNE	L_interrupt39
;Bluetooth_click.c,171 :: 		txt[i] = 0;                            // Puting 0 at the end of the string
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
ADDS	R1, R0, R1
MOVS	R0, #0
STRB	R0, [R1, #0]
;Bluetooth_click.c,172 :: 		DataReady = 1;                         // Data is received
MOVS	R1, #1
MOVW	R0, #lo_addr(_DataReady+0)
MOVT	R0, #hi_addr(_DataReady+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,173 :: 		}
IT	AL
BAL	L_interrupt40
L_interrupt39:
;Bluetooth_click.c,175 :: 		txt[i] = tmp;                          // Moving the data received from UART to string txt[]
MOVW	R2, #lo_addr(_i+0)
MOVT	R2, #hi_addr(_i+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
ADDS	R1, R0, R1
MOVW	R0, #lo_addr(_tmp+0)
MOVT	R0, #hi_addr(_tmp+0)
LDRB	R0, [R0, #0]
STRB	R0, [R1, #0]
;Bluetooth_click.c,176 :: 		i++;                                   // Increment counter
MOV	R0, R2
LDRB	R0, [R0, #0]
ADDS	R0, R0, #1
STRB	R0, [R2, #0]
;Bluetooth_click.c,177 :: 		}
L_interrupt40:
;Bluetooth_click.c,178 :: 		}
L_interrupt38:
;Bluetooth_click.c,179 :: 		}
L_end_interrupt:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _interrupt
_BT_Get_Response:
;Bluetooth_click.c,182 :: 		char BT_Get_Response() {
;Bluetooth_click.c,183 :: 		if (response_rcvd) {
MOVW	R0, #lo_addr(_response_rcvd+0)
MOVT	R0, #hi_addr(_response_rcvd+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_BT_Get_Response41
;Bluetooth_click.c,184 :: 		response_rcvd = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_response_rcvd+0)
MOVT	R0, #hi_addr(_response_rcvd+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,185 :: 		return responseID;
MOVW	R0, #lo_addr(_responseID+0)
MOVT	R0, #hi_addr(_responseID+0)
LDRB	R0, [R0, #0]
IT	AL
BAL	L_end_BT_Get_Response
;Bluetooth_click.c,186 :: 		}
L_BT_Get_Response41:
;Bluetooth_click.c,188 :: 		return 0;
MOVS	R0, #0
;Bluetooth_click.c,189 :: 		}
L_end_BT_Get_Response:
BX	LR
; end of _BT_Get_Response
_InitTimer2:
;Bluetooth_click.c,193 :: 		void InitTimer2(){
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Bluetooth_click.c,194 :: 		RCC_APB1ENR.TIM2EN = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(RCC_APB1ENR+0)
MOVT	R0, #hi_addr(RCC_APB1ENR+0)
_SX	[R0, ByteOffset(RCC_APB1ENR+0)]
;Bluetooth_click.c,195 :: 		TIM2_CR1.CEN = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
_SX	[R0, ByteOffset(TIM2_CR1+0)]
;Bluetooth_click.c,196 :: 		TIM2_PSC = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(TIM2_PSC+0)
MOVT	R0, #hi_addr(TIM2_PSC+0)
STR	R1, [R0, #0]
;Bluetooth_click.c,197 :: 		TIM2_ARR = 15999;
MOVW	R1, #15999
MOVW	R0, #lo_addr(TIM2_ARR+0)
MOVT	R0, #hi_addr(TIM2_ARR+0)
STR	R1, [R0, #0]
;Bluetooth_click.c,198 :: 		NVIC_IntEnable(IVT_INT_TIM2);
MOVW	R0, #44
BL	_NVIC_IntEnable+0
;Bluetooth_click.c,199 :: 		TIM2_DIER.UIE = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_DIER+0)
MOVT	R0, #hi_addr(TIM2_DIER+0)
_SX	[R0, ByteOffset(TIM2_DIER+0)]
;Bluetooth_click.c,200 :: 		TIM2_CR1.CEN = 1;
MOVW	R0, #lo_addr(TIM2_CR1+0)
MOVT	R0, #hi_addr(TIM2_CR1+0)
_SX	[R0, ByteOffset(TIM2_CR1+0)]
;Bluetooth_click.c,201 :: 		}
L_end_InitTimer2:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _InitTimer2
_Timer2_interrupt:
;Bluetooth_click.c,206 :: 		void Timer2_interrupt() iv IVT_INT_TIM2 {  // triggered/called each 1ms
;Bluetooth_click.c,207 :: 		TIM2_SR.UIF = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(TIM2_SR+0)
MOVT	R0, #hi_addr(TIM2_SR+0)
_SX	[R0, ByteOffset(TIM2_SR+0)]
;Bluetooth_click.c,210 :: 		ms_ctr++;
MOVW	R2, #lo_addr(_ms_ctr+0)
MOVT	R2, #hi_addr(_ms_ctr+0)
LDRSH	R0, [R2, #0]
ADDS	R1, R0, #1
SXTH	R1, R1
STRH	R1, [R2, #0]
;Bluetooth_click.c,211 :: 		if (ms_ctr <= duty_ms) // if passed milliseconds <= required duty cycle time
MOVW	R0, #lo_addr(_duty_ms+0)
MOVT	R0, #hi_addr(_duty_ms+0)
LDRSH	R0, [R0, #0]
CMP	R1, R0
IT	GT
BGT	L_Timer2_interrupt43
;Bluetooth_click.c,213 :: 		GPIOB_ODR |= 1 << 0; // keep on
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;Bluetooth_click.c,214 :: 		}
IT	AL
BAL	L_Timer2_interrupt44
L_Timer2_interrupt43:
;Bluetooth_click.c,217 :: 		GPIOB_ODR &= ~(1 << 0); // turn off
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R1, [R0, #0]
MVN	R0, #1
ANDS	R1, R0
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;Bluetooth_click.c,218 :: 		}
L_Timer2_interrupt44:
;Bluetooth_click.c,220 :: 		if (ms_ctr == 10) // period of each cycle = 10ms
MOVW	R0, #lo_addr(_ms_ctr+0)
MOVT	R0, #hi_addr(_ms_ctr+0)
LDRSH	R0, [R0, #0]
CMP	R0, #10
IT	NE
BNE	L_Timer2_interrupt45
;Bluetooth_click.c,222 :: 		ms_ctr = 0; // reset logic
MOVS	R1, #0
SXTH	R1, R1
MOVW	R0, #lo_addr(_ms_ctr+0)
MOVT	R0, #hi_addr(_ms_ctr+0)
STRH	R1, [R0, #0]
;Bluetooth_click.c,223 :: 		}
L_Timer2_interrupt45:
;Bluetooth_click.c,224 :: 		}
L_end_Timer2_interrupt:
BX	LR
; end of _Timer2_interrupt
_main:
;Bluetooth_click.c,229 :: 		void main() {
;Bluetooth_click.c,232 :: 		GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_0); // PWM on pin B0
MOVW	R1, #1
MOVW	R0, #lo_addr(GPIOB_BASE+0)
MOVT	R0, #hi_addr(GPIOB_BASE+0)
BL	_GPIO_Digital_Output+0
;Bluetooth_click.c,233 :: 		InitTimer2();
BL	_InitTimer2+0
;Bluetooth_click.c,236 :: 		ADC_Set_Input_Channel(_ADC_CHANNEL_3);
MOVW	R0, #8
BL	_ADC_Set_Input_Channel+0
;Bluetooth_click.c,237 :: 		ADC1_Init();
BL	_ADC1_Init+0
;Bluetooth_click.c,238 :: 		Delay_ms(100);
MOVW	R7, #9043
MOVT	R7, #8
NOP
NOP
L_main46:
SUBS	R7, R7, #1
BNE	L_main46
NOP
NOP
NOP
NOP
;Bluetooth_click.c,241 :: 		TFT_Init(320, 240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init+0
;Bluetooth_click.c,242 :: 		Start_TP();
BL	_Start_TP+0
;Bluetooth_click.c,243 :: 		DrawScr();
BL	_DrawScr+0
;Bluetooth_click.c,246 :: 		CMD_mode = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_CMD_mode+0)
MOVT	R0, #hi_addr(_CMD_mode+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,247 :: 		BT_state = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_BT_state+0)
MOVT	R0, #hi_addr(_BT_state+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,248 :: 		response_rcvd = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_response_rcvd+0)
MOVT	R0, #hi_addr(_response_rcvd+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,249 :: 		responseID = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_responseID+0)
MOVT	R0, #hi_addr(_responseID+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,250 :: 		response = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_response+0)
MOVT	R0, #hi_addr(_response+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,251 :: 		tmp = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_tmp+0)
MOVT	R0, #hi_addr(_tmp+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,252 :: 		DataReady = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_DataReady+0)
MOVT	R0, #hi_addr(_DataReady+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,254 :: 		UART3_Init_Advanced(115200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART3_PD89);
MOVW	R0, #lo_addr(__GPIO_MODULE_USART3_PD89+0)
MOVT	R0, #hi_addr(__GPIO_MODULE_USART3_PD89+0)
PUSH	(R0)
MOVW	R3, #0
MOVW	R2, #0
MOVW	R1, #0
MOV	R0, #115200
BL	_UART3_Init_Advanced+0
ADD	SP, SP, #4
;Bluetooth_click.c,255 :: 		Delay_ms(100);                // UART3 Init
MOVW	R7, #9043
MOVT	R7, #8
NOP
NOP
L_main48:
SUBS	R7, R7, #1
BNE	L_main48
NOP
NOP
NOP
NOP
;Bluetooth_click.c,257 :: 		USART3_CR1bits.RXNEIE = 1;       // enable uart rx interrupt
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(USART3_CR1bits+0)
MOVT	R0, #hi_addr(USART3_CR1bits+0)
_SX	[R0, ByteOffset(USART3_CR1bits+0)]
;Bluetooth_click.c,258 :: 		NVIC_IntEnable(IVT_INT_USART3);  // enable interrupt vector
MOVW	R0, #55
BL	_NVIC_IntEnable+0
;Bluetooth_click.c,259 :: 		Enableinterrupts();
BL	_EnableInterrupts+0
;Bluetooth_click.c,261 :: 		TFT_Write_Text("BlueTooth-Click!", 50, 50);
MOVW	R0, #lo_addr(?lstr4_Bluetooth_click+0)
MOVT	R0, #hi_addr(?lstr4_Bluetooth_click+0)
MOVS	R2, #50
MOVS	R1, #50
BL	_TFT_Write_Text+0
;Bluetooth_click.c,262 :: 		TFT_Write_Text("Demo example", 50, 70);
MOVW	R0, #lo_addr(?lstr5_Bluetooth_click+0)
MOVT	R0, #hi_addr(?lstr5_Bluetooth_click+0)
MOVS	R2, #70
MOVS	R1, #50
BL	_TFT_Write_Text+0
;Bluetooth_click.c,264 :: 		TFT_Write_Text("Awaiting Connection from master" , 50, 90);
MOVW	R0, #lo_addr(?lstr6_Bluetooth_click+0)
MOVT	R0, #hi_addr(?lstr6_Bluetooth_click+0)
MOVS	R2, #90
MOVS	R1, #50
BL	_TFT_Write_Text+0
;Bluetooth_click.c,265 :: 		TFT_Write_Text("Please, wait...", 50, 110);
MOVW	R0, #lo_addr(?lstr7_Bluetooth_click+0)
MOVT	R0, #hi_addr(?lstr7_Bluetooth_click+0)
MOVS	R2, #110
MOVS	R1, #50
BL	_TFT_Write_Text+0
;Bluetooth_click.c,266 :: 		Delay_ms(500);
MOVW	R7, #45225
MOVT	R7, #40
NOP
NOP
L_main50:
SUBS	R7, R7, #1
BNE	L_main50
NOP
NOP
;Bluetooth_click.c,269 :: 		BT_Configure();  // -------------------- change name of device here ---------------------------------- //
BL	_BT_Configure+0
;Bluetooth_click.c,272 :: 		while (BT_Get_Response() != BT_CONN);
L_main52:
BL	_BT_Get_Response+0
CMP	R0, #3
IT	EQ
BEQ	L_main53
IT	AL
BAL	L_main52
L_main53:
;Bluetooth_click.c,274 :: 		CMD_mode = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CMD_mode+0)
MOVT	R0, #hi_addr(_CMD_mode+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,276 :: 		Disableinterrupts();
BL	_DisableInterrupts+0
;Bluetooth_click.c,277 :: 		DataReady = 0;                // Data not received
MOVS	R1, #0
MOVW	R0, #lo_addr(_DataReady+0)
MOVT	R0, #hi_addr(_DataReady+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,279 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Bluetooth_click.c,280 :: 		TFT_Write_Text("Awaiting Connection from master" , 50, 90);
MOVW	R0, #lo_addr(?lstr8_Bluetooth_click+0)
MOVT	R0, #hi_addr(?lstr8_Bluetooth_click+0)
MOVS	R2, #90
MOVS	R1, #50
BL	_TFT_Write_Text+0
;Bluetooth_click.c,281 :: 		TFT_Write_Text("Please, wait...", 50, 110);
MOVW	R0, #lo_addr(?lstr9_Bluetooth_click+0)
MOVT	R0, #hi_addr(?lstr9_Bluetooth_click+0)
MOVS	R2, #110
MOVS	R1, #50
BL	_TFT_Write_Text+0
;Bluetooth_click.c,282 :: 		TFT_Set_Font(TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #0
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Bluetooth_click.c,283 :: 		TFT_Write_Text("Connected!", 50, 90);
MOVW	R0, #lo_addr(?lstr10_Bluetooth_click+0)
MOVT	R0, #hi_addr(?lstr10_Bluetooth_click+0)
MOVS	R2, #90
MOVS	R1, #50
BL	_TFT_Write_Text+0
;Bluetooth_click.c,285 :: 		UART3_Write_Text("Bluetooth Click Connected!");         //  Send message on connection
MOVW	R0, #lo_addr(?lstr11_Bluetooth_click+0)
MOVT	R0, #hi_addr(?lstr11_Bluetooth_click+0)
BL	_UART3_Write_Text+0
;Bluetooth_click.c,286 :: 		UART3_Write(13);              // CR
MOVS	R0, #13
BL	_UART3_Write+0
;Bluetooth_click.c,288 :: 		TFT_Set_Pen(CL_WHITE, 1);
MOVS	R1, #1
MOVW	R0, #65535
BL	_TFT_Set_Pen+0
;Bluetooth_click.c,289 :: 		TFT_Set_Brush(1, CL_WHITE, 0, 0, 0, 0);
MOVS	R1, #0
MOVS	R0, #0
PUSH	(R1)
PUSH	(R0)
MOVS	R3, #0
MOVS	R2, #0
MOVW	R1, #65535
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;Bluetooth_click.c,290 :: 		TFT_Rectangle(40, 48, 250, 110);
MOVS	R3, #110
SXTH	R3, R3
MOVS	R2, #250
SXTH	R2, R2
MOVS	R1, #48
SXTH	R1, R1
MOVS	R0, #40
SXTH	R0, R0
BL	_TFT_Rectangle+0
;Bluetooth_click.c,291 :: 		TFT_Write_Text("Received:", 50, 70);
MOVW	R0, #lo_addr(?lstr12_Bluetooth_click+0)
MOVT	R0, #hi_addr(?lstr12_Bluetooth_click+0)
MOVS	R2, #70
MOVS	R1, #50
BL	_TFT_Write_Text+0
;Bluetooth_click.c,293 :: 		while (1) {
L_main54:
;Bluetooth_click.c,294 :: 		i = 0;                      // Initialize counter
MOVS	R1, #0
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,296 :: 		memset(txt, 0, 16);         // Clear array of chars
MOVS	R2, #16
SXTH	R2, R2
MOVS	R1, #0
MOVW	R0, #lo_addr(_txt+0)
MOVT	R0, #hi_addr(_txt+0)
BL	_memset+0
;Bluetooth_click.c,297 :: 		EnableInterrupts();
BL	_EnableInterrupts+0
;Bluetooth_click.c,299 :: 		while (!DataReady)          // Wait while the data is received
L_main56:
MOVW	R0, #lo_addr(_DataReady+0)
MOVT	R0, #hi_addr(_DataReady+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main57
;Bluetooth_click.c,300 :: 		;
IT	AL
BAL	L_main56
L_main57:
;Bluetooth_click.c,302 :: 		Disableinterrupts();
BL	_DisableInterrupts+0
;Bluetooth_click.c,303 :: 		DataReady = 0;              // Data not received
MOVS	R1, #0
MOVW	R0, #lo_addr(_DataReady+0)
MOVT	R0, #hi_addr(_DataReady+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,305 :: 		i = 0;                      // Reset counter
MOVS	R1, #0
MOVW	R0, #lo_addr(_i+0)
MOVT	R0, #hi_addr(_i+0)
STRB	R1, [R0, #0]
;Bluetooth_click.c,307 :: 		TFT_Rectangle(0, 90, 320, 180);
MOVS	R3, #180
SXTH	R3, R3
MOVW	R2, #320
SXTH	R2, R2
MOVS	R1, #90
SXTH	R1, R1
MOVS	R0, #0
SXTH	R0, R0
BL	_TFT_Rectangle+0
;Bluetooth_click.c,308 :: 		TFT_Write_Text(txt+1, 50, 150);
MOVS	R2, #150
MOVS	R1, #50
MOVW	R0, #lo_addr(_txt+1)
MOVT	R0, #hi_addr(_txt+1)
BL	_TFT_Write_Text+0
;Bluetooth_click.c,319 :: 		if (strncmp(txt+1, "b0", 2) == 0) // if we received "b0" -> toggle LED B0
MOVW	R0, #lo_addr(?lstr13_Bluetooth_click+0)
MOVT	R0, #hi_addr(?lstr13_Bluetooth_click+0)
MOVS	R2, #2
MOV	R1, R0
MOVW	R0, #lo_addr(_txt+1)
MOVT	R0, #hi_addr(_txt+1)
BL	_strncmp+0
CMP	R0, #0
IT	NE
BNE	L_main58
;Bluetooth_click.c,321 :: 		GPIOB_ODR ^= 1 << 0;
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
LDR	R0, [R0, #0]
EOR	R1, R0, #1
MOVW	R0, #lo_addr(GPIOB_ODR+0)
MOVT	R0, #hi_addr(GPIOB_ODR+0)
STR	R1, [R0, #0]
;Bluetooth_click.c,322 :: 		}
IT	AL
BAL	L_main59
L_main58:
;Bluetooth_click.c,323 :: 		else if (strncmp(txt+1, "pwm", 3) == 0) // if we received "pwm" -> get duty cycle
MOVW	R0, #lo_addr(?lstr14_Bluetooth_click+0)
MOVT	R0, #hi_addr(?lstr14_Bluetooth_click+0)
MOVS	R2, #3
MOV	R1, R0
MOVW	R0, #lo_addr(_txt+1)
MOVT	R0, #hi_addr(_txt+1)
BL	_strncmp+0
CMP	R0, #0
IT	NE
BNE	L_main60
;Bluetooth_click.c,325 :: 		duty_ms = txt[4] - '0'; // 5th char after "pwm" is the duty cycle
MOVW	R0, #lo_addr(_txt+4)
MOVT	R0, #hi_addr(_txt+4)
LDRB	R0, [R0, #0]
SUBW	R1, R0, #48
MOVW	R0, #lo_addr(_duty_ms+0)
MOVT	R0, #hi_addr(_duty_ms+0)
STRH	R1, [R0, #0]
;Bluetooth_click.c,326 :: 		}
IT	AL
BAL	L_main61
L_main60:
;Bluetooth_click.c,327 :: 		else if (strncmp(txt+1, "pot", 3) == 0) // if we received "pot" -> display potentiometer value on LCD
MOVW	R0, #lo_addr(?lstr15_Bluetooth_click+0)
MOVT	R0, #hi_addr(?lstr15_Bluetooth_click+0)
MOVS	R2, #3
MOV	R1, R0
MOVW	R0, #lo_addr(_txt+1)
MOVT	R0, #hi_addr(_txt+1)
BL	_strncmp+0
CMP	R0, #0
IT	NE
BNE	L_main62
;Bluetooth_click.c,329 :: 		adc_val = ADC1_Read(3);
MOVS	R0, #3
BL	_ADC1_Read+0
MOVW	R1, #lo_addr(_adc_val+0)
MOVT	R1, #hi_addr(_adc_val+0)
STRH	R0, [R1, #0]
;Bluetooth_click.c,330 :: 		IntToStr(adc_val, txt_adc);
SXTH	R0, R0
MOVW	R1, #lo_addr(_txt_adc+0)
MOVT	R1, #hi_addr(_txt_adc+0)
BL	_IntToStr+0
;Bluetooth_click.c,331 :: 		TFT_Rectangle(20, 150, 320, 180);
MOVS	R3, #180
SXTH	R3, R3
MOVW	R2, #320
SXTH	R2, R2
MOVS	R1, #150
SXTH	R1, R1
MOVS	R0, #20
SXTH	R0, R0
BL	_TFT_Rectangle+0
;Bluetooth_click.c,332 :: 		TFT_Write_Text(txt_adc, 50, 180);
MOVS	R2, #180
MOVS	R1, #50
MOVW	R0, #lo_addr(_txt_adc+0)
MOVT	R0, #hi_addr(_txt_adc+0)
BL	_TFT_Write_Text+0
;Bluetooth_click.c,333 :: 		}
L_main62:
L_main61:
L_main59:
;Bluetooth_click.c,335 :: 		}
IT	AL
BAL	L_main54
;Bluetooth_click.c,336 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
