BUILD_DIR = build
SRC_DIR = src
PROJ_NAME = cpu

all: gtkwave

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)/ io_signals.vcd && mkdir $(BUILD_DIR)/

simulate:
	iverilog -o $(BUILD_DIR)/$(PROJ_NAME).vvp $(SRC_DIR)/$(PROJ_NAME).v $(SRC_DIR)/$(PROJ_NAME)_tb.v
	vvp $(BUILD_DIR)/$(PROJ_NAME).vvp > $(BUILD_DIR)/$(PROJ_NAME)_logs.txt

gtkwave: simulate
	open $(BUILD_DIR)/io_signals.vcd -a gtkwave