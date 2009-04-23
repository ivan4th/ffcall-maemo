dnl -*- Autoconf -*-
dnl Copyright (C) 1993-2009 Free Software Foundation, Inc.
dnl This file is free software, distributed under the terms of the GNU
dnl General Public License.  As a special exception to the GNU General
dnl Public License, this file may be distributed as part of a program
dnl that contains a configuration script generated by Autoconf, under
dnl the same distribution terms as the rest of that program.

dnl From Bruno Haible, Marcus Daniels, Sam Steingold.

AC_PREREQ(2.13)

AC_DEFUN([FFCALL_CODEEXEC],[dnl
DOC=["whether code in malloc'ed memory is executable"]
AC_CACHE_CHECK($DOC, ffcall_cv_codeexec, [dnl
dnl The test below does not work on host=hppa*-hp-hpux* because on this system
dnl function pointers are actually pointers into(!) a two-pointer struct.
dnl The test below does not work on host=rs6000-*-* because on this system
dnl function pointers are actually pointers to a three-pointer struct.
case "$host_os" in
  hpux*) ffcall_cv_codeexec="guessing yes" ;;
  *)
case "$host_cpu_abi"-"$host_os" in
  # On host=rs6000-*-aix3.2.5 malloc'ed memory is indeed not executable.
  powerpc-aix*) ffcall_cv_codeexec="guessing no" ;;
  *)
AC_TRY_RUN(GL_NOCRASH[
#include <sys/types.h>
/* declare malloc() */
#include <stdlib.h>
int fun () { return 31415926; }
int main ()
{ nocrash_init();
 {long size = (char*)&main - (char*)&fun;
  char* funcopy = (char*) malloc(size);
  int i;
  for (i = 0; i < size; i++) { funcopy[i] = ((char*)&fun)[i]; }
  return !((*(int(*)())funcopy)() == 31415926);
}}], ffcall_cv_codeexec=yes, ffcall_cv_codeexec=no,
ffcall_cv_codeexec="guessing yes")
  ;;
esac
  ;;
esac
])
case "$ffcall_cv_codeexec" in
  *yes) AC_DEFINE([CODE_EXECUTABLE], [], $DOC) ;;
  *no)  ;;
esac
])
