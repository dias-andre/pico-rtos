const RESETS_BASE: u32 = 0x4000c000;
const IO_BANK0_BASE: u32 = 0x40014000;
const IO_QSPI_BANK0_BASE: u32 = 0x40018000;

const UART0_BASE: u32 = 0x40034000;
const UART1_BASE: u32 = 0x40038000;

const SPI0_BASE: u32 = 0x4003c000;
const SPI1_BASE: u32 = 0x40040000;

const I2C0_BASE: u32 = 0x40044000;
const I2C1_BASE: u32 = 0x40048000;

const PWM_BASE: u32 = 0x40050000;

const TIMER_BASE: u32 = 0x40054000;

const PIO0_BASE: u32 = 0x50200000;
const PIO1_BASE: u32 = 0x50300000;

const SIO_BASE: u32 = 0xd0000000;

const RESET: *volatile u32 = @ptrFromInt(RESETS_BASE + 0x0);
const WDSEL: *volatile u32 = @ptrFromInt(RESETS_BASE + 0x4);
const RESET_DONE: *volatile u32 = @ptrFromInt(RESETS_BASE + 0x8);

/// Single-cycle IO (SIO) Register Map
/// Mapped exactly as defined in RP2040 Datasheet section 2.3.1.7
const SioHw = extern struct {
    cpuid: u32, // 0x000 Processor core identifier
    gpio_in: u32, // 0x004 Input value for GPIO pins
    gpio_hi_in: u32, // 0x008 Input value for QSPI pins
    _reserved0: u32, // 0x00c [PADDING] Reserved to maintain alignment

    gpio_out: u32, // 0x010 GPIO output value
    gpio_out_set: u32, // 0x014 GPIO output value set
    gpio_out_clr: u32, // 0x018 GPIO output value clear
    gpio_out_xor: u32, // 0x01c GPIO output value XOR

    gpio_oe: u32, // 0x020 GPIO output enable
    gpio_oe_set: u32, // 0x024 GPIO output enable set
    gpio_oe_clr: u32, // 0x028 GPIO output enable clear
    gpio_oe_xor: u32, // 0x02c GPIO output enable XOR

    gpio_hi_out: u32, // 0x030 QSPI output value
    gpio_hi_out_set: u32, // 0x034 QSPI output value set
    gpio_hi_out_clr: u32, // 0x038 QSPI output value clear
    gpio_hi_out_xor: u32, // 0x03c QSPI output value XOR

    gpio_hi_oe: u32, // 0x040 QSPI output enable
    gpio_hi_oe_set: u32, // 0x044 QSPI output enable set
    gpio_hi_oe_clr: u32, // 0x048 QSPI output enable clear
    gpio_hi_oe_xor: u32, // 0x04c QSPI output enable XOR

    fifo_st: u32, // 0x050 Status register for inter-core FIFOs (mailboxes)
    fifo_wr: u32, // 0x054 Write access to this core's TX FIFO
    fifo_rd: u32, // 0x058 Read access to this core's RX FIFO
    spinlock_st: u32, // 0x05c Spinlock state

    div_udividend: u32, // 0x060 Divider unsigned dividend
    div_udivisor: u32, // 0x064 Divider unsigned divisor
    div_sdividend: u32, // 0x068 Divider signed dividend
    div_sdivisor: u32, // 0x06c Divider signed divisor
    div_quotient: u32, // 0x070 Divider result quotient
    div_remainder: u32, // 0x074 Divider result remainder
    div_csr: u32, // 0x078 Control and status register for divider
    _reserved1: u32, // 0x07c [PADDING] Reserved to maintain alignment

    // --- Hardware Interpolator 0 ---
    interp0_accum0: u32, // 0x080 Read/write access to accumulator 0
    interp0_accum1: u32, // 0x084 Read/write access to accumulator 1
    interp0_base0: u32, // 0x088 Read/write access to BASE0 register
    interp0_base1: u32, // 0x08c Read/write access to BASE1 register
    interp0_base2: u32, // 0x090 Read/write access to BASE2 register
    interp0_pop_lane0: u32, // 0x094 Read LANE0 result, write to accumulators (POP)
    interp0_pop_lane1: u32, // 0x098 Read LANE1 result, write to accumulators (POP)
    interp0_pop_full: u32, // 0x09c Read FULL result, write to accumulators (POP)
    interp0_peek_lane0: u32, // 0x0a0 Read LANE0 result, without altering internal state
    interp0_peek_lane1: u32, // 0x0a4 Read LANE1 result, without altering internal state
    interp0_peek_full: u32, // 0x0a8 Read FULL result, without altering internal state
    interp0_ctrl_lane0: u32, // 0x0ac Control register for lane 0
    interp0_ctrl_lane1: u32, // 0x0b0 Control register for lane 1
    interp0_accum0_add: u32, // 0x0b4 Atomically added to ACCUM0
    interp0_accum1_add: u32, // 0x0b8 Atomically added to ACCUM1
    interp0_base_1and0: u32, // 0x0bc Lower 16 bits go to BASE0, upper to BASE1

    // --- Hardware Interpolator 1 ---
    interp1_accum0: u32, // 0x0c0 Read/write access to accumulator 0
    interp1_accum1: u32, // 0x0c4 Read/write access to accumulator 1
    interp1_base0: u32, // 0x0c8 Read/write access to BASE0 register
    interp1_base1: u32, // 0x0cc Read/write access to BASE1 register
    interp1_base2: u32, // 0x0d0 Read/write access to BASE2 register
    interp1_pop_lane0: u32, // 0x0d4 Read LANE0 result, write to accumulators (POP)
    interp1_pop_lane1: u32, // 0x0d8 Read LANE1 result, write to accumulators (POP)
    interp1_pop_full: u32, // 0x0dc Read FULL result, write to accumulators (POP)
    interp1_peek_lane0: u32, // 0x0e0 Read LANE0 result, without altering internal state
    interp1_peek_lane1: u32, // 0x0e4 Read LANE1 result, without altering internal state
    interp1_peek_full: u32, // 0x0e8 Read FULL result, without altering internal state
    interp1_ctrl_lane0: u32, // 0x0ec Control register for lane 0
    interp1_ctrl_lane1: u32, // 0x0f0 Control register for lane 1
    interp1_accum0_add: u32, // 0x0f4 Atomically added to ACCUM0
    interp1_accum1_add: u32, // 0x0f8 Atomically added to ACCUM1
    interp1_base_1and0: u32, // 0x0fc Lower 16 bits go to BASE0, upper to BASE1

    // --- Hardware Spinlocks ---
    spinlock: [32]u32, // 0x100 to 0x17c (Spinlock registers 0 through 31)
};

const ResetsHw = extern struct { reset: u32, wdsel: u32, reset_done: u32 };

const GpioHw = extern struct { status: u32, ctrl: u32 };

const IoBank0Hw = extern struct {
    io: [30]GpioHw,
};

pub const sio_hw = @as(*volatile SioHw, @ptrFromInt(SIO_BASE));
pub const resets_hw = @as(*volatile ResetsHw, @ptrFromInt(RESETS_BASE));
pub const io_bank0_hw = @as(*volatile IoBank0Hw, @ptrFromInt(IO_BANK0_BASE));
