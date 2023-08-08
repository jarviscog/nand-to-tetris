// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.
// Put your code here.

(loop)

(init)
// Get screen address
@SCREEN
D=A
@0
M=D

(kbdcheck)
@KBD
D=M
@black
D;JGT
@white
D;JEQ
@kbdcheck
0;JMP

(black)
@1
M=-1
@fill
0;JMP

(white)
@1
M=0
@fill
0;JMP

(fill)
// Get fill value
@1
D=M
// Go to address and fill it
@0
A=M
M=D
// Inc pixel location
@0
D=M+1
@KBD
D=A-D
// Inc address
@0
M=M+1
A=M
@fill
D;JGT

// Restart
@loop
0;JMP

