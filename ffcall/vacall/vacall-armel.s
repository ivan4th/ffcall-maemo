	.cpu arm10tdmi
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 18, 4
	.file	"vacall-armel.c"
	.text
	.align	2
	.global	__vacall
	.type	__vacall, %function
__vacall:
	@ args = 4, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, lr}
	sub	sp, sp, #32
	mov	ip, #0
	add	r9, sp, #48
	str	ip, [sp, #12]
	str	ip, [sp, #0]
	stmib	sp, {r9, ip}	@ phole stm
	add	r4, sp, #60
	ldr	sl, [r4], #-4
	ldr	r8, [sp, #56]
	str	r3, [sp, #60]
	str	r2, [sp, #56]
	ldr	r7, [sp, #52]
	ldr	r6, [sp, #48]
	str	r1, [sp, #52]
	str	r0, [sp, #48]
	ldr	r3, .L47
	mov	r0, sp
	ldr	r5, [sp, #44]
	mov	lr, pc
	ldr	pc, [r3, #0]
	ldr	r2, [sp, #12]
	cmp	r2, #0
	beq	.L2
	cmp	r2, #1
	beq	.L39
	cmp	r2, #2
	ldreqsb	r0, [sp, #24]
	beq	.L2
	cmp	r2, #3
	beq	.L39
	cmp	r2, #4
	ldreqsh	r0, [sp, #24]
	beq	.L2
	cmp	r2, #5
	ldreqh	r0, [sp, #24]
	beq	.L2
	cmp	r2, #6
	beq	.L43
	cmp	r2, #7
	beq	.L43
	cmp	r2, #8
	beq	.L43
	cmp	r2, #9
	beq	.L43
	sub	r3, r2, #10
	cmp	r3, #1
	bls	.L44
	cmp	r2, #12
	ldreq	r0, [sp, #24]	@ float
	beq	.L2
	cmp	r2, #13
	beq	.L44
	cmp	r2, #14
	beq	.L43
	cmp	r2, #15
	bne	.L2
	ldr	r3, [sp, #0]
	tst	r3, #1
	ldrne	r0, [sp, #8]
	bne	.L2
	tst	r3, #1024
	beq	.L2
	ldr	r3, [sp, #16]
	cmp	r3, #1
	beq	.L46
	cmp	r3, #2
	ldreq	r3, [sp, #8]
	ldrne	r3, [sp, #8]
	ldreqh	r0, [r3, #0]
	ldrne	r0, [r3, #0]
.L2:
	str	sl, [sp, #60]
	str	r8, [r4, #0]
	str	r7, [sp, #52]
	str	r6, [r9, #0]
	str	r5, [sp, #44]
	add	sp, sp, #32
	ldmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, pc}
.L39:
	ldrb	r0, [sp, #24]	@ zero_extendqisi2
	b	.L2
.L43:
	ldr	r0, [sp, #24]
	b	.L2
.L44:
	ldr	r0, [sp, #24]
	ldr	r1, [sp, #28]
	b	.L2
.L46:
	ldr	r3, [sp, #8]
	ldrb	r0, [r3, #0]	@ zero_extendqisi2
	b	.L2
.L48:
	.align	2
.L47:
	.word	vacall_function
	.size	__vacall, .-__vacall
	.ident	"GCC: (GNU) 4.2.1"
	.section	.note.GNU-stack,"",%progbits
