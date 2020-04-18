// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Initialzie
@R2     // R2 = 0
M=0
(LOOP)
    @R1     // Load R1
    D=M
    D=D-1   // R1 = R1 - 1
    @END    // if R1 < 0 go goto END
    D;JLT
            // else if R1 >= 0 
    @R0     // Load R0
    D=M
    @R2     // R2 = R2 + R0
    M=M+D
    @R1     // R1-1
    M=M-1
    @LOOP   // goto LOOP
    0;JMP   // 無条件分岐
(END)
    @END
    0;JMP   // 無条件分岐