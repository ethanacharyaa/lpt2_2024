.global _start
_start:
 MOV R0, #1 // i=1
 MOV R1, #1 // j=1
 MOV R2, #1 // k=1
 LDR R3, =data // set base of A = first address of array “data”
 BL func
END: B END // infinite loop; R0 should contain return value of func
//base of array a is in r3

.global func
func:
LDR R12, [R3, #0] //R12 is the value of A[0]
LDR R11, [R3, #4] //R11 is the value of A[1]
ADD R4, R12, R11 //result = A[0] + A[1]
MOV R10, #42 //temp reg for 42
STR R10, [R3, #0] //A[0] = 42

AND R5, R0, #1 //i & 1
CMP R5, #1
BEQ is_and //goes here if i & 1 = 1
B continue_1 //otherwise goes here

is_and:
MOV R10, #1 //temp reg for 1
STR R10, [R3, #0] //A[0] = 1

continue_1:
CMP R1, R2
BGT greater //goes here if j > k
B else //otherwise goes here

greater:
MOV R10, #2 //temp reg for 2
STR R10, [R3, #4] //A[1] = 2
B end_func //goes to end

else:
MOV R10, #3 //temp reg for 3
STR R10, [R3, #8] //A[2] = 3
CMP R0, #0
BGE end_func //goes to end if i >= 0
CMP R2, #10
BLE end_func //goes to end if k <= 10
RSB R6, R1, #0 //-j
STR R6, [R3, #12] //A[3] = -j

end_func:
MOV R0, R4 //returns result in R0

 MOV PC, LR
data:
 .word 0, 0, 0, 0
