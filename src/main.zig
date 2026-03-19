const build_options = @import("build_options");
const vectors = @import("vectors.zig");

pub const ImageDefBlock = extern struct {
    magic_start: u32 = 0xFFFFEADB,
    image_type: u32 = 0x00000102,
    image_info: u32 = 0x00000001,
    vt_type: u32 = 0x00000103,
    vt_offset: u32 = 0x00000100,
    end_tag: u32 = 0x00000000,
    magic_end: u32 = 0xAB123579,
};

const boot_block_instance = ImageDefBlock{};

comptime {
    _ = vectors;
    if (build_options.chip == .rp2350) {
        @export(&boot_block_instance, .{ .name = "boot_block", .section = ".embedded_block" });
    }
}

const std = @import("std");
const gpio = @import("hal/gpio.zig");
const clocks = @import("hal/clocks.zig");
const timer = @import("hal/timer.zig");

export fn _start() callconv(.c) noreturn {
    gpio.init();
    gpio.init_pin(25);
    gpio.set_input_mode(25);
    gpio.write_high(25);
    while(true){}
}

pub fn panic(msg: []const u8, error_return_trace: ?*std.builtin.StackTrace, ret_addr: ?usize) noreturn {
    _ = msg;
    _ = error_return_trace;
    _ = ret_addr;
    while (true) {}
}
