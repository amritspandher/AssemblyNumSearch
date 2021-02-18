/* Amrit Pandher
   Midterm CS351 */
.data

p1: .asciz "Enter a number:\n "
p2: .asciz "%d"
p3: .asciz "Enter a number to search: "
p4: .asciz "Number is found at the index %d\n"
p5: .asciz "Not found\n"
num: .word 0
i: .word 0
a: .skip 40

.text

.global main
.global printf
.global scanf

main:

	ldr r5, addi //r5 = address of i
	ldr r6, [r5] //r6 = value of i
	ldr r7, adda //r7 = address of array

	b test
	
loop:

	str lr, [sp, #-4]! //push stack

	ldr r0, addp1 //The following lines should prompt for and enter numbers into array
	bl printf     

	ldr r0, addp2
	ldr r1, addnum
	bl scanf

	ldr r1, addnum
	ldr r1, [r1]
	str r1, [r7, r6, LSL #2] //a[i] = i

	ldr lr, [sp], #+4 //pop stack	

	add r6, r6, #1 //i++
	str r6, [r5]   //i++ into main memory
	b test

loop2:
	ldr r2, [r7, r6, LSL #2] //load array value
	cmp r1, r2 //compare array value with search value
	beq found 

	add r6, r6, #1 //i++
	str r6, [r5]   //i++ into main memory
	b test2

found:

	str lr, [sp, #-4]! //push stack
	ldr r0, addp4
	ldr r1, [r5]
	bl printf
	ldr lr, [sp], #+4 //pop stack	

	b end

nfound:

	str lr, [sp, #-4]! //push stack

	ldr r0, addp5
	bl printf

	ldr lr, [sp], #+4 //pop stack	

	b end

test:

	cmp r6, #10 //i - 10
	blt loop    //if i<10 loop
	
	sub r6, r6, #10
	str r6, [r5]

	str lr, [sp, #-4]! //push stack
	
	ldr r0, addp3 //The following lines print new prompt and scan number to search in r1
	bl printf

	ldr r0, addp2
	ldr r1, addnum
	bl scanf

	ldr r1, addnum
	ldr r1, [r1]
	str r1, [r5]

	ldr lr, [sp], #+4 //pop stack	

	b loop2

test2:
	
	cmp r6, #10 //i - 10
	blt loop2    //if i<10 loop
	b nfound //if the number is still not found after i reaches 10 it will print the not found prompt

end:
	bx lr


addp1: .word p1
addp2: .word p2
addp3: .word p3
addp4: .word p4
addp5: .word p5
addnum: .word num
addi: .word i
adda: .word a

