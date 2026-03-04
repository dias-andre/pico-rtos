const regs = @import("registers.zig");

pub fn init() void {
    const gpio_bits = @as(u32, (1 << 5) | (1 << 8)); // enables pad_bank0
    regs.resets_hw.reset &= ~gpio_bits;
    while ((regs.resets_hw.reset_done & gpio_bits) != gpio_bits) {}
}

pub fn init_pin(pin: u5) void {
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
    regs.pads_bank0_hw.pads[pin].ie = true;
    // regs.pads_bank0_hw.pads[pin].schmitt = true;
    regs.pads_bank0_hw.pads[pin].od = true;
}

pub fn set_pullup(pin: u5) void {
    regs.sio_hw.gpio_oe_clr = @as(u32, 1) << pin;
    regs.pads_bank0_hw.pads[pin].ie = true;
    regs.pads_bank0_hw.pads[pin].pue = true;
    regs.pads_bank0_hw.pads[pin].pde = false;
    regs.pads_bank0_hw.pads[pin].schmitt = true;
}

pub fn set_pulldown(pin: u5) void {
    regs.sio_hw.gpio_oe_clr = @as(u32, 1) << pin;
    regs.pads_bank0_hw.pads[pin].ie = true;
    regs.pads_bank0_hw.pads[pin].pue = false;
    regs.pads_bank0_hw.pads[pin].pde = true;
    regs.pads_bank0_hw.pads[pin].schmitt = true;
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

pub fn read_pin(pin: u5) bool {
    const mask = @as(u32, 1) << pin;
    if ((regs.sio_hw.gpio_in & mask) != 0) {
        return true;
    }
    return false;
}
