/*
  Name:
  Copyright:
  Author:
  Date:
  Description:
*/
#include <msp430.h>

int main(void)
{
  WDTCTL = WDTPW + WDTHOLD; // Stop watchdog timer
  int a = 0;
  P1DIR |= BIT0 | BIT6 | BIT4;
  while (1)
  {
    if (a == 0)
    {
      a = 1;
      P1OUT |= BIT0;
      P1OUT &= ~BIT4;
    }
    else if (a == 1)
    {
      a = 2;
      P1OUT |= BIT6;
      P1OUT &= ~BIT0;
    }
    else
    {
      a = 0;
      P1OUT |= BIT4;
      P1OUT &= ~BIT6;
    }
    long int i = 32768;
    while (i--)
      ;
  }
}
