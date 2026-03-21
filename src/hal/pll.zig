// RP2040 Datasheet section 2.18
// The PLL is designed to take a reference clock, and multiply it using a VCO (Voltage Controlled Oscillator) with a
// feedback loop. The VCO must run at high frequencies (between 750 and 1600MHz), so there are two dividers, known as
// post dividers that can divide the VCO frequency before it is distributed to the clock generators on the chip.

// Calcule
// (FREF / REFDIV) * FBDIV / (POSTDIV1 * POSTDIV2)

// Default PLL configuration RP2040:
//
// PLL SYS: 12 / 1 = 12MHz * 125 = 1500MHz / 6 / 2 = 125MHz
// PLL USB: 12 / 1 = 12MHz * 100 = 1200MHz / 5 / 5 = 48MHz
const pll_p = @import("peripherals/pll.zig");
const regs = @import("registers.zig");
const build_options = @import("build_options");

const XOSC_FREQ: u32 = 12;

fn pll_init(pll: *volatile pll_p.PLLMap, refdiv: u6, vco_freq: u32, postdiv1: u3, postdiv2: u3) void {
    const ref_freq = XOSC_FREQ / refdiv;
    const fbdiv = @as(u12, @intCast(vco_freq / ref_freq));

    pll.pwr.pd = true;
    // pll.pwr.dsmpd = true;
    pll.pwr.vcopd = true;
    pll.pwr.postdivpd = true;

    pll.cs.refdiv = refdiv;
    pll.fbdiv_int.fbdiv = fbdiv;

    pll.pwr.pd = false;
    pll.pwr.vcopd = false;

    while (!pll.cs.lock) {}

    pll.prim.postdiv1 = postdiv1;
    pll.prim.postdiv2 = postdiv2;

    pll.pwr.postdivpd = false;
}

pub fn init() void {
    regs.resets_map.reset.pll_sys = false;
    regs.resets_map.reset.pll_usb = false;
    while (!regs.resets_map.reset_done.pll_sys or !regs.resets_map.reset_done.pll_usb) {}
    // pll_init(regs.pll_sys_map, 1, 1500, 6, 2);
    switch (build_options.chip) {
        .rp2040 => {
            pll_init(regs.pll_sys_map, 1, 1500, 6, 2);
        },
        .rp2350 => {
            pll_init(regs.pll_sys_map, 1, 1500, 5, 2);
        }
    }
    pll_init(regs.pll_usb_map, 1, 1200, 5, 5);
}
