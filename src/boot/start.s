.cpu cortex-m0
.thumb

.section .boot2, "ax" @ "ax" = allocatable and executable

.globl _start_bootloader

  ldr r0, =0x18000008
  ldr r1, =0x00000000
  str r1, [r0]

  ldr r0, =0x18000014
  ldr r1, =0x00000008
  str r1, [r0]

  ldr r0, =0x18000000
  ldr r1, =0x001F0300
  str r1, [r0]

  ldr r0, =0x180000F4
  ldr r1, =0x03000218
  str r1, [r0]

  ldr r0, =0x18000004
  ldr r1, =0x00000000
  str r1, [r0]

  ldr r0, =0x18000008
  ldr r1, =0x00000001
  str r1, [r0]

  ldr r0, =0x10000000
  ldr r1, =0x20040000
  ldr r2, =0x400

copy_loop:
  ldr r3, [r0]
  str r3, [r1]
  add r0, #4
  add r1, #4
  sub r2, #1
  bne copy_loop

  ldr r0, =0x20040101
  bx r0

pool0:
.align
.ltorg

;@ --------------------------------------
.balign 0x100 

_reset_handler:
  ldr r0, =0x20042000
  mov sp, r0

copy_data:
  ldr r1, =_sidata @ source
  ldr r2, =_sdata  @ target
  ldr r3, =_edata  @ end

.data_loop:
  cmp r2, r3
  bge zero_bss

  ldr r0, [r1]
  str r0, [r2]
  add r1, #4
  add r2, #4
  b .data_loop

zero_bss:
  ldr r1, =_sbss @ start pointer (RAM)
  ldr r2, =_ebss @ end pointer (RAM)
  mov r0, #0

.bss_loop:
  cmp r1, r2
  bge call_main

  str r0, [r1]
  add r1, #4
  b .bss_loop

call_main:
  bl _start

hang:
  b hang
