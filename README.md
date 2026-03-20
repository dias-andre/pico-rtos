# Raspberry Pi Pico Bare-Metal RTOS

A low-level Real-Time Operating System kernel written in Zig, targeting the Raspberry Pi RP2350 (Pico 2) microcontroller. This project focuses on high-performance, memory-safe embedded programming without the overhead of the standard C SDK.

## Project Status: Platform Transition

**Important:** Development for the RP2040 has been officially discontinued and abandoned. The codebase has been entirely refactored to focus exclusively on the **RP2350** architecture. 

The transition introduces support for:
* **ARM Cortex-M33** instruction set.
* **Picobin Image Definition Blocks** (mandatory for RP2350 booting).
* **TrustZone** security state management (Secure/Non-secure modes).
* Updated Peripheral and IO_BANK0 register mapping.

## Prerequisites

To build and flash this project, the following tools are strictly required:

* **Zig Compiler**: Latest nightly/master branch (tested with 0.14.0-dev).
* **GNU Make**: To automate the build and UF2 conversion process.
* **picotool (v2.0 or higher)**: Used for uploading the final firmware to the device.
* **LLVM Tools**: `llvm-objdump` and `llvm-nm` for binary analysis.

## Hardware Support

* **Microcontroller**: Raspberry Pi RP2350.
* **Target Board**: Raspberry Pi Pico 2.
* **Architecture**: ARMv8-M (Cortex-M33).

## Building and Flashing

The project utilizes a `Makefile` to handle the Zig compilation and the subsequent conversion of the ELF binary into a valid UF2 image with the required RP2350 headers.

### 1. Build the Firmware
Running this command will compile the Zig source and generate the UF2 file in the output directory.
```bash
make rp2350
```

### 2. Flash to Device
Once the UF2 file is generated, put the Pico 2 into BOOTSEL mode and use `picotool` to upload the firmware:
```bash
picotool load out/image_rp2350.uf2
```

## Technical Architecture

### Image Definition Block (IDB)
The RP2350 requires a Tag-based Image Definition Block at the very beginning of the Flash memory. This project implements a custom `ImageDefBlock` at offset `0x00` of the Flash (`0x10000000`) to signal the BootROM to initialize the ARM core in Secure mode and define the Vector Table location.
