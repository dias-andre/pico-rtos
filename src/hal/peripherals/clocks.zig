const build_options = @import("build_options");

/// Clocks Peripheral Register Map
pub const ClocksHw = switch (build_options.chip) {
    .rp2040 => extern struct {
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
    },
    .rp2350 => extern struct { // Mapped as defined in RP2350 Datasheet Section 8.1.7
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
        clk_peri_div: u32,
        clk_peri_selected: u32, // 0x50 Indicates which SRC is currently selected by the glitchless mux (one-hot)

        // New in Rp2350
        clk_hstx_ctrl: u32,
        clk_hstx_div: u32,
        clk_hstx_selected: u32,

        // --- USB (USB Clock) ---
        clk_usb_ctrl: u32, // 0x54 Clock control, can be changed on-the-fly (except for auxsrc)
        clk_usb_div: u32, // 0x58 Clock divisor, can be changed on-the-fly
        clk_usb_selected: u32, // 0x5c Indicates which SRC is currently selected by the glitchless mux (one-hot)

        // --- ADC (Analog-to-Digital Converter Clock) ---
        clk_adc_ctrl: u32, // 0x60 Clock control, can be changed on-the-fly (except for auxsrc)
        clk_adc_div: u32, // 0x64 Clock divisor, can be changed on-the-fly
        clk_adc_selected: u32, // 0x68 Indicates which SRC is currently selected by the glitchless mux (one-hot)

        // New in RP2350
        dftclk_xosc_ctrl: u32,
        dftclk_rosc_ctrl: u32,
        dftclk_lposc_ctrl: u32,

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
    },
};

/// Mapped as defined in RP2040 Datasheet Section 2.16.7
pub const XoscHw = extern struct {
    ctrl: u32, // Crystall Oscillator Control
    status: u32, // Crystall Oscillator Status
    dormant: u32, // Crystall Oscillator pause control
    startup: u32, // Controls the startup delay,
    count: u32, // A down counter running at the XOSC frequency which counts to zero and stops
};
