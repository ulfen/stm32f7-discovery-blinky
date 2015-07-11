
#include "stm32746g_discovery.h"

volatile int32_t ITM_RxBuffer;

int __io_putchar(int ch)
{
    return ITM_SendChar(ch);
}

int __io_getchar(void)
{
    return ITM_ReceiveChar();
}
