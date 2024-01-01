ASM=nasm

SRC_DIR = makroOS
BUILD_DIR = build

$(BUILD_DIR)/makro_floppy.img : $(BUILD_DIR)/makro.bin
	cp $(BUILD_DIR)/makro.bin $(BUILD_DIR)/makro_floppy.img
	truncate -s 1440k $(BUILD_DIR)/makro_floppy.img

$(BUILD_DIR)/makro.bin: ${SRC_DIR}/makro.asm
	${ASM} ${SRC_DIR}/makro.asm -f bin -o ${BUILD_DIR}/makro.bin