@ Trampoline for arm CPU

@ Copyright 1995-1997 Bruno Haible, <bruno@clisp.org>
@
@ This is free software distributed under the GNU General Public Licence
@ described in the file COPYING. Contact the author if you don't have this
@ or can't live with it. There is ABSOLUTELY NO WARRANTY, explicit or implied,
@ on this software.

@ Available registers: ip.

.text
	.align	0
	.global	_tramp
_tramp:
	@ Immediate constants are a problem. I take the indirect load approach
	@ because I don't want 4 instructions for each constant.
	add	ip,pc,#12
        stmfd   sp!,{ip}
	ldr	pc,[pc]

	.global	_data
	.align	0
_data:
	.word	0x73554711

	.align	0
_function:
	.word	0xbabebec0
	.global	_function
