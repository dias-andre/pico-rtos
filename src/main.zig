const std = @import("std");

// RP2040 hardware addresses
const RESETS_BASE: u32 = 0x4000c000;
const IO_BANK0_BASE: u32 = 0x40014000;
const SIO_BASE: u32 = 0xd0000000;

// Magic pointers for control registers
const RESETS_RESET: *volatile u32 = @ptrFromInt(RESETS_BASE + 0x0);
const RESETS_DONE: *volatile u32 = @ptrFromInt(RESETS_BASE + 0x8);
const IO_BANK0_GPIO25_CTRL: *volatile u32 = @ptrFromInt(IO_BANK0_BASE + 0x0cc);
const SIO_GPIO_OE: *volatile u32 = @ptrFromInt(SIO_BASE + 0x020);
const SIO_GPIO_OUT_XOR: *volatile u32 = @ptrFromInt(SIO_BASE + 0x01c);

// Entrypoint
export fn _start() linksection(".text.entry") noreturn {

    // 1. Take the pin controller (IO_BANK0) out of the Reset state (controlled by bit 5)
    RESETS_RESET.* &= ~@as(u32, 1 << 5);

    // Wait for the hardware to confirm it has powered up
    while ((RESETS_DONE.* & (1 << 5)) == 0) {}

    // 2. Configure pin 25 to be controlled via software (SIO = function 5)
    IO_BANK0_GPIO25_CTRL.* = 5;

    // 3. Set pin 25 as OUTPUT (Output Enable)
    SIO_GPIO_OE.* |= (1 << 25);

    // 4. The Kernel's Infinite Loop
    while (true) {
        // Invert the current state of pin 25 (mathematical XOR)
        SIO_GPIO_OUT_XOR.* = (1 << 25);

        // A "raw" delay burning CPU cycles
        var i: u32 = 0;
        while (i < 500000) {
            // Tell the compiler not to optimize away this loop
            asm volatile ("nop");
            i += 1;
        }
    }
}

pub fn panic(msg: []const u8, error_return_trace: ?*std.builtin.StackTrace, ret_addr: ?usize) noreturn {
    _ = msg;
    _ = error_return_trace;
    _ = ret_addr;
    while (true) {}
}
