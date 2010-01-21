	.cpu arm10tdmi
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 18, 4
	.file	"cache-arm.c"
	.text
	.align	2
	.global	__TR_clear_cache
	.type	__TR_clear_cache, %function
__TR_clear_cache:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r7, fp}
	add	fp, sp, #4
	sub	sp, sp, #8
	@ lr needed for prologue
	str	r0, [fp, #-8]
	str	r1, [fp, #-12]
	ldr	r3, [fp, #-8]
	mov	r0, r3
	ldr	r3, [fp, #-12]
	mov	r1, r3
	mov	r2, #0
	ldr	r7, .L3
#APP
	swi 0x0
	sub	sp, fp, #4
	ldmfd	sp!, {r7, fp}
	bx	lr
.L4:
	.align	2
.L3:
	.word	983042
	.size	__TR_clear_cache, .-__TR_clear_cache
	.ident	"GCC: (GNU) 4.2.1"
	.section	.note.GNU-stack,"",%progbits
