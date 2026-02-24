const regs = @import("registers.zig");

pub fn enable_io_bank() void {
    const bank0_bit = @as(u32, 1 << 5);
    regs.resets_hw.reset &= ~bank0_bit; // 11101111
    while ((regs.resets_hw.reset_done & bank0_bit) == 0) {}
}

pub fn init(pin: u5) void {
    regs.io_bank0_hw.io[pin].ctrl = 5; // set SIO function
}

pub fn set_output_mode(pin: u5) void {
    const mask = @as(u32, 1) << pin;
    // regs.sio_hw.gpio_oe |= mask;
    regs.sio_hw.gpio_oe_set = mask;
}

pub fn set_input_mode(pin: u5) void {
    const mask = @as(u32, 1) << pin;
    // regs.sio_hw.gpio_oe &= ~mask;
    regs.sio_hw.gpio_oe_clr = mask;
}

pub fn toggle_pin(pin: u5) void {
    const mask = @as(u32, 1) << pin;
    regs.sio_hw.gpio_out_xor = mask;
}

pub fn write_high(pin: u5) void {
    const mask = @as(u32, 1) << pin;
    regs.sio_hw.gpio_out_set = mask;
}

pub fn write_low(pin: u5) void {
    const mask = @as(u32, 1) << pin;
    regs.sio_hw.gpio_out_clr = mask;
}
