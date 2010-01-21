dnl Check for posix_memalign()

AC_DEFUN([CL_MEMALIGN],
[
AC_CHECK_FUNC(posix_memalign,[
  AC_DEFINE(HAVE_POSIX_MEMALIGN, 1, [whether memalign() is available])
])
])