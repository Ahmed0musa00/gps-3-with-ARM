
#include "BT_Routines.h"
#include "resources.h"
#include "TFT_objects.h"

// responses to parse
const BT_CMD  = 1;
const BT_AOK  = 2;
const BT_CONN = 3;
const BT_END  = 4;

char txt[60];
unsigned short i, tmp, DataReady;
char CMD_mode;

char BT_state;
char response_rcvd;
char responseID, response = 0;

/**************************************************************************************************
* Draw Screen
**************************************************************************************************/
void DrawScr(){
  TFT_Fill_Screen(CL_WHITE);
  TFT_Set_Pen(CL_Black, 1);
  TFT_Line(20, 220, 300, 220);
  TFT_LIne(20,  46, 300,  46);
  TFT_Set_Font(&HandelGothic_BT21x22_Regular, CL_RED, FO_HORIZONTAL);
  TFT_Write_Text("Bluetooth  TEST", 75, 14);
  TFT_Set_Font(&Verdana12x13_Regular, CL_BLACK, FO_HORIZONTAL);
  TFT_Write_Text("EasyMX PRO v7", 19, 223);
  TFT_Set_Font(&Verdana12x13_Regular, CL_RED, FO_HORIZONTAL);
  TFT_Write_Text("www.mikroe.com", 200, 223);
  TFT_Set_Font(&TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
}

/**************************************************************************************************
* Interrupt Service routine
**************************************************************************************************/
void interrupt() iv IVT_INT_USART3 ics ICS_AUTO{
    tmp = UART3_Read();                          // Get received byte

  if (CMD_mode){

    /* The responses expected from the EasyBT module:
    CMD
    AOK
    AOK
    AOK
    AOK
    AOK
    END
    SlaveCONNECTmikroE
    EasyBlueTooth
    mikroE ...
    EasyBlueTooth*/

    // Process reception through state machine
    // We are parsing CMD<cr><lf>, AOK<cr><lf>, CONN<cr> and END<cr><lf> responses
    switch (BT_state) {
      case  0: {
                response = 0;                   // Clear response
                if (tmp == 'C')                 // We have 'C', it could be CMD<cr><lf>  or CONN
                  BT_state = 1;                 // Expecting 'M' or 'N'
                if (tmp == 'A')                 // We have 'A', it could be AOK<cr><lf>
                  BT_state = 11;                // expecting 'O'
                if (tmp == 'E')                 // We have 'E', it could be END<cr><lf>
                  BT_state = 31;                // expecting 'N'
                break;                          // ...
      }

      case  1: {
                if (tmp == 'M')
                  BT_state = 2;
                else if (tmp == 'O')
                  BT_state = 22;
                else
                  BT_state = 0;
                break;
      }

      case  2: {
                if (tmp == 'D') {
                  response = BT_CMD;           // CMD
                  BT_state = 40;
                }
                else
                  BT_state = 0;
                break;
      }

      case 11: {
                if (tmp == 'O')
                  BT_state = 12;
                else
                  BT_state = 0;
                break;
      }

      case 12: {
                if (tmp == 'K'){
                  response = BT_AOK;            // AOK
                  BT_state = 40;
                }
                else
                  BT_state = 0;
                break;
      }

      case 22: {
                if (tmp == 'N')
                  BT_state = 23;
                else
                  BT_state = 0;
                break;
      }

      case 23: {
                if (tmp == 'N') {
                  response = BT_CONN;           // SlaveCONNECTmikroE
                  response_rcvd = 1;
                  responseID = response;
                }
                BT_state = 0;
                break;
      }

      case 31: {
                if (tmp == 'N')
                  BT_state = 32;
                else
                  BT_state = 0;
                break;
      }

      case 32: {
                if (tmp == 'D') {
                  response = BT_END;           // END
                  BT_state = 40;
                }
                else
                  BT_state = 0;
                break;
      }

      case 40: {
                if (tmp == 13)
                  BT_state = 41;
                else
                  BT_state = 0;
                break;
      }

      case 41: {
                if (tmp == 10){
                  response_rcvd = 1;
                  responseID = response;
                }
                BT_state = 0;
                break;
      }

      default: {
                BT_state = 0;
                break;
      }
    }
  }
  else {
    if (tmp == 13) {
      txt[i] = 0;                            // Puting 0 at the end of the string
      DataReady = 1;                         // Data is received
    }
    else {
      txt[i] = tmp;                          // Moving the data received from UART to string txt[]
      i++;                                   // Increment counter
    }
  }
}

// Get BlueTooth response, if there is any
char BT_Get_Response() {
  if (response_rcvd) {
    response_rcvd = 0;
    return responseID;
  }
  else
    return 0;
}


//Place/Copy this part in declaration section
void InitTimer2(){
  RCC_APB1ENR.TIM2EN = 1;
  TIM2_CR1.CEN = 0;
  TIM2_PSC = 0;
  TIM2_ARR = 15999;
  NVIC_IntEnable(IVT_INT_TIM2);
  TIM2_DIER.UIE = 1;
  TIM2_CR1.CEN = 1;
}

int ms_ctr = 0;
int duty_ms = 1;

void Timer2_interrupt() iv IVT_INT_TIM2 {  // triggered/called each 1ms
  TIM2_SR.UIF = 0;

  //Enter your code here
  ms_ctr++;
  if (ms_ctr <= duty_ms) // if passed milliseconds <= required duty cycle time
  {
     GPIOB_ODR |= 1 << 0; // keep on
  }
  else               // if passed milliseconds > required duty cycle time
  {
     GPIOB_ODR &= ~(1 << 0); // turn off
  }
  
  if (ms_ctr == 10) // period of each cycle = 10ms
  {
     ms_ctr = 0; // reset logic
  }
}

int adc_val = 0;
char txt_adc[7];

void main() {

  // init LED B0 and timer for PWM
  GPIO_Digital_Output(&GPIOB_BASE, _GPIO_PINMASK_0); // PWM on pin B0
  InitTimer2();
  
  // init ADC
  ADC_Set_Input_Channel(_ADC_CHANNEL_3);
  ADC1_Init();
  Delay_ms(100);

  // init TFT
  TFT_Init(320, 240);
  Start_TP();
  DrawScr();
  
  // Initialize variables
  CMD_mode = 1;
  BT_state = 0;
  response_rcvd = 0;
  responseID = 0;
  response = 0;
  tmp = 0;
  DataReady = 0;

  UART3_Init_Advanced(115200, _UART_8_BIT_DATA, _UART_NOPARITY, _UART_ONE_STOPBIT, &_GPIO_MODULE_USART3_PD89);
  Delay_ms(100);                // UART3 Init

  USART3_CR1bits.RXNEIE = 1;       // enable uart rx interrupt
  NVIC_IntEnable(IVT_INT_USART3);  // enable interrupt vector
  Enableinterrupts();

  TFT_Write_Text("BlueTooth-Click!", 50, 50);
  TFT_Write_Text("Demo example", 50, 70);
  
  TFT_Write_Text("Awaiting Connection from master" , 50, 90);
  TFT_Write_Text("Please, wait...", 50, 110);
  Delay_ms(500);
 
  // Configure BlueTooth-Click module
  BT_Configure();  // -------------------- change name of device here ---------------------------------- //

  //  Wait until connected
  while (BT_Get_Response() != BT_CONN);

  CMD_mode = 0;  

  Disableinterrupts();
  DataReady = 0;                // Data not received

  TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
  TFT_Write_Text("Awaiting Connection from master" , 50, 90);
  TFT_Write_Text("Please, wait...", 50, 110);
  TFT_Set_Font(TFT_defaultFont, CL_BLACK, FO_HORIZONTAL);
  TFT_Write_Text("Connected!", 50, 90);
  
  UART3_Write_Text("Bluetooth Click Connected!");         //  Send message on connection
  UART3_Write(13);              // CR
  
  TFT_Set_Pen(CL_WHITE, 1);
  TFT_Set_Brush(1, CL_WHITE, 0, 0, 0, 0);
  TFT_Rectangle(40, 48, 250, 110);
  TFT_Write_Text("Received:", 50, 70);

  while (1) {
    i = 0;                      // Initialize counter
    
    memset(txt, 0, 16);         // Clear array of chars
    EnableInterrupts();

    while (!DataReady)          // Wait while the data is received
      ;

    Disableinterrupts();
    DataReady = 0;              // Data not received

    i = 0;                      // Reset counter

    TFT_Rectangle(0, 90, 320, 180);
    TFT_Write_Text(txt+1, 50, 150);

    // *************************************************************************************
    // *** *** *** NOTE: we use (i+1) because Android app sends additional '\n' *** *** ***
    // *** *** *** NOTE: use Android app "Bluetooth Terminal" by QWERTY
    // *************************************************************************************

    // --------------------------------------------------------------
    // --------------------- put your code here ---------------------
    // --------------------------------------------------------------
  
    if (strncmp(txt+1, "b0", 2) == 0) // if we received "b0" -> toggle LED B0
    {
      GPIOB_ODR ^= 1 << 0;
    }
    else if (strncmp(txt+1, "pwm", 3) == 0) // if we received "pwm" -> get duty cycle
    { // ex: "pwm8" -> 80% duty cycle
      duty_ms = txt[4] - '0'; // 5th char after "pwm" is the duty cycle
    }
    else if (strncmp(txt+1, "pot", 3) == 0) // if we received "pot" -> display potentiometer value on LCD
    {
      adc_val = ADC1_Read(3);
      IntToStr(adc_val, txt_adc);
      TFT_Rectangle(20, 150, 320, 180);
      TFT_Write_Text(txt_adc, 50, 180);
    }
    
  }
}
