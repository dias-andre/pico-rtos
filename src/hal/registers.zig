const build_options = @import("build_options");

const sio = @import("peripherals/sio.zig");
const resets = @import("peripherals/resets.zig");
const gpio = @import("peripherals/gpio.zig");
const uart = @import("peripherals/uart.zig");
const clocks_p = @import("peripherals/clocks.zig");
const timer_p = @import("peripherals/timer.zig");
const watchdog_p = @import("peripherals/watchdog.zig");
const pll_p = @import("peripherals/pll.zig");

const map = switch (build_options.chip) {
    .rp2040 => @import("chip/rp2040.zig"),
    .rp2350 => @import("chip/rp2350.zig"),
};

pub const sio_hw = @as(*volatile sio.SioHw, @ptrFromInt(map.SIO_BASE));
pub const resets_hw = @as(*volatile resets.ResetsHw, @ptrFromInt(map.RESETS_BASE));
pub const io_bank0_hw = @as(*volatile gpio.IoBank0Hw, @ptrFromInt(map.IO_BANK0_BASE));
pub const pads_bank0_hw = @as(*volatile gpio.PadBankHw, @ptrFromInt(map.PADS_BANK0_BASE));

pub const uart0 = @as(*volatile uart.UartHw, @ptrFromInt(map.UART0_BASE));
pub const uart1 = @as(*volatile uart.UartHw, @ptrFromInt(map.UART1_BASE));

pub const clocks: *volatile clocks_p.ClocksHw = @ptrFromInt(map.CLOCKS_BASE);
pub const xosc_hw: *volatile clocks_p.XoscHw = @ptrFromInt(map.XOSC_BASE);
pub const timer_hw: *volatile timer_p.TimerHw = @ptrFromInt(map.TIMER_BASE);
pub const watchdog: *volatile watchdog_p.WatchdogHw = @ptrFromInt(map.WATCHDOG_BASE);

pub const resets_map = struct {
    pub const reset = @as(*volatile resets.ResetRegisters, @ptrFromInt(map.RESETS_BASE));
    pub const wdsel = @as(*volatile resets.ResetRegisters, @ptrFromInt(map.RESETS_BASE + 0x4));
    pub const reset_done = @as(*const volatile resets.ResetRegisters, @ptrFromInt(map.RESETS_BASE + 0x8));
};

pub const pll_sys_map = @as(*volatile pll_p.PLLMap, @ptrFromInt(map.PLL_SYS_BASE));
pub const pll_usb_map = @as(*volatile pll_p.PLLMap, @ptrFromInt(map.PLL_USB_BASE));
