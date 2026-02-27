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
  add r0, #0x4
  add r1, #0x4
  sub r2, #1
  bne copy_loop

  ldr r0, =0x20040101
  bx r0

pool0:
.align
.ltorg

;@ --------------------------------------
.balign 0x100

  ldr r0, =0x20041000
  mov sp, r0
  bl _start
  b .
