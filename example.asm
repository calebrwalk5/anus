# anus language example file creator
# written by anusO1

            .data
file:       .asciiz "example.anus"
buffer:     .asciiz "ANA"

            .text
    li      $v0, 13 # system call for open file
    la      $a0, file
    li      $a1, 1
    li      $a2, 0
    syscall
    move    $s6, $v0

    li      $v0, 15 # system call for write to file
    move    $a0, $s6
    la      $a1, buffer
    li      $a2, 44
    syscall

    li      $v0, 16 # system call for close file
    move    $a0, $s6
    syscall