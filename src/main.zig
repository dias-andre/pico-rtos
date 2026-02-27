const std = @import("std");
const gpio = @import("hal/gpio.zig");
const clocks = @import("hal/clocks.zig");
const timer = @import("hal/timer.zig");

export fn _start() linksection(".text.entry") noreturn {
    gpio.enable_io_bank();
    clocks.crystal_init();
    timer.enable_timer();

    gpio.init(25);

    gpio.set_output_mode(25);
    gpio.write_low(25);

    while (true) {
        gpio.write_high(25);
        timer.sleep(1000);
        gpio.write_low(25);
        timer.sleep(300);
    }
}

pub fn panic(msg: []const u8, error_return_trace: ?*std.builtin.StackTrace, ret_addr: ?usize) noreturn {
    _ = msg;
    _ = error_return_trace;
    _ = ret_addr;
    while (true) {}
}
