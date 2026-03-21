const build_options = @import("build_options");

pub const PLL_Regs = extern struct { cs: u32, pwr: u32, fbdiv_int: u32, prim: u32 };

pub const PLLMap = switch (build_options.chip) {
    .rp2040 => extern struct { cs: packed struct { refdiv: u6, _reserved0: u2, bypass: bool, _reserved1: u22, lock: bool }, pwr: packed struct { pd: bool, _reserved0: bool, dsmpd: bool, postdivpd: bool, _reserved1: bool, vcopd: bool, _reserved2: u26 }, fbdiv_int: packed struct { fbdiv: u12, _reserved: u20 }, prim: packed struct { _reserved0: u12, postdiv2: u3, _reserved1: bool, postdiv1: u3, _reserved2: u13 } },
    .rp2350 => extern struct { cs: packed struct { refdiv: u6, _reserved0: u2, bypass: bool, _reserved1: u22, lock: bool }, pwr: packed struct { pd: bool, _reserved0: bool, dsmpd: bool, postdivpd: bool, _reserved1: bool, vcopd: bool, _reserved2: u26 }, fbdiv_int: packed struct { fbdiv: u12, _reserved: u20 }, prim: packed struct { _reserved0: u12, postdiv2: u3, _reserved1: bool, postdiv1: u3, _reserved2: u13 },
        intr: packed struct { lock_n_sticky: bool, _reserved: u31 },
        inte: packed struct { lock_n_sticky: bool, _reserved: u31 },
        intf: packed struct { lock_n_sticky: bool, _reserved: u31 },
        ints: packed struct { lock_n_sticky: bool, _reserved: u31 }
    },
};
