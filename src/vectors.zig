extern fn _start() callconv(.c) noreturn;

const STACK_TOP: u32 = 0x20082000;

fn unhandled_exception() callconv(.c) void {
    while (true) {}
}

pub const VectorTable = extern struct {
    initial_sp: u32,
    reset: *const fn () callconv(.c) noreturn,
    nmi: *const fn () callconv(.c) void,
    hard_fault: *const fn () callconv(.c) void,
    mem_manage: *const fn () callconv(.c) void,
    bus_fault: *const fn () callconv(.c) void,
    usage_fault: *const fn () callconv(.c) void,
    _reserved_7: u32 = 0,
    _reserved_8: u32 = 0,
    _reserved_9: u32 = 0,
    _reserved_10: u32 = 0,
    svcall: *const fn () callconv(.c) void,
    debug_monitor: *const fn () callconv(.c) void,
    _reserved_13: u32 = 0,
    pendsv: *const fn () callconv(.c) void,
    systick: *const fn () callconv(.c) void,
};

export const vector_table linksection(".text.entry") = VectorTable{
    .initial_sp = STACK_TOP,
    .reset = _start,
    .nmi = unhandled_exception,
    .hard_fault = unhandled_exception,
    .mem_manage = unhandled_exception,
    .bus_fault = unhandled_exception,
    .usage_fault = unhandled_exception,
    .svcall = unhandled_exception,
    .debug_monitor = unhandled_exception,
    .pendsv = unhandled_exception,
    .systick = unhandled_exception,
};