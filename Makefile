OUT_DIR = out
ELF = zig-out/bin/kernel
BIN = $(OUT_DIR)/kernel.bin
UF2 = $(OUT_DIR)/kernel.uf2

$(ELF): src/main.zig linker.ld build.zig
	@echo "=> [1/3] Compiling Kernel in Zig..."
	zig build

$(BIN): $(ELF)
	@echo "=> [2/3] Extracting raw binary to $(OUT_DIR)/..."
	@mkdir -p $(OUT_DIR)
	zig objcopy -O binary $(ELF) $(BIN)

$(UF2): $(BIN)
	@echo "=> [3/3] Packaging to UF2..."
	python3 tools/uf2conv.py -b 0x20000000 -f 0xe48bff56 -o $(UF2) $(BIN)
	@echo "=> Success! Your Kernel is ready at: $(UF2)"

clean:
	@echo "=> Cleaning build files..."
	rm -rf zig-out .zig-cache $(OUT_DIR)

build: $(UF2)

install: $(UF2)
	mv $(UF2) /run/media/$USER/RIP-RP2
