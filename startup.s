.global _start
.extern write_str
.extern write_byte

.data
.balign 4
print_something:.asciz "Current status"
new_line:       .asciz "\r\n"
space:          .asciz " "
array_length:   .word 12
myarray:        .word 18, 19, 32, 35, 40, 43, 44, 68, 80, 86, 70, 79

.text
_start:
        LDR     SP, =stack_top      // Initialize Stack Pointer
        LDR     R0,=array_length    // Load address of array length into R0
        LDR     R0,[R0]             // Load value of array length into R0
        LDR     R4,=myarray         // Load adress of array into R3
        BL      init
        B .

init:
        push    {lr}                // Push return address on stack
        MOV     R1,R0               // copy array length into r1
        MOV     R2,R1               // i is n
        LSR     R2,#1               // i is n/2
        SUB     R2, R2, #1          // is is n/2 -1
        MOV     R3, R2              // offset for element i is i
        LSL     R3, #2              // offset for element i is i * 4
        MOV     R11, #1             // R11 is 1, so heapify exits to exit 1
build_heap:
        CMP R2, #0                  // if i < 0
        BLT exit_build_heap         // branch to second loop
        MOV R7, R2                  // else make heap_i = i
        MOV R8, R3                  // make heap_i offset = i offset
        B heap
heap_exit1:
                SUB R2, R2, #1
                SUB R3, R3, #4
                B build_heap

exit_build_heap:
        MOV R2, R1
        SUB R2, R2, #1
        MOV R3, R2                  // offset for element i is i
        LSL R3, #2                  // offset for element i is i * 4
        MOV R11, #2                 // R11 is 2, so heapify now exits to exit 2
extract_elem:
            CMP R2, #0
            BLT printAll
            LDR R6, [R4,R3]         // array[i]
            LDR R5, [R4]            // array[0]
            STR R6, [R4]            // array[i] = array[0]
            STR R5, [R4,R3]         // array[0] = array[i]

            MOV R7, #0              // make heap_i = 0
            MOV R8, #0              // make heap_i offset = 0
            MOV R1, R2              // make heap_n = i
            B heap
heap_exit2:
                SUB R2, R2, #1
                SUB R3, R3, #4
                B extract_elem


heap:
        MOV R9, R7                  // largest is heap_i
        MOV R10, R8                 // largest offset is heap_i offset
        MOV R12, R7                 // l is heap_i
        LSL R12, #1                 // l is heap_i * 2
        ADD R12, R12, #1            // l is heap_i * 2 + 1
        MOV R0, R12                 // l offset is l
        LSL R0, #2                  // l offset is l * 4
    if1:CMP R12, R1                 // if l > n
        BGE if3
    if2:LDR R5, [R4,R0]             // array[l]
        LDR R6, [R4,R10]            // array[largest]
        CMP R5, R6                  // if array[l] > array[largest]
        BLE if3
        MOV R9, R12                 // largest = l
        MOV R10, R0                 // largest offset is largest

    if3:ADD R12, R12, #1            // l is now r which is heap_i * 2 + 2
        ADD R0, R0, #4              // r offset is l offset + 4
        CMP R12, R1                 // if r < n
        BGE if5
    if4:LDR R5, [R4,R0]             // array[r]
        LDR R6, [R4,R10]            // array[largest]
        CMP R5, R6                  // if array[r] > array[largest]
        BLE if5
        MOV R9, R12                 // largest = r
        MOV R10, R0                 // largest offset is largest

    if5:CMP R9, R7                  // if largest == heap_i
        BEQ exit_heap
        LDR R5, [R4,R8]             // array[heap_i]
        LDR R6, [R4,R10]            // array[largest]
        STR R5, [R4,R10]            // array[largest] = array[heap_i]
        STR R6, [R4,R8]             // array[heap_i] = array[largest]

        MOV R7, R9                  // heap_i = largest for next heapify call
        MOV R8, R10                 // heap_i offset = largest offset for next heapify call
        B heap

exit_heap:
            CMP R11, #1
            BEQ heap_exit1
            B   heap_exit2


printAll:   MOV R5, #0
                MOV R6, #0
                LDR     R12,=array_length   // Load address of array length into R1
                LDR     R12,[R12]               // Load value of array length into R1
printAll_loop:  CMP R5, R12
                BGE end_loop

                push {R0-R12}
                LDR R0, [R4,R6]         // load element i
                BL  write_byte
                LDR R0, =space
                BL  write_str

                pop {R0-R12}

                ADD R5, R5, #1
                ADD R6, R6, #4
                B printAll_loop
end_loop:
        pop     {lr}
        BX      lr
