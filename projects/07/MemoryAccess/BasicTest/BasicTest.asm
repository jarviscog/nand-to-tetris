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
// TEMP
@5
D=A
@5
M=D

// Push Constant 
@10
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Get the address
@LCL
D=M
@R14
M=D
@0
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
@21
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Push Constant 
@22
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Get the address
@ARG
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

// Get the address
@ARG
D=M
@R14
M=D
@1
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
@36
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

// Push Constant 
@42
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Push Constant 
@45
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
@5
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

// Get the address
@THAT
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
@510
D=A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Get the address
@5
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

// Push LCL
@LCL
D=A
@0
D=D+A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Push THAT
@THAT
D=A
@5
D=D+A
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


// Push ARG
@ARG
D=A
@1
D=D+A
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


// Push THIS
@THIS
D=A
@6
D=D+A
// RAM[SP] = D 
@SP
A=M
M=D
// SP++
@SP
M=M+1

// Push THIS
@THIS
D=A
@6
D=D+A
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


// Push 5
@5
D=A
@6
D=D+A
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


