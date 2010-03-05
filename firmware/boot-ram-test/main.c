/**
 * Primitive ram tester
 *
 *
 */
#include "soc-hw.h"

#define     TEST_SIZE           0x1000
#define     TEST_STARTADDRESS   0x40000000
#define     TEST_PATTERN        0x41424142

int main(int argc, char **argv)
{
    // Initialize UART
	uart_init();
	
	uart_putstr("Writing testpattern...\r\n");
    uint32_t* p = (uint32_t*)TEST_STARTADDRESS;
    for(int i = 0; i < 0x1000/sizeof(uint32_t); i++)
    {
        *p = TEST_PATTERN;
        p++;
	}
	
	uart_putstr("Dumping testpattern...\r\n");
	uint8_t* q = (uint8_t*)TEST_STARTADDRESS;
    for(int i = 0; i < 0x1000; i++)
    {
        uart_putchar( *q );
        q++;
    }
    uart_putstr("\r\ndone!\r\n");
}

