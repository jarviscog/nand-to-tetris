// Init
// SP
@256
D=A
@SP
M=D
// LCL
        @10
D=A
@LCL
M=D
// LCL
        @15
D=A
@ARG
M=D
// THIS 
        @20
D=A
@THIS
M=D

        // THAT 
        @25
D=A
@THAT
M=D

        
// Constant 
@7
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Constant 
@8
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

@SP
M=M-1
A=M
D=M
@SP
A=M
A=A-1
M=M+D

