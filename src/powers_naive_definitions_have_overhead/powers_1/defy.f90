! A DEFY (DEmystyfy Fortran mYths) test.
! Author: https://github.com/zmiimz
! Date: 2016-06-19
!
! License: this file is licensed under the Creative Commons Attribution 4.0 license,
! see http://creativecommons.org/licenses/by/4.0/ .

program defy
  use iso_fortran_env
   implicit none
   integer(int32)             :: i
   integer(int32), parameter  :: s = 10000000
   real(real64)               :: a
   real(real64), dimension(s) :: b1, b2, b3, b4, b5, b6, b7
   integer(int64)             :: profiling(1:2)
   integer(int64)             :: count_rate
   character(len=11)          :: fmt = '(A30,F12.6)'

   call system_clock(profiling(1), count_rate)
   do i = 1, s
      a = real(i,real64)
      b1(i) = a*a
   enddo
   call system_clock(profiling(2), count_rate)
   write(*,fmt) "a*a elapsed time = ", real(profiling(2) - profiling(1), kind=real64)/count_rate

   call system_clock(profiling(1), count_rate)
   do i = 1, s
      a = real(i,real64)
      b2(i) = a**2
   enddo
   call system_clock(profiling(2), count_rate)
   write(*,fmt) "a**2 elapsed time = ", real(profiling(2) - profiling(1), kind=real64)/count_rate

   call system_clock(profiling(1), count_rate)
   do i = 1, s
      a = real(i,real64)
      b3(i) = a**2.0
   enddo
   call system_clock(profiling(2), count_rate)
   write(*,fmt) "a**2.0 elapsed time = ", real(profiling(2) - profiling(1), kind=real64)/count_rate

   call system_clock(profiling(1), count_rate)
   do i = 1, s
      a = real(i,real64)
      b4(i) = a**2.0_real64
   enddo
   call system_clock(profiling(2), count_rate)
   write(*,fmt) "a**2.0_real64 elapsed time = ", real(profiling(2) - profiling(1), kind=real64)/count_rate

   call system_clock(profiling(1), count_rate)
   do i = 1, s
      a = real(i,real64)
      b5(i) = sqrt(a)
   enddo
   call system_clock(profiling(2), count_rate)
   write(*,fmt) "sqrt(a) elapsed time = ", real(profiling(2) - profiling(1), kind=real64)/count_rate

   call system_clock(profiling(1), count_rate)
   do i = 1, s
      a = real(i,real64)
      b6(i) = a**0.5
   enddo
   call system_clock(profiling(2), count_rate)
   write(*,fmt) "a**0.5 elapsed time = ", real(profiling(2) - profiling(1), kind=real64)/count_rate

   call system_clock(profiling(1), count_rate)
   do i = 1, s
      a = real(i,real64)
      b7(i) = a**0.5_real64
   enddo
   call system_clock(profiling(2), count_rate)
   write(*,fmt) "a**0.5_real64 elapsed time = ", real(profiling(2) - profiling(1), kind=real64)/count_rate

   ! to force bx loops computation
   do i = 1, s
      if(b1(i) /= b2(i)) error stop "error"
      if(b1(i) /= b3(i)) error stop "error"
      if(b1(i) /= b4(i)) error stop "error"
      if(b5(i) /= b6(i)) error stop "error"
      if(b5(i) /= b7(i)) error stop "error"
   enddo
end program defy
