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
// ARG
@15
D=A
@ARG
M=D
//// THIS
//@20
//D=A
//@THIS
//M=D
//// THAT
//@25
//D=A
//@THAT
//M=D

// Push Constant 
@17
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Push Constant 
@17
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Pop to D
@SP
M=M-1
A=M
D=M
// Go to top of stack
@SP
A=M
A=A-1
// Perform operation
D=M-D
@BOOL.1
D;JEQ
// Go to top of stack
@SP
A=M
A=A-1
// Set false, jump
M=0
@BOOLJUMP.1
0;JMP
// Set true, continue
(BOOL.1)
// Go to top of stack
@SP
A=M
A=A-1
M=-1
(BOOLJUMP.1)
// End of comparison
@SP


// Push Constant 
@17
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Push Constant 
@16
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Pop to D
@SP
M=M-1
A=M
D=M
// Go to top of stack
@SP
A=M
A=A-1
// Perform operation
D=M-D
@BOOL.2
D;JEQ
// Go to top of stack
@SP
A=M
A=A-1
// Set false, jump
M=0
@BOOLJUMP.2
0;JMP
// Set true, continue
(BOOL.2)
// Go to top of stack
@SP
A=M
A=A-1
M=-1
(BOOLJUMP.2)
// End of comparison
@SP


// Push Constant 
@16
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Push Constant 
@17
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Pop to D
@SP
M=M-1
A=M
D=M
// Go to top of stack
@SP
A=M
A=A-1
// Perform operation
D=M-D
@BOOL.3
D;JEQ
// Go to top of stack
@SP
A=M
A=A-1
// Set false, jump
M=0
@BOOLJUMP.3
0;JMP
// Set true, continue
(BOOL.3)
// Go to top of stack
@SP
A=M
A=A-1
M=-1
(BOOLJUMP.3)
// End of comparison
@SP


// Push Constant 
@892
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Push Constant 
@891
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Pop to D
@SP
M=M-1
A=M
D=M
// Go to top of stack
@SP
A=M
A=A-1
// Perform operation
D=M-D
@BOOL.4
D;JLT
// Go to top of stack
@SP
A=M
A=A-1
// Set false, jump
M=0
@BOOLJUMP.4
0;JMP
// Set true, continue
(BOOL.4)
// Go to top of stack
@SP
A=M
A=A-1
M=-1
(BOOLJUMP.4)
// End of comparison
@SP


// Push Constant 
@891
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Push Constant 
@892
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Pop to D
@SP
M=M-1
A=M
D=M
// Go to top of stack
@SP
A=M
A=A-1
// Perform operation
D=M-D
@BOOL.5
D;JLT
// Go to top of stack
@SP
A=M
A=A-1
// Set false, jump
M=0
@BOOLJUMP.5
0;JMP
// Set true, continue
(BOOL.5)
// Go to top of stack
@SP
A=M
A=A-1
M=-1
(BOOLJUMP.5)
// End of comparison
@SP


// Push Constant 
@891
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Push Constant 
@891
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Pop to D
@SP
M=M-1
A=M
D=M
// Go to top of stack
@SP
A=M
A=A-1
// Perform operation
D=M-D
@BOOL.6
D;JLT
// Go to top of stack
@SP
A=M
A=A-1
// Set false, jump
M=0
@BOOLJUMP.6
0;JMP
// Set true, continue
(BOOL.6)
// Go to top of stack
@SP
A=M
A=A-1
M=-1
(BOOLJUMP.6)
// End of comparison
@SP


// Push Constant 
@32767
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Push Constant 
@32766
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Pop to D
@SP
M=M-1
A=M
D=M
// Go to top of stack
@SP
A=M
A=A-1
// Perform operation
D=M-D
@BOOL.7
D;JGT
// Go to top of stack
@SP
A=M
A=A-1
// Set false, jump
M=0
@BOOLJUMP.7
0;JMP
// Set true, continue
(BOOL.7)
// Go to top of stack
@SP
A=M
A=A-1
M=-1
(BOOLJUMP.7)
// End of comparison
@SP


// Push Constant 
@32766
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Push Constant 
@32767
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Pop to D
@SP
M=M-1
A=M
D=M
// Go to top of stack
@SP
A=M
A=A-1
// Perform operation
D=M-D
@BOOL.8
D;JGT
// Go to top of stack
@SP
A=M
A=A-1
// Set false, jump
M=0
@BOOLJUMP.8
0;JMP
// Set true, continue
(BOOL.8)
// Go to top of stack
@SP
A=M
A=A-1
M=-1
(BOOLJUMP.8)
// End of comparison
@SP


// Push Constant 
@32766
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Push Constant 
@32766
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Pop to D
@SP
M=M-1
A=M
D=M
// Go to top of stack
@SP
A=M
A=A-1
// Perform operation
D=M-D
@BOOL.9
D;JGT
// Go to top of stack
@SP
A=M
A=A-1
// Set false, jump
M=0
@BOOLJUMP.9
0;JMP
// Set true, continue
(BOOL.9)
// Go to top of stack
@SP
A=M
A=A-1
M=-1
(BOOLJUMP.9)
// End of comparison
@SP


// Push Constant 
@57
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Push Constant 
@31
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Push Constant 
@53
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Pop to D
@SP
M=M-1
A=M
D=M
// Go to top of stack
@SP
A=M
A=A-1
// Perform operation
M=M+D


// Push Constant 
@112
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Pop to D
@SP
M=M-1
A=M
D=M
// Go to top of stack
@SP
A=M
A=A-1
// Perform operation
M=M-D


// Go to top of stack
@SP
A=M
A=A-1
// Perform operation
M=-M


// Pop to D
@SP
M=M-1
A=M
D=M
// Go to top of stack
@SP
A=M
A=A-1
// Perform operation
M=M&D


// Push Constant 
@82
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Pop to D
@SP
M=M-1
A=M
D=M
// Go to top of stack
@SP
A=M
A=A-1
// Perform operation
M=M|D


// Go to top of stack
@SP
A=M
A=A-1
// Perform operation
M=!M


