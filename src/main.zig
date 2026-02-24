const std = @import("std");
const gpio = @import("hal/gpio.zig");

// Entrypoint
export fn _start() linksection(".text.entry") noreturn {

    // 1. Take the pin controller (IO_BANK0) out of the Reset state (controlled by bit 5)
    // RESETS_RESET.* &= ~@as(u32, 1 << 5);

    // Wait for the hardware to confirm it has powered up
    // while ((RESETS_DONE.* & (1 << 5)) == 0) {}
    gpio.enable_io_bank();

    // 2. Configure pin 25 to be controlled via software (SIO = function 5)
    // IO_BANK0_GPIO25_CTRL.* = 5;
    gpio.init(25);

    // 3. Set pin 25 as OUTPUT (Output Enable)
    // SIO_GPIO_OE.* |= (1 << 25);
    gpio.set_output_mode(25);

    // 4. The Kernel's Infinite Loop
    while (true) {
        // Invert the current state of pin 25 (mathematical XOR)
        // SIO_GPIO_OUT_XOR.* = (1 << 25);
        gpio.toggle_pin(25);

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
