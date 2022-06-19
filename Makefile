include config.mk

C_OBJS= out/vga.o \
				out/kernel.o \
				out/printing.o 
ASM_OBJS= out/boot.o

CFLAGS=-std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./kernel/include

all: emperor.bin

emperor.bin: ${ASM_OBJS} ${C_OBJS}
	i686-elf-gcc -T kernel/linker.ld -o emperor.bin -ffreestanding -O2 -nostdlib ${C_OBJS} ${ASM_OBJS} -lgcc

out/boot.o: 
	i686-elf-as kernel/boot.s -o out/boot.o

out/vga.o:
	i686-elf-gcc -c ./kernel/src/screen/vga.c -o $@ ${CFLAGS} 
out/kernel.o:
	i686-elf-gcc -c ./kernel/src/kernel.c -o $@ ${CFLAGS} 
out/printing.o:
	i686-elf-gcc -c ./kernel/src/screen/printing.c -o $@ ${CFLAGS} 

#out/%.o: kernel/src/%.c 
#	i686-elf-gcc -c $< -o $@ ${CFLAGS} 

clean:
	rm ${C_OBJS}
	rm ${ASM_OBJS}
	rm emperor.bin

test:
	qemu-system-x86_64 -kernel emperor.bin

test_full:
	dd if=/dev/zero of=test.img bs=1024 count=0 seek=1024

