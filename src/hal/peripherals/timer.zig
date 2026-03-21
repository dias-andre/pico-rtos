const build_options = @import("build_options");

/// Timer Peripheral Register Map
/// Mapped as defined in RP2040 Datasheet Section 4.6.5
pub const TimerHw = switch (build_options.chip) {
    .rp2040 => extern struct {
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
    },
    .rp2350 => extern struct {
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

        locked: u32,
        source: u32,

        intr: u32, // 0x34 Raw Interrupts
        inte: u32, // 0x38 Interrupt Enable
        intf: u32, // 0x3c Interrupt Force
        ints: u32, // 0x40 Interrupt status after masking & forcing
    },
};
