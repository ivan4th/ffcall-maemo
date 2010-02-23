/* vacall function for arm CPU */

/*
 * Copyright 1995-2004 Bruno Haible, <bruno@clisp.org>
 *
 * This is free software distributed under the GNU General Public Licence
 * described in the file COPYING. Contact the author if you don't have this
 * or can't live with it. There is ABSOLUTELY NO WARRANTY, explicit or implied,
 * on this software.
 */

#ifndef REENTRANT
#include "vacall.h.in"
#else /* REENTRANT */
#include "vacall_r.h.in"
#endif

#ifdef REENTRANT
#define __vacall __real_vacall_r
register struct { void (*vacall_function) (void*,va_alist); void* arg; }
         *		env	__asm__("r12");
#define _VACALL_STATIC static
#else
#define _VACALL_STATIC
#endif

/* armel have only softvfp which uses generic registers */
register __vaword	iret	__asm__("r0");
register __vaword	iret2	__asm__("r1");
register float		fret	__asm__("r0");
register __vaword	dret1	__asm__("r0");
register __vaword	dret2	__asm__("r1");

_VACALL_STATIC void /* the return type is variable, not void! */
__vacall (__vaword word1, __vaword word2, __vaword word3, __vaword word4,
          __vaword firstword)
{
  struct { long retaddr, sav1, sav2, sav3, sav4, arg1, arg2, arg3, arg4; } args;
  __va_alist list;
  /* MAGIC ALERT!
   * This is the last struct on the stack, so that
   * &args + 1 == &return_address == &firstword - 1.
   * Look at the assembly code to convince yourself.
   */
  /* Move the arguments passed in registers to their stack locations. */
  args.retaddr = (&firstword)[-1]; /* save the return address and saved registers */
  args.sav1 = (&firstword)[-2];
  args.sav2 = (&firstword)[-3];
  args.sav3 = (&firstword)[-4];
  args.sav4 = (&firstword)[-5];
  args.arg1 = word1;
  args.arg2 = word2;
  args.arg3 = word3;
  args.arg4 = word4;
  (&firstword)[-4] = args.arg1;
  (&firstword)[-3] = args.arg2;
  (&firstword)[-2] = args.arg3;
  (&firstword)[-1] = args.arg4;
  /* Prepare the va_alist. */
  list.flags = 0;
  list.aptr = (long)(&firstword - 4);
  list.raddr = (void*)0;
  list.rtype = __VAvoid;
  /* Call vacall_function. The macros do all the rest. */
#ifndef REENTRANT
  (*vacall_function) (&list);
#else /* REENTRANT */
  (*env->vacall_function) (env->arg,&list);
#endif
  /* Put return value into proper register. */
  if (list.rtype == __VAvoid) {
  } else
  if (list.rtype == __VAchar) {
    iret = list.tmp._char;
  } else
  if (list.rtype == __VAschar) {
    iret = list.tmp._schar;
  } else
  if (list.rtype == __VAuchar) {
    iret = list.tmp._uchar;
  } else
  if (list.rtype == __VAshort) {
    iret = list.tmp._short;
  } else
  if (list.rtype == __VAushort) {
    iret = list.tmp._ushort;
  } else
  if (list.rtype == __VAint) {
    iret = list.tmp._int;
  } else
  if (list.rtype == __VAuint) {
    iret = list.tmp._uint;
  } else
  if (list.rtype == __VAlong) {
    iret = list.tmp._long;
  } else
  if (list.rtype == __VAulong) {
    iret = list.tmp._ulong;
  } else
  if (list.rtype == __VAlonglong || list.rtype == __VAulonglong) {
    iret  = ((__vaword *) &list.tmp._longlong)[0];
    iret2 = ((__vaword *) &list.tmp._longlong)[1];
  } else
  if (list.rtype == __VAfloat) {
    fret = list.tmp._float;
  } else
  if (list.rtype == __VAdouble) {
      dret1 = ((__vaword *) &list.tmp._double)[0];
      dret2 = ((__vaword *) &list.tmp._double)[1];
  } else
  if (list.rtype == __VAvoidp) {
    iret = (long)list.tmp._ptr;
  } else
  if (list.rtype == __VAstruct) {
    /* NB: On arm, all structure sizes are divisible by 4. */
    if (list.flags & __VA_PCC_STRUCT_RETURN) {
      /* pcc struct return convention */
      iret = (long) list.raddr;
    } else {
      /* normal struct return convention */
      if (list.flags & __VA_REGISTER_STRUCT_RETURN) {
        if (list.rsize == sizeof(char)) { /* can't occur */
          iret = *(unsigned char *) list.raddr;
        } else
        if (list.rsize == sizeof(short)) { /* can't occur */
          iret = *(unsigned short *) list.raddr;
        } else
          iret = *(unsigned int *) list.raddr; /* struct of size 3 :) */
      }
    }
  }
  (&firstword)[-1] = args.retaddr; /* restore the return address and saved registers */
  (&firstword)[-2] = args.sav1;
  (&firstword)[-3] = args.sav2;
  (&firstword)[-4] = args.sav3;
  (&firstword)[-5] = args.sav4;
}

#ifdef REENTRANT
void __vacall_r ()
{
  __asm__("ldmfd sp!, {ip}\n\t"
          "b __real_vacall_r");
}

void* __vacall_ptr__ = __real_vacall_r;
#endif
