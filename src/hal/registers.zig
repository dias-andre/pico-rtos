const RESETS_BASE: u32 = 0x4000c000;

const RESET: *volatile u32 = @ptrFromInt(RESETS_BASE + 0x0);
const WDSEL: *volatile u32 = @ptrFromInt(RESETS_BASE + 0x4);
const RESET_DONE: *volatile u32 = @ptrFromInt(RESETS_BASE + 0x8);

const IO_BANK0_BASE: u32 = 0x40014000;
const IO_QSPI_BANK0_BASE: u32 = 0x40018000;

const UART0_BASE: u32 = 0x40034000;
const UART1_BASE: u32 = 0x40038000;

const SPI0_BASE: u32 = 0x4003c000;
const SPI1_BASE: u32 = 0x40040000;

const I2C0_BASE: u32 = 0x40044000;
const I2C1_BASE: u32 = 0x40048000;

const PWM_BASE: u32 = 0x40050000;

const PIO0_BASE: u32 = 0x50200000;
const PIO1_BASE: u32 = 0x50300000;

const SIO_BASE: u32 = 0xd0000000;

const CLOCKS_BASE: u32 = 0x40008000;

const XOSC_BASE: u32 = 0x40024000;

const TIMER_BASE: u32 = 0x40054000;

const WATCHDOG_BASE: usize = 0x40058000;

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

/// Clocks Peripheral Register Map
const ClocksHw = extern struct {
    // --- GPOUT0 (General Purpose Output 0) ---
    clk_gpout0_ctrl: u32, // 0x00 Clock control, can be changed on-the-fly (except for auxsrc)
    clk_gpout0_div: u32, // 0x04 Clock divisor, can be changed on-the-fly
    clk_gpout0_selected: u32, // 0x08 Indicates which SRC is currently selected by the glitchless mux (one-hot)

    // --- GPOUT1 (General Purpose Output 1) ---
    clk_gpout1_ctrl: u32, // 0x0c Clock control, can be changed on-the-fly (except for auxsrc)
    clk_gpout1_div: u32, // 0x10 Clock divisor, can be changed on-the-fly
    clk_gpout1_selected: u32, // 0x14 Indicates which SRC is currently selected by the glitchless mux (one-hot)

    // --- GPOUT2 (General Purpose Output 2) ---
    clk_gpout2_ctrl: u32, // 0x18 Clock control, can be changed on-the-fly (except for auxsrc)
    clk_gpout2_div: u32, // 0x1c Clock divisor, can be changed on-the-fly
    clk_gpout2_selected: u32, // 0x20 Indicates which SRC is currently selected by the glitchless mux (one-hot)

    // --- GPOUT3 (General Purpose Output 3) ---
    clk_gpout3_ctrl: u32, // 0x24 Clock control, can be changed on-the-fly (except for auxsrc)
    clk_gpout3_div: u32, // 0x28 Clock divisor, can be changed on-the-fly
    clk_gpout3_selected: u32, // 0x2c Indicates which SRC is currently selected by the glitchless mux (one-hot)

    // --- REF (Reference Clock) ---
    clk_ref_ctrl: u32, // 0x30 Clock control, can be changed on-the-fly (except for auxsrc)
    clk_ref_div: u32, // 0x34 Clock divisor, can be changed on-the-fly
    clk_ref_selected: u32, // 0x38 Indicates which SRC is currently selected by the glitchless mux (one-hot)

    // --- SYS (System Clock - O coração da CPU) ---
    clk_sys_ctrl: u32, // 0x3c Clock control, can be changed on-the-fly (except for auxsrc)
    clk_sys_div: u32, // 0x40 Clock divisor, can be changed on-the-fly
    clk_sys_selected: u32, // 0x44 Indicates which SRC is currently selected by the glitchless mux (one-hot)

    // --- PERI (Peripheral Clock - Alimenta a UART) ---
    clk_peri_ctrl: u32, // 0x48 Clock control, can be changed on-the-fly (except for auxsrc)
    _reserved_peri: u32, // 0x4c [PADDING] O CLK_PERI não tem DIV, preenchemos o buraco na memória
    clk_peri_selected: u32, // 0x50 Indicates which SRC is currently selected by the glitchless mux (one-hot)

    // --- USB (USB Clock) ---
    clk_usb_ctrl: u32, // 0x54 Clock control, can be changed on-the-fly (except for auxsrc)
    clk_usb_div: u32, // 0x58 Clock divisor, can be changed on-the-fly
    clk_usb_selected: u32, // 0x5c Indicates which SRC is currently selected by the glitchless mux (one-hot)

    // --- ADC (Analog-to-Digital Converter Clock) ---
    clk_adc_ctrl: u32, // 0x60 Clock control, can be changed on-the-fly (except for auxsrc)
    clk_adc_div: u32, // 0x64 Clock divisor, can be changed on-the-fly
    clk_adc_selected: u32, // 0x68 Indicates which SRC is currently selected by the glitchless mux (one-hot)

    // --- RTC (Real-Time Clock) ---
    clk_rtc_ctrl: u32, // 0x6c Clock control, can be changed on-the-fly (except for auxsrc)
    clk_rtc_div: u32, // 0x70 Clock divisor, can be changed on-the-fly
    clk_rtc_selected: u32, // 0x74 Indicates which SRC is currently selected by the glitchless mux (one-hot)

    // --- SYS RESUS (System Resuscitator) ---
    clk_sys_resus_ctrl: u32, // 0x78 System resuscitator control
    clk_sys_resus_status: u32, // 0x7c System resuscitator status

    // --- FREQUENCY COUNTER (FC0) ---
    fc0_ref_khz: u32, // 0x80 Reference clock frequency in kHz
    fc0_min_khz: u32, // 0x84 Minimum pass frequency in kHz
    fc0_max_khz: u32, // 0x88 Maximum pass frequency in kHz
    fc0_delay: u32, // 0x8c Delays the start of frequency counting to allow the mux to settle
    fc0_interval: u32, // 0x90 The test interval
    fc0_src: u32, // 0x94 Clock sent to frequency counter
    fc0_status: u32, // 0x98 Frequency counter status
    fc0_result: u32, // 0x9c Result of frequency measurement

    // --- POWER MANAGEMENT ---
    wake_en0: u32, // 0xa0 Enable clock in wake mode
    wake_en1: u32, // 0xa4 Enable clock in wake mode
    sleep_en0: u32, // 0xa8 Enable clock in sleep mode
    sleep_en1: u32, // 0xac Enable clock in sleep mode
    enabled0: u32, // 0xb0 Indicates the state of the clock enable
    enabled1: u32, // 0xb4 Indicates the state of the clock enable

    // --- INTERRUPTS ---
    intr: u32, // 0xb8 Raw Interrupts
    inte: u32, // 0xbc Interrupt Enable
    intf: u32, // 0xc0 Interrupt Force
    ints: u32, // 0xc4 Interrupt status after masking & forcing
};

/// Mapped as defined in RP2040 Datasheet Section 2.16.7
pub const XoscHw = extern struct {
    ctrl: u32, // Crystall Oscillator Control
    status: u32, // Crystall Oscillator Status
    dormant: u32, // Crystall Oscillator pause control
    startup: u32, // Controls the startup delay,
    count: u32, // A down counter running at the XOSC frequency which counts to zero and stops
};

/// Timer Peripheral Register Map
/// Mapped as defined in RP2040 Datasheet Section 4.6.5
pub const TimerHw = extern struct {
    timehw: u32, // 0x00 Write to bits 63:32 of time. Always write timelw before timehw.
    timelw: u32, // 0x04 Write to bits 31:0 of time. Writes do not get copied to time until timehw is written.
    timehr: u32, // 0x08 Read from bits 63:32 of time. Always read timelr before timehr.
    timelr: u32, // 0x0c Read from bits 31:0 of time.

    alarm0: u32, // 0x10 Arm alarm 0, and configure the time it will fire.
    alarm1: u32, // 0x14 Arm alarm 1, and configure the time it will fire.
    alarm2: u32, // 0x18 Arm alarm 2, and configure the time it will fire.
    alarm3: u32, // 0x1c Arm alarm 3, and configure the time it will fire.

    armed: u32, // 0x20 Indicates the armed/disarmed status of each alarm.

    timerawh: u32, // 0x24 Raw read from bits 63:32 of time (no side effects)
    timerawl: u32, // 0x28 Raw read from bits 31:0 of time (no side effects)

    dbgpause: u32, // 0x2c Set bits high to enable pause when the corresponding debug ports are active
    pause: u32, // 0x30 Set high to pause the timer

    intr: u32, // 0x34 Raw Interrupts
    inte: u32, // 0x38 Interrupt Enable
    intf: u32, // 0x3c Interrupt Force
    ints: u32, // 0x40 Interrupt status after masking & forcing
};

const WatchdogHw = extern struct {
    ctrl: u32, // 0x00
    load: u32, // 0x04
    reason: u32, // 0x08
    scratch0: u32, // 0x0c
    scratch1: u32, // 0x10
    scratch2: u32, // 0x14
    scratch3: u32, // 0x18
    scratch4: u32, // 0x1c
    scratch5: u32, // 0x20
    scratch6: u32, // 0x24
    scratch7: u32, // 0x28
    tick: u32, // 0x2c
};

/// Mapped as defined in RP2040 Datasheet section 4.2.8
pub const UartHw = extern struct {
    dr: u32, // 0x000 Data Register (Read to receive, Write to send)
    rsr: u32, // 0x004 Receive Status / Error Clear Register
    _reserved0: [4]u32, // 0x008 to 0x014 [PADDING] 4 * 4 bytes = 16 bytes

    fr: u32, // 0x018 Flag Register (Check if TX is full or RX is empty)
    _reserved1: u32, // 0x01c [PADDING] 4 bytes

    ilpr: u32, // 0x020 IrDA Low-Power Counter Register
    ibrd: u32, // 0x024 Integer Baud Rate Register
    fbrd: u32, // 0x028 Fractional Baud Rate Register
    lcr_h: u32, // 0x02c Line Control Register (Sets 8N1, parity, etc)
    cr: u32, // 0x030 Control Register (Master switch for UART)
    ifls: u32, // 0x034 Interrupt FIFO Level Select
    imsc: u32, // 0x038 Interrupt Mask Set/Clear
    ris: u32, // 0x03c Raw Interrupt Status
    mis: u32, // 0x040 Masked Interrupt Status
    icr: u32, // 0x044 Interrupt Clear Register
    dmacr: u32, // 0x048 DMA Control Register

    _reserved2: [997]u32, // 0x04c to 0xfdc [PADDING] Huge memory gap (3988 bytes)

    periphid0: u32, // 0xfe0 UARTPeriphID0 Register
    periphid1: u32, // 0xfe4 UARTPeriphID1 Register
    periphid2: u32, // 0xfe8 UARTPeriphID2 Register
    periphid3: u32, // 0xfec UARTPeriphID3 Register
    pcellid0: u32, // 0xff0 UARTPCellID0 Register
    pcellid1: u32, // 0xff4 UARTPCellID1 Register
    pcellid2: u32, // 0xff8 UARTPCellID2 Register
    pcellid3: u32, // 0xffc UARTPCellID3 Register
};

/// Mapped as defined in RP2040 Datasheet section 2.19.6.3
const PadHw = packed struct { slew_fast: bool, schmitt: bool, pde: bool, pue: bool, drive: u2, ie: bool, od: bool, _reserved: u24 };
const PadBankHw = extern struct { vol: u32, pads: [30]PadHw, _reserved: [2]u32 };

pub const sio_hw = @as(*volatile SioHw, @ptrFromInt(SIO_BASE));
pub const resets_hw = @as(*volatile ResetsHw, @ptrFromInt(RESETS_BASE));
pub const io_bank0_hw = @as(*volatile IoBank0Hw, @ptrFromInt(IO_BANK0_BASE));
pub const pads_bank0_hw = @as(*volatile PadBankHw, @ptrFromInt(0x4001c000));

pub const uart0 = @as(*volatile UartHw, @ptrFromInt(UART0_BASE));
pub const uart1 = @as(*volatile UartHw, @ptrFromInt(UART1_BASE));

pub const clocks: *volatile ClocksHw = @ptrFromInt(CLOCKS_BASE);
pub const xosc_hw: *volatile XoscHw = @ptrFromInt(XOSC_BASE);
pub const timer_hw: *volatile TimerHw = @ptrFromInt(TIMER_BASE);
pub const watchdog: *volatile WatchdogHw = @ptrFromInt(WATCHDOG_BASE);
