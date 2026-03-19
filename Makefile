# Default chip target if running just 'make'
CHIP ?= rp2040

# Configure the UF2 Magic Family ID based on the selected chip
ifeq ($(CHIP),rp2350)
    FAMILY_ID = 0xe48bff59
else
    FAMILY_ID = 0xe48bff56
endif

OUT_DIR = out
ELF = zig-out/bin/kernel
BIN = $(OUT_DIR)/firmware_$(CHIP).bin
UF2 = $(OUT_DIR)/image_$(CHIP).uf2

all: build

build:
	@echo "=> [1/3] Compiling Zig kernel for $(CHIP)..."
	zig build -Dchip=$(CHIP)
	
	@echo "=> [2/3] Extracting raw binary to $(BIN)..."
	@mkdir -p $(OUT_DIR)
	zig objcopy -O binary $(ELF) $(BIN)
	
	@echo "=> [3/3] Packaging to UF2 format (Family ID: $(FAMILY_ID))..."
	python3 tools/uf2conv.py -b 0x10000000 -f $(FAMILY_ID) -o $(UF2) $(BIN)
	@echo "=> Success! UF2 image is ready at: $(UF2)"

rp2040:
	$(MAKE) CHIP=rp2040 build

rp2350:
	$(MAKE) CHIP=rp2350 build

clean:
	@echo "=> Cleaning build artifacts..."
	rm -rf zig-out .zig-cache $(OUT_DIR)

flash:
	@echo "=> Flashing $(UF2) to device..."
	cp $(UF2) /run/media/$(USER)/RPI-RP2