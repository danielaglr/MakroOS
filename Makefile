ASM=nasm

SRC_DIR = makroOS
BUILD_DIR = build

.PHONY: all floppy_image kernel bootloader clean always

# Floppy Image
floppy_image: ${BUILD_DIR}/makro_floppy.img

$(BUILD_DIR)/makro_floppy.img: bootloader kernel
	dd if=/dev/zero of=$(BUILD_DIR)/makro_floppy.img bs=512 count=2880
	mkfs.fat -F 12 -n "NBOS" $(BUILD_DIR)/makro_floppy.img
	dd if=${BUILD_DIR}/bootloader.bin of=$(BUILD_DIR)/makro_floppy.img conv=notrunc
	mcopy -i $(BUILD_DIR)/makro_floppy.img ${BUILD_DIR}/kernel.bin "::kernel.bin"

# Bootloader
bootloader: ${BUILD_DIR}/bootloader.bin

${BUILD_DIR}/bootloader.bin: always
	${ASM} ${SRC_DIR}/bootloader/boot.asm -f bin -o ${BUILD_DIR}/bootloader.bin

# Kernel
kernel: ${BUILD_DIR}/kernel.bin

${BUILD_DIR}/kernel.bin: always
	${ASM} ${SRC_DIR}/kernel/makro.asm -f bin -o ${BUILD_DIR}/kernel.bin

always:
	mkdir -p ${BUILD_DIR}

clean:
	rm -rf ${BUILD_DIR}/*