; compiler for the ANUS programming language 

.data
    a:  .byte 'A'
    n:  .byte 'N'
    u:  .byte 'U'
    s:  .byte 'S'

    AW: .asciiz "Hello World\n"

    s1: .asciiz " bottles of beer on the wall, "
	s2: .asciiz " bottles of beer.\n"
	s3: .asciiz "Take one down, pass it around, "
	s4: .asciiz " bottles of beer on the wall.\n\n"
	s5: .asciiz "1 bottle of beer on the wall, 1 bottle of beer.\n\nTake one down, pass it around, no more bottles of beer on the wall."

    sc: .space 1000

.text
    li, $s6, 0 # accumulator 

    li $v0, 8
    li $a0, sc
    li $a1, 1000
    syscall

    move $s0, $a0
    move $s1, $s0

    la $s2, a
    la $s3, n
    la $s4, u
    la $s5, s

    While:
		sub $t0, $s1, $s0
		beq $t0, 1000, End
		
		lb $t1, ($s1)  # load byte from current array element
		
		# 4 functions
		lb $t0, ($s2) # load 'a' byte
		beq $t0, $t1, A
		lb $t0, ($s3) # load 'n' byte
		beq $t0, $t1, N
		lb $t0, ($s4) # load 'u' byte
		beq $t0, $t1, U
		lb $t0, ($s5) # load 's' byte
		beq $t0, $t1, S
		
		j End
		
		Return:
		addi $s1, $s1, 1
		j While
		
	End:
		li $v0, 10
		syscall

    A:
        la $a0, AW
        li $v0, 4
        syscall
        j Return

    N:
        la $a0, sc
        li $v0, 4
        syscall
        j Return
    
    U:
        li $t2, 99
		For:
			beq $t2, 0, ExitF
			
			li $v0, 1
			move $a0, $t2
			syscall
			li $v0, 4
			la $a0, s1
			syscall
			li $v0, 1
			move $a0, $t2
			syscall
			li $v0, 4
			la $a0, s2
			syscall
			
			subi $t2, $t2, 1
			
			li $v0, 4
			la $a0, s3
			syscall
			li $v0, 1
			move $a0, $t2
			syscall
			li $v0, 4
			la $a0, s4
			syscall
			j For
		ExitF:
		la $a0, s5
		syscall
			j Return

        S: 
            addi $s6, $s6, 1
            j Return