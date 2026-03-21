.syntax unified
.cpu cortex-m33
.thumb

.section .vectors, "a", %progbits
.global vector_table
.type vector_table, %object

.type _start, %function
.type unhandled, %function

vector_table:
    .word 0x20082000
    .word _start
    .word unhandled
    .word unhandled
    .word unhandled
    .word unhandled
    .word unhandled
    .word unhandled
    .word 0
    .word 0
    .word 0
    .word unhandled
    .word unhandled
    .word 0
    .word unhandled
    .word unhandled
.size vector_table, . - vector_table