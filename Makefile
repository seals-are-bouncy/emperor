include config.mk

C_OBJS= out/vga.o \
				out/kernel.o
ASM_OBJS= out/boot.o

CFLAGS=-std=gnu99 -ffreestanding -O2 -Wall -Wextra

all: emperor.bin

emperor.bin: ${ASM_OBJS} ${C_OBJS}
	i686-elf-gcc -T kernel/linker.ld -o emperor.bin -ffreestanding -O2 -nostdlib ${C_OBJS} ${ASM_OBJS} -lgcc

out/boot.o: 
	i686-elf-as kernel/boot.s -o out/boot.o

out/%.o: kernel/%.c 
	i686-elf-gcc -c $< -o $@ ${CFLAGS} 

clean:
	rm ${C_OBJS}
	rm ${ASM_OBJS}
	rm emperor.bin

test:
	qemu-system-x86_64 -kernel emperor.bin
