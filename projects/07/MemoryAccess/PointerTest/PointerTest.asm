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
@3030
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
@THIS
M=D

// Push Constant 
@3040
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
@THAT
M=D

// Push Constant 
@32
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Get the address
@THIS
D=M
@R14
M=D
@2
D=A
@R14
M=M+D
// Reduce stack pointer
@SP
M=M-1
// Get the value
@SP
A=M
D=M
@R14
A=M
M=D

// Push Constant 
@46
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Get the address
@THAT
D=M
@R14
M=D
@6
D=A
@R14
M=M+D
// Reduce stack pointer
@SP
M=M-1
// Get the value
@SP
A=M
D=M
@R14
A=M
M=D

// Get the value
@THIS
D=M
@SP
M=M+1
A=M
A=A-1
M=D

// Get the value
@THAT
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


// Push THIS
// Go to the address and get the value 
@THIS
D=M
@2
D=D+A
A=D
D=M
// Push element 
@SP
A=M
M=D
// Increase SP
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


// Push THAT
// Go to the address and get the value 
@THAT
D=M
@6
D=D+A
A=D
D=M
// Push element 
@SP
A=M
M=D
// Increase SP
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


