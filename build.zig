const std = @import("std");

pub const Chip = enum { rp2040, rp2350 };

pub fn build(b: *std.Build) void {
    const target_chip = b.option(Chip, "chip", "Select the target microcontroller") orelse .rp2040;
    const options = b.addOptions();
    options.addOption(Chip, "chip", target_chip);

    const target_query = std.Target.Query{
        .cpu_arch = .thumb,
        .cpu_model = switch (target_chip) {
            .rp2040 => .{ .explicit = &std.Target.arm.cpu.cortex_m0plus },
            .rp2350 => .{ .explicit = &std.Target.arm.cpu.cortex_m33 },
        },
        .os_tag = .freestanding,
        .abi = .eabi,
    };

    const target = b.resolveTargetQuery(target_query);

    const optimize = std.builtin.OptimizeMode.ReleaseSmall;

    const kernel = b.addExecutable(.{
        .name = "kernel.elf",
        .root_module = b.createModule(.{
            .root_source_file = b.path("src/main.zig"),
            .target = target,
            .optimize = optimize,
        }),
    });
    
    kernel.lto = std.zig.LtoMode.none;
    kernel.root_module.strip = false;

    if (target_chip == .rp2040) {
        // kernel.addObjectFile(b.path("out/start.o"));
        kernel.addAssemblyFile(b.path("src/arch/arm-cortex-m0/start.s"));
        kernel.setLinkerScript(b.path("linker_rp2040.ld"));
    } else {
        kernel.addAssemblyFile(b.path("src/arch/armv8-cortex-m33/start.s"));
        kernel.addAssemblyFile(b.path("src/arch/armv8-cortex-m33/vectors.s"));
        kernel.setLinkerScript(b.path("linker_rp2350.ld"));
    }

    kernel.root_module.addOptions("build_options", options);

    b.installArtifact(kernel);
}
