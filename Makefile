# 输出文件
TARGET=mspled
# 源文件
OBJECTS=source.o

# MSP GCC 编译器
GCC_DIR = /home/wenchi/Downloads/msp430-gcc-8.3.1.25_linux64/bin
# 头文件
SUPPORT_FILE_DIRECTORY = /home/wenchi/Downloads/msp430-gcc-support-files/include

# 设备相关设置
DEVICE = msp430g2553
CC = $(GCC_DIR)/msp430-elf-gcc
GDB = $(GCC_DIR)/msp430-elf-gdb
OBJCOPY = $(GCC_DIR)/msp430-elf-objcopy


CFLAGS = -I $(SUPPORT_FILE_DIRECTORY) -mmcu=$(DEVICE) -O2 -g
LFLAGS = -L $(SUPPORT_FILE_DIRECTORY) -T $(DEVICE).ld

all: ${OBJECTS}
	$(CC) $(CFLAGS) $(LFLAGS) $? -o $(TARGET).elf
	$(OBJCOPY) -O ihex $(TARGET).elf $(TARGET).hex
debug: all
	$(GDB) $(DEVICE).elf
upload: all
	# $(FLASHER) -h
	sudo mspdebug rf2500 "prog $(TARGET).hex"
clean:
	-rm *.elf
	-rm *.hex
	-rm *.o

.PHONY: clean
