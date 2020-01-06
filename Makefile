CROSS_COMPILE_PATH ?= "C:\Program Files (x86)\GNU Tools Arm Embedded\9 2019-q4-major\bin"
COMPILER_PREFIX ?=arm-none-eabi

OUTPUT_FILE = hello_world

AOPS = --warn --fatal-warnings -mcpu=arm926ej-s
COPS = -Wall -O2 -nostdlib -nostartfiles -ffreestanding -c -g


all: compile link

link:
	$(CROSS_COMPILE_PATH)/$(COMPILER_PREFIX)-ld startup.o util.o -T memmap -o $(OUTPUT_FILE).elf
	$(CROSS_COMPILE_PATH)/$(COMPILER_PREFIX)-objdump -D $(OUTPUT_FILE).elf > $(OUTPUT_FILE).list
	$(CROSS_COMPILE_PATH)/$(COMPILER_PREFIX)-objcopy $(OUTPUT_FILE).elf -O binary $(OUTPUT_FILE).bin

compile:startup.s util.c memmap
	$(CROSS_COMPILE_PATH)/$(COMPILER_PREFIX)-as  $(AOPS) startup.s -o startup.o
	$(CROSS_COMPILE_PATH)/$(COMPILER_PREFIX)-gcc $(COPS) util.c -o util.o

clean:
	rm *.elf *.list *.bin *.o
