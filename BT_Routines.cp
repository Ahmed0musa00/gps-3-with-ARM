#line 1 "E:/gps 3/Bluetooth_App/BT_Routines.c"


extern const BT_CMD;
extern const BT_AOK;
extern const BT_CONN;
extern const BT_END;
extern char BT_Get_Response();

void BT_Configure() {

 do {
 UART3_Write_Text("$$$");
 Delay_ms(500);
 } while (BT_Get_Response() != BT_CMD);

 do {
 UART3_Write_Text("SN,GEKO");
 UART3_Write(13);
 Delay_ms(500);
 } while (BT_Get_Response() != BT_AOK);

 do {
 UART3_Write_Text("SO,Slave");
 UART3_Write(13);
 Delay_ms(500);
 } while (BT_Get_Response() != BT_AOK);

 do {
 UART3_Write_Text("SM,0");
 UART3_Write(13);
 Delay_ms(500);
 } while (BT_Get_Response() != BT_AOK);

 do {
 UART3_Write_Text("SA,1");
 UART3_Write(13);
 Delay_ms(500);
 } while (BT_Get_Response() != BT_AOK);

 do {
 UART3_Write_Text("SP,1234");
 UART3_Write(13);
 Delay_ms(500);
 } while (BT_Get_Response() != BT_AOK);

 do {
 UART3_Write_Text("---");
 UART3_Write(13);
 Delay_ms(500);
 } while (BT_Get_Response() != BT_END);
}
