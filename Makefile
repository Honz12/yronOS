CPU=yron
SRC_DIR=src
BUILD_DIR=build

#
# ROM
#

$(BUILD_DIR)/rom.bin: $(BUILD_DIR)/rom.yrl
	$(CPU) build $(BUILD_DIR)/rom.yrl $(BUILD_DIR)/rom.bin

$(BUILD_DIR)/rom.yrl: $(BUILD_DIR)/main.yrl $(BUILD_DIR)/stdlib.yrl
	$(CPU) link $(BUILD_DIR)/main.yrl $(BUILD_DIR)/stdlib.yrl -o $(BUILD_DIR)/rom.yrl

#
# STDLIB
#

$(BUILD_DIR)/stdlib.yrl: $(SRC_DIR)/stdlib/.yrn
	$(CPU) asm $(SRC_DIR)/stdlib/.yrn $(BUILD_DIR)/stdlib.yrl -l

#
# MAIN
#

$(BUILD_DIR)/main.yrl: $(SRC_DIR)/main.yrn $(BUILD_DIR)
	$(CPU) asm $(SRC_DIR)/main.yrn $(BUILD_DIR)/main.yrl -l

$(BUILD_DIR):
	mkdir $(BUILD_DIR)

clean:
	rmdir $(BUILD_DIR) /S /Q
