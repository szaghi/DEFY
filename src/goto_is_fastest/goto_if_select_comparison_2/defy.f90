! A DEFY (DEmystyfy Fortran mYths) test.
! Author: FortranFan
! Date: 2016-10-17
!
! License: this file is licensed under the Creative Commons Attribution 4.0 license,
! see http://creativecommons.org/licenses/by/4.0/ .

module mykinds_m
   !dec$ if defined (IFORT)

   use, intrinsic :: iso_fortran_env, only : I4 => int32, I8 => int64, WP => real64

   implicit none

   !dec$ else

   implicit none

   integer, parameter :: I8  = selected_int_kind(10)
   integer, parameter :: I4  = selected_int_kind(9)
   integer, parameter :: WP  = selected_real_kind(15,307)

   !dec$ endif

   real(WP), parameter :: ZERO = 0.0_wp

end module mykinds_m

module procs_m

   use mykinds_m, only : WP, ZERO

   implicit none

contains

   subroutine s1( n, r )

      include "i.f90"

   end subroutine s1

   subroutine s2( n, r )

      include "i.f90"

   end subroutine s2

   subroutine s3( n, r )

      include "i.f90"

   end subroutine s3

   subroutine s4( n, r )

      include "i.f90"

   end subroutine s4

   subroutine s5( n, r )

      include "i.f90"

   end subroutine s5

   subroutine s6( n, r )

      include "i.f90"

   end subroutine s6

   subroutine s7( n, r )

      include "i.f90"

   end subroutine s7

   subroutine s8( n, r )

      include "i.f90"

   end subroutine s8

   subroutine s9( n, r )

      include "i.f90"

   end subroutine s9

   subroutine s10( n, r )

      include "i.f90"

   end subroutine s10

end module procs_m

module m

   use procs_m

   implicit none

   private

   !dec$ if defined (IFORT)
   character(len=*), parameter, public :: keywords(*) = [ character(len=3) :: "s1", "s2", "s3",     &
      "s4", "s5", "s6", "s7", "s8", "s9", "s10" ]
   integer, parameter, public :: ikeys(*) = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
   !dec$ else
   integer, parameter :: MAXKEYS = 10
   character(len=3), parameter, public :: keywords(MAXKEYS) = [ "s1 ", "s2 ", "s3 ",                &
      "s4 ", "s5 ", "s6 ", "s7 ", "s8 ", "s9 ", "s10" ]
   integer, parameter, public :: ikeys(MAXKEYS) = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
   !dec$ endif

   public :: s_slc
   public :: s_cgt

contains

   subroutine s_slc( keyword, n, r )

      character(len=*), intent(in) :: keyword
      integer, intent(in)          :: n
      real(WP), intent(inout)      :: r

      select case ( keyword )

         case ( keywords(1) )

            call s1( n, r )

         case ( keywords(2) )

            call s2( n, r)

         case ( keywords(3) )

            call s3( n, r)

         case ( keywords(4) )

            call s4( n, r)

         case ( keywords(5) )

            call s5( n, r)

         case ( keywords(6) )

            call s6( n, r)

         case ( keywords(7) )

            call s7( n, r)

         case ( keywords(8) )

            call s8( n, r)

         case ( keywords(9) )

            call s9( n, r)

         case ( keywords(10) )

            call s10( n, r)

         case default

            print *, "s: invarid keyword of ", keyword
            return

      end select

      return

   end subroutine s_slc

   subroutine s_cgt( ikey, n, r )

      integer, intent(in)     :: ikey
      integer, intent(in)     :: n
      real(WP), intent(inout) :: r

      goto (1,2,3,4,5,6,7,8,9,10), ikey

    1 continue
      call s1( n, r )
      go to 99

    2 continue
      call s2( n, r )
      go to 99

    3 continue
      call s3( n, r )
      go to 99

    4 continue
      call s4( n, r )
      go to 99

    5 continue
      call s5( n, r )
      go to 99

    6 continue
      call s6( n, r )
      go to 99

    7 continue
      call s7( n, r )
      go to 99

    8 continue
      call s8( n, r )
      go to 99

    9 continue
      call s9( n, r )
      go to 99

   10 continue
      call s10( n, r )
      go to 99  ! wonder if compiler optimization eliminates this

99    continue
      return

   end subroutine s_cgt

end module m

module cpu_m

   use mykinds_m, only : IP => I8, WP

   implicit none

contains

   subroutine my_cpu_time( time )

      !.. Argument list
      real(WP), intent(inout) :: time

      !.. Local variables
      integer(IP) :: tick
      integer(IP) :: rate

      call system_clock (tick, rate)

      time = real(tick, kind=kind(time) ) / real(rate, kind=kind(time) )

      return

   end subroutine my_cpu_time

end module cpu_m

program defy

   use mykinds_m, only : WP, ZERO
   use m, only : s_slc, s_cgt, keywords
   use cpu_m, only : my_cpu_time

   implicit none

   !..
   integer, parameter :: MAXREPEAT = 10
   integer, parameter :: MAXTRIAL = 2**10
   integer :: Idx(MAXTRIAL)
   integer :: Counter
   integer :: j
   real(WP) :: Start_Time = ZERO
   real(WP) :: End_Time = ZERO
   real(WP) :: Ave_Time = ZERO
   real(WP) :: CpuTimes_SLC(MAXREPEAT)
   real(WP) :: CpuTimes_CGT(MAXREPEAT)
   real(WP) :: r(MAXTRIAL)
   real(WP) :: x_norm
   !dec$ if defined (IFORT)
   character(len=*), parameter :: FMT_CPU = "(a, t40, g0, a)"
   !dec$ else
   character(len=22), parameter :: FMT_CPU = "(A, T40, 1PG22.15, A)"
   !dec$ end if

   print *, "Mythbuster #1: SELECT CASE vs COMPUTED GOTO"
   print *

   CpuTimes_SLC = ZERO
   CpuTimes_CGT = ZERO

   print *, "SELECT CASE:"
   Loop_Repeat_Slc: do Counter = 1, MAXREPEAT

      print *, "   Trial ", Counter

      call random_number(r)
      Idx = int( r*10.0_wp, kind=kind(Idx) ) + 1

      !..
      call my_cpu_time(Start_Time)

      do j = 1, MAXTRIAL

         call s_slc( keywords( Idx(j) ), Idx(j), x_norm )

      end do

      call my_cpu_time(End_Time)

      CpuTimes_SLC(Counter) = (End_Time - Start_Time)

      write(*, fmt=FMT_CPU) "   CPU Time: ", CpuTimes_SLC(Counter), " seconds."

   end do Loop_Repeat_Slc

   print *, "COMPUTED GOTO:"
   Loop_Repeat_Cgt: do Counter = 1, MAXREPEAT

      print *, "   Trial ", Counter

      call random_number(r)
      Idx = int( r*10.0_wp, kind=kind(Idx) ) + 1

      !..
      call my_cpu_time(Start_Time)

      do j = 1, MAXTRIAL

         call s_cgt( Idx(j), Idx(j), x_norm )

      end do

      call my_cpu_time(End_Time)

      CpuTimes_CGT(Counter) = (End_Time - Start_Time)

      write(*, fmt=FMT_CPU) "   CPU Time: ", CpuTimes_CGT(Counter), " seconds."

   end do Loop_Repeat_Cgt

   !.. Average CPU time: exclude highest and lowest values
   Ave_Time = sum(CpuTimes_SLC)
   Ave_Time = Ave_Time - maxval(CpuTimes_SLC) - minval(CpuTimes_SLC)
   Ave_Time = Ave_Time/real(MAXREPEAT-2, kind=WP)
   write(*, fmt=FMT_CPU) "SELECT CASE: Average CPU Time ", Ave_Time," seconds."

   !.. Average CPU time: exclude highest and lowest values
   Ave_Time = sum(CpuTimes_CGT)
   Ave_Time = Ave_Time - maxval(CpuTimes_CGT) - minval(CpuTimes_CGT)
   Ave_Time = Ave_Time/real(MAXREPEAT-2, kind=WP)
   write(*, fmt=FMT_CPU) "COMPUTED GOTO: Average CPU Time ", Ave_Time," seconds."

   !..
   stop

end program defy
