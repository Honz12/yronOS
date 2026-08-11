CPU=yron
SRC_DIR=src
BUILD_DIR=build

$(BUILD_DIR)/rom.bin: $(BUILD_DIR)/main.yrl
	$(CPU) build $(BUILD_DIR)/main.yrl $(BUILD_DIR)/rom.bin

$(BUILD_DIR)/main.yrl: $(SRC_DIR)/main.yrn $(BUILD_DIR)
	$(CPU) asm $(SRC_DIR)/main.yrn $(BUILD_DIR)/main.yrl -l

$(BUILD_DIR):
	mkdir $(BUILD_DIR)
