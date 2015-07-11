# Makefile for STM32F7-Discovery-Blinky

PROJECT = blinky

################
# Sources

SOURCES_S = Drivers/CMSIS/Device/ST/STM32F7xx/Source/Templates/gcc/startup_stm32f746xx.s

SOURCES_C = src/main.c
SOURCES_C += sys/stubs.c sys/_sbrk.c sys/_io.c
SOURCES_C += Drivers/CMSIS/Device/ST/STM32F7xx/Source/Templates/system_stm32f7xx.c
SOURCES_C += Drivers/BSP/STM32746G-Discovery/stm32746g_discovery.c
SOURCES_C += Drivers/STM32F7xx_HAL_Driver/Src/stm32f7xx_hal_gpio.c

SOURCES_CPP =

SOURCES = $(SOURCES_S) $(SOURCES_C) $(SOURCES_CPP)
OBJS = $(SOURCES_S:.s=.o) $(SOURCES_C:.c=.o) $(SOURCES_CPP:.cpp=.o)

################
# Includes and Defines

INCLUDES += -I . -I src -I sys
INCLUDES += -I Drivers/CMSIS/Include
INCLUDES += -I Drivers/CMSIS/Device/ST/STM32F7xx/Include
INCLUDES += -I Drivers/STM32F7xx_HAL_Driver/Inc
INCLUDES += -I Drivers/BSP/STM32746G-Discovery

DEFINES = -DSTM32 -DSTM32F7 -DSTM32F746xx -DSTM32F746NGHx -DSTM32F746G_DISCO

################
# Compiler/Assembler/Linker/etc

PREFIX = arm-none-eabi

CC = $(PREFIX)-gcc
AS = $(PREFIX)-as
AR = $(PREFIX)-ar
LD = $(PREFIX)-gcc
NM = $(PREFIX)-nm
OBJCOPY = $(PREFIX)-objcopy
OBJDUMP = $(PREFIX)-objdump
READELF = $(PREFIX)-readelf
SIZE = $(PREFIX)-size
GDB = $(PREFIX)-gdb
RM = rm -f

################
# Compiler options

MCUFLAGS = -mcpu=cortex-m7 -mlittle-endian
MCUFLAGS += -mfloat-abi=hard -mfpu=fpv5-sp-d16
MCUFLAGS += -mthumb

DEBUGFLAGS = -O0 -g -gdwarf-2
#DEBUGFLAGS = -O2

CFLAGS = -std=c11
CFLAGS += -Wall -Wextra --pedantic

CFLAGS_EXTRA = -nostartfiles -fdata-sections -ffunction-sections
CFLAGS_EXTRA += -Wl,--gc-sections -Wl,-Map=$(PROJECT).map

CFLAGS += $(DEFINES) $(MCUFLAGS) $(DEBUG_FLAGS) $(CFLAGS_EXTRA) $(INCLUDES)

LDFLAGS = -static $(MCUFLAGS)
LDFLAGS += -Wl,--start-group -lgcc -lm -lc -lg -lstdc++ -lsupc++ -Wl,--end-group
LDFLAGS += -Wl,--gc-sections
LDFLAGS += -T stm32f7-discovery.ld -L. -Lldscripts
LDFLAGS += -Xlinker -Map -Xlinker $(PROJECT).map

################
# Build rules

all: $(PROJECT).hex

$(PROJECT).hex: $(PROJECT).elf
	$(OBJCOPY) -O ihex $(PROJECT).elf $(PROJECT).hex

$(PROJECT).elf: $(OBJS)
	$(LD) $(OBJS) $(LDFLAGS) -o $(PROJECT).elf
	$(SIZE) -A $(PROJECT).elf

clean:
	$(RM) $(OBJS) $(PROJECT).elf $(PROJECT).hex $(PROJECT).map

# EOF
