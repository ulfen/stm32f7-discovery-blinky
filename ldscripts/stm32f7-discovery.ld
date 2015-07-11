/*
 * STM32F7 discovery memory map - GNU ld linker script file
 */

MEMORY
{
    FLASH        :   ORIGIN = 0x08000000, LENGTH = 1024K
    RAM          :   ORIGIN = 0x20000000, LENGTH = 320K
    CCMRAM       :   ORIGIN = 0xFFFF0000, LENGTH = 0K
    FLASHB1      :   ORIGIN = 0xFFFF0000, LENGTH = 0K
    EXTMEMB0     :   ORIGIN = 0xFFFF0000, LENGTH = 0K
    EXTMEMB1     :   ORIGIN = 0xFFFF0000, LENGTH = 0K
    EXTMEMB2     :   ORIGIN = 0xFFFF0000, LENGTH = 0K
    EXTMEMB3     :   ORIGIN = 0xFFFf0000, LENGTH = 0K
}

/* Include main link script. Note: it will be searched in -L paths. */
INCLUDE sections.ld
