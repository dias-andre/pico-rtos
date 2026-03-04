const regs = @import("registers.zig");
const pll = @import("pll.zig");

pub fn crystal_init() void {
    regs.clocks.clk_sys_resus_ctrl = 0;
    regs.xosc_hw.ctrl = 0xAA0; // 1 - 15MHZ
    regs.xosc_hw.startup = 47;
    regs.xosc_hw.ctrl |= 0xFAB000;
    // regs.xosc_hw.ctrl = (0xFAB << 12) | 0xAA0;
    while ((regs.xosc_hw.status & 0x80000000) == 0) {}

    regs.clocks.clk_ref_ctrl = 2; // XOSC
    regs.clocks.clk_sys_ctrl = 0; //reset/clk_ref
    regs.clocks.clk_peri_ctrl = (1 << 11) | (4 << 5);
}

fn set_sys_clock_to_pll() void { // 125MHz
    regs.clocks.clk_sys_ctrl = (regs.clocks.clk_sys_ctrl & ~@as(u32, 0x7 << 5));
    regs.clocks.clk_sys_ctrl = (regs.clocks.clk_sys_ctrl & ~@as(u32, 0x3)) | 1;
    while (regs.clocks.clk_sys_selected != (1 << 1)) {}
}

fn set_usb_clock_to_pll() void { // 48MHz
    regs.clocks.clk_usb_ctrl &= ~@as(u32, 0x7 << 5);
    regs.clocks.clk_usb_ctrl |= (1 << 11);
}

fn set_peri_clock_to_sys() void { // 125MHz
    regs.clocks.clk_peri_ctrl &= ~@as(u32, 0x7 << 5);
    regs.clocks.clk_peri_ctrl |= (1 << 11);
}

fn set_adc_clock_to_usb_pll() void { // 48MHz
    regs.clocks.clk_adc_ctrl &= ~@as(u32, 0x7 << 5);
    regs.clocks.clk_adc_ctrl |= (1 << 11);
}

pub fn enable_pll() void {
    pll.init();
    set_sys_clock_to_pll();
    set_usb_clock_to_pll();
    set_peri_clock_to_sys();
    set_adc_clock_to_usb_pll();
}
