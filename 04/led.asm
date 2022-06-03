// led.asm
// execute an infinite loop to
// read the button state and write the result

(LOOP)
@8193		//read BUT
D=M

@8192		//write LED
M=D

@LOOP
0;JMP
