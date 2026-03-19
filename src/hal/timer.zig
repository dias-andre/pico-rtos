const regs = @import("registers.zig");
const build_options = @import("build_options");

pub fn enable_timer() void {
    // const mask = @as(u32, 1 << 21);
    // regs.resets_hw.reset &= ~mask;
    if (build_options.chip == .rp2350) {
        regs.resets_map.reset.timer0 = false;
        while (regs.resets_map.reset_done.timer0 == false) {}
    } else {
        regs.resets_map.reset.timer = false;
        while (regs.resets_map.reset_done.timer == false) {}
    }
    regs.watchdog.tick = (1 << 9) | 12;
}

// pub fn sleep(milisseconds: u32) void {
//     var micro = regs.timer_hw.timerawl;
//     const target = (milisseconds * 1000) + micro;
//     while (micro < target) {
//         micro = regs.timer_hw.timerawl;
//     }
// }

pub fn sleep(milisseconds: u32) void {
    const start = regs.timer_hw.timerawl;
    const delay_us = milisseconds * 1000;

    while (true) {
        const now = regs.timer_hw.timerawl;
        const elapsed = now -% start;

        if (elapsed >= delay_us) {
            break;
        }
    }
}
