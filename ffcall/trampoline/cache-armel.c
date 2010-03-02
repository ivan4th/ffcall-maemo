/* Instruction cache flushing for arm */

/*
 * Copyright 1997 Bruno Haible, <bruno@clisp.org>
 *
 * This is free software distributed under the GNU General Public Licence
 * described in the file COPYING. Contact the author if you don't have this
 * or can't live with it. There is ABSOLUTELY NO WARRANTY, explicit or implied,
 * on this software.
 */
#include <linux/unistd.h>
#include <sys/syscall.h>

void __TR_clear_cache (char *first_addr, char *last_addr)
{
  register unsigned long beg asm("a1") = first_addr;
  register unsigned long end asm("a2") = last_addr;
  register unsigned long flg asm("a3") = 0;
  register unsigned long syscall_no asm("r7") = __ARM_NR_cacheflush;
  asm volatile(
               "swi 0x0"
               : "=r" (beg)
               : "0" (beg), "r" (end), "r" (flg), "r" (syscall_no));
}
