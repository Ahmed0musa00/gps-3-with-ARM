  //  Configure BlueTooth-Click module
// responses to parse
extern const BT_CMD;
extern const BT_AOK;
extern const BT_CONN;
extern const BT_END;
extern char BT_Get_Response();

void  BT_Configure() {

  do {
    UART3_Write_Text("$$$");                  // Enter command mode
    Delay_ms(500);
  } while (BT_Get_Response() != BT_CMD);

  do {
    UART3_Write_Text("SN,GEKO");   // Name of device
    UART3_Write(13);                          // CR
    Delay_ms(500);
  } while (BT_Get_Response() != BT_AOK);

   do {
    UART3_Write_Text("SO,Slave");             // Extended status string
    UART3_Write(13);                          // CR
    Delay_ms(500);
  } while (BT_Get_Response() != BT_AOK);

  do {
    UART3_Write_Text("SM,0");                 // Set mode (0 = slave, 1 = master, 2 = trigger, 3 = auto, 4 = DTR, 5 = ANY)
    UART3_Write(13);                          // CR
    Delay_ms(500);
  } while (BT_Get_Response() != BT_AOK);

  do {
    UART3_Write_Text("SA,1");                 // Authentication (1 to enable, 0 to disable)
    UART3_Write(13);                          // CR
    Delay_ms(500);
  } while (BT_Get_Response() != BT_AOK);

  do {
    UART3_Write_Text("SP,1234");              // Security pin code (mikroe)
    UART3_Write(13);                          // CR
    Delay_ms(500);
  } while (BT_Get_Response() != BT_AOK);

  do {
    UART3_Write_Text("---");                  // Security pin code (mikroe)
    UART3_Write(13);                          // CR
    Delay_ms(500);
  } while (BT_Get_Response() != BT_END);
}