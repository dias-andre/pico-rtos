ENTRY(_start)

MEMORY
{
  RAM (rwx) : ORIGIN = 0x20000000, LENGTH = 264K
  FLASH (rx) : ORIGIN = 0x10000000, LENGTH = 2M
}

SECTIONS
{
  .boot2 : {
    KEEP(*(.boot2))
  } > FLASH

  .text : {
    KEEP(*(.text.entry))
    *(.text*)
    *(.rodata*)
    *(.ARM.extab* .gnu.linkonce.armextab.*)
    . = ALIGN(4);
  } > FLASH

  .ARM.exidx : {
    __exidx_start = .;
    *(.ARM.exidx* .gnu.linkonce.armexidx.*)
    __exidx_end = .;
    . = ALIGN(4);
  } > FLASH

  _sidata = LOADADDR(.data);

  .data : ALIGN(4) {
    _sdata = .;
    *(.data*) 
    . = ALIGN(4);
    _edata = .;
  } > RAM AT> FLASH

  .bss (NOLOAD) : ALIGN(4) {
    _sbss = .;
    *(.bss*)
    *(COMMON)
    . = ALIGN(4); 
    _ebss = .;
  } > RAM

  /DISCARD/ : {
    *(.eh_frame)
  }
}
