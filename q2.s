.global clunky
clunky:
 MOV R1, #0 //result = 0
 MOV R2, #0 //next = 0

//this is the while loop
 while:
 LDR R12, [R0, R2, LSL#2] //A[next]
 CMP R12, #-1
 BNE noteq //goes into the loop if they are not equal
 B end_clunky //otherwise exits the loop

 noteq:
 MOV R3, R12 //tmp = A[next]
 ADD R11, R2, #1 //next + 1
 LDR R10, [R0, R11, LSL#2] //A[next + 1]
 ADD R1, R1, R10 //result += A[next + 1]

 LSR R8, R3, #1 //temp/2
 AND R4, R8, #1 //(tmp/2) & 1
 CMP R4, #1
 BEQ is_and //goes here if (tmp/2) & 1 = 1
 B else //otherwise goes here

 is_and:
 MOV R9, #-1 //temp reg for -1
 STR R9, [R0, R2, LSL#2] //A[next] = -1
 B continue

 else:
 MOV R9, #-2 //temp reg for -2
 STR R9, [R0, R2, LSL#2] //A[next] = -2
 B continue

 continue:
 MOV R2, R3 //next = tmp
 B while //goes back to the top of the loop

 end_clunky:
 MOV R0, R1 //returns result in R0

 MOV PC, LR

.global _start
_start:
 LDR R0,=A
 BL clunky
end: B end // infinite loop; R0 should contain return value of clunky 
A: .word 4,1,6,2,2,3,-1,4
