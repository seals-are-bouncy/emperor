echo "AS kernel/boot.s"
i686-elf-as kernel/boot.s -o out/boot.o
echo "GCC kernel/kernel.c"
i686-elf-gcc -c kernel/kernel.c -o out/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
echo "Linking binary"
i686-elf-gcc -T kernel/linker.ld -o emperor.bin -ffreestanding -O2 -nostdlib out/boot.o out/kernel.o -lgcc
