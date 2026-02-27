OUT_DIR = out
ELF = zig-out/bin/kernel
ASM = out/start.o
BIN = $(OUT_DIR)/firmware.bin
UF2 = $(OUT_DIR)/image.uf2

XCPU = -mcpu=cortex-m0
AOPS = --warn --fatal-warnings $(XCPU)
COPS = --Wall -O2 -ffrestanding $(XCPU)
LOPS = -nostdlib -nostartfiles

ARMGNU = arm-none-eabi-as

makeuf2f: makeuf2f.c
	gcc -O2 makeuf2f.c -o makeuf2f

$(ASM): src/boot/start.s
	@echo "=> [1/4] Compiling Assembly Code..."
	@mkdir -p $(OUT_DIR)
	$(ARMGNU) $(AOPS) src/boot/start.s -o $(OUT_DIR)/start.o

$(ELF): $(ASM) src/main.zig linker.ld build.zig
	@echo "=> [2/4] Compiling Zig Code..."
	zig build

$(BIN): $(ELF)
	@echo "=> [3/4] Extracting raw binary to $(OUT_DIR)/..."
	@mkdir -p $(OUT_DIR)
	zig objcopy -O binary $(ELF) $(BIN)

$(UF2): $(BIN) makeuf2f
	@echo "=> [4/4] Packaging to UF2..."
	# python3 tools/uf2conv.py -b 0x20000000 -f 0xe48bff56 -o $(UF2) $(BIN)
	./makeuf2f $(BIN) $(UF2)
	@echo "=> Success! Your image is ready at: $(UF2)"

clean:
	@echo "=> Cleaning build files..."
	rm -rf zig-out .zig-cache $(OUT_DIR)

build: $(UF2)

install: $(UF2)
	mv $(UF2) /run/media/$(USER)/RIP-RP2
