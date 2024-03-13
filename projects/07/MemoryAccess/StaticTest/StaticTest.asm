// Init
// SP
@256
D=A
@SP
M=D
// LCL
@300
D=A
@LCL
M=D
// ARG
@400
D=A
@ARG
M=D
// THIS
@3000
D=A
@THIS
M=D
// THAT
@3010
D=A
@THAT
M=D

// Push Constant 
@111
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Push Constant 
@333
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Push Constant 
@888
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Get the value
@SP
M=M-1
A=M
D=M
@24
M=D

// Get the value
@SP
M=M-1
A=M
D=M
@19
M=D

// Get the value
@SP
M=M-1
A=M
D=M
@17
M=D

// Get the value
@19
D=M
@SP
M=M+1
A=M
A=A-1
M=D

// Get the value
@17
D=M
@SP
M=M+1
A=M
A=A-1
M=D

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


// Get the value
@24
D=M
@SP
M=M+1
A=M
A=A-1
M=D

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


