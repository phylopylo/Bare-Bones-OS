build/:
	mkdir build

build/boot.o: build/
	i686-elf-as boot.s -o build/boot.o

build/kernel.o: build/
	i686-elf-gcc -c kernel.c -o build/kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

build/myos: build/boot.o build/kernel.o
	i686-elf-gcc -T linker.ld -o build/myos -ffreestanding -O2 -nostdlib build/boot.o build/kernel.o -lgcc

validate-myos:
	grub-file --is-x86-multiboot myos
.PHONY: validate-myos
