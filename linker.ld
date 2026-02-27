ENTRY(_start)

MEMORY
{
  RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 264K
}

SECTIONS
{
  .boot2 : {
    KEEP(*(.boot2))
  }

  .text : {
    KEEP(*(.text.entry))
    *(.text*)
    *(.rodata*)
    *(.ARM.extab* .gnu.linkonce.armextab.*)
  } > RAM

  .ARM.exidx : {
    __exidx_start = .;
    *(.ARM.exidx* .gnu.linkonce.armexidx.*)
    __exidx_end = .;
  } > RAM

  .data : { *(.data*) } > RAM
  .bss : { *(.bss*) } > RAM

  /DISCARD/ : {
    *(.eh_frame)
  }
}
