SRC_DIR=src
BUILD_DIR=build
TOOLS_DIR=tools
CPU=$(TOOLS_DIR)/yron/bin/Release/net10.0/win-x64/publish/yron.exe

#
# .PHONY
#

.PHONY: clean tools rmtools

#
# ROM
#

$(BUILD_DIR)/rom.bin: $(BUILD_DIR)/rom.yrl $(CPU)
	$(CPU) build $(BUILD_DIR)/rom.yrl $(BUILD_DIR)/rom.bin

$(BUILD_DIR)/rom.yrl: $(BUILD_DIR)/main.yrl $(BUILD_DIR)/stdlib.yrl $(CPU)
	$(CPU) link $(BUILD_DIR)/main.yrl $(BUILD_DIR)/stdlib.yrl -o $(BUILD_DIR)/rom.yrl

#
# STDLIB
#

$(BUILD_DIR)/stdlib.yrl: $(SRC_DIR)/stdlib/.yrn $(CPU)
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

#
# Toolchain
#

tools: $(TOOLS_DIR)/yron/yron.exe run.bat
rmtools:
	rmdir $(TOOLS_DIR) /S /Q
	del run.bat

$(TOOLS_DIR)/yron/yron.exe: $(TOOLS_DIR)/yron

$(TOOLS_DIR)/yron: $(TOOLS_DIR)
	git clone -o upstream https://github.com/Honz12/yron-cpu.git tools/yron
	cd $(TOOLS_DIR)/yron && build_win_tool.bat

run.bat:
	echo .\tools\yron\bin\Release\net10.0\win-x64\publish\yron.exe sim yconf.json > run.bat
