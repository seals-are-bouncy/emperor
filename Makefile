all: out/boot.bin

out/boot.bin:
	@${MAKE} -C bootloader

clean:
	@${MAKE} -C bootloader clean


test:
	qemu-system-x86_64 -fda ./out/boot.bin