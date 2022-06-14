all: out/emperor.bin 

CFLAGS=-std=gnu99 -ffreestanding -O2 -Wall -Wextra

out/emperor.bin: out/boot.o out/kernel.o
	i686-elf-gcc -T kernel/linker.ld -o emperor.bin -ffreestanding -O2 -nostdlib out/boot.o out/kernel.o -lgcc

out/boot.o:
	i686-elf-as kernel/boot.s -o out/boot.o

out/kernel.o:
	i686-elf-gcc -c kernel/kernel.c -o out/kernel.o ${CFLAGS}


