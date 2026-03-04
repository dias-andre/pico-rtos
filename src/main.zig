const std = @import("std");
const gpio = @import("hal/gpio.zig");
const clocks = @import("hal/clocks.zig");
const timer = @import("hal/timer.zig");

export fn _start() linksection(".text.entry") noreturn {
    gpio.init();
    clocks.crystal_init();
    clocks.enable_pll();
    timer.enable_timer();

    gpio.init_pin(25);
    gpio.init_pin(24);

    gpio.set_output_mode(25);
    gpio.set_pullup(24);
    gpio.write_low(25);

    gpio.write_high(25);
    timer.sleep(500);
    gpio.write_low(25);
    while (true) {
        if (gpio.read_pin(24) == false) {
            gpio.toggle_pin(25);
        }
        timer.sleep(100);
    }
}

pub fn panic(msg: []const u8, error_return_trace: ?*std.builtin.StackTrace, ret_addr: ?usize) noreturn {
    _ = msg;
    _ = error_return_trace;
    _ = ret_addr;
    while (true) {}
}
