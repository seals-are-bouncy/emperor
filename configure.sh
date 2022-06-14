#!/bin/env sh

# Seals are Bouncy custom kernel development ./configure.sh script
# NOTE: This is not a real configure.sh script, this project does not use makefiles

# TODO: Handle flags.

CFLAGS="-std=gnu99 -ffreestanding -O2 -Wall -Wextra"

if [ -e "build.sh" ]; then
echo "You already have a build.sh script, if you want to regenerate it you have to remove it."
else
cat > build.sh << EOF
#!/bin/env sh
echo "AS kernel/boot.s"
i686-elf-as kernel/boot.s -o out/boot.o
echo "GCC kernel/kernel.c"
i686-elf-gcc -c kernel/kernel.c -o out/kernel.o $CFLAGS
echo "Linking binary"
i686-elf-gcc -T kernel/linker.ld -o emperor.bin -ffreestanding -O2 -nostdlib out/boot.o out/kernel.o -lgcc
EOF
chmod +x build.sh
echo "A build.sh script has been generated!"
fi

if [ -e "test.sh" ]; then
echo "You already have a test.sh script, if you want to regenerate it you have to remove it."
else
cat > test.sh << EOF
#!/bin/env sh
echo "Starting QEMU"
qemu-system-x86_64 --kernel emperor.bin
EOF
chmod +x test.sh
echo "A test.sh script has been generated!"
fi
