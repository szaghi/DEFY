! A DEFY (DEmystyfy Fortran mYths) test.
! Author: Stefano Zaghi and FortranFan
! Date: 2016-10-26
!
! License: this file is licensed under the Creative Commons Attribution 4.0 license,
! see http://creativecommons.org/licenses/by/4.0/ .

module m

   implicit none
   public

   integer, parameter :: int64  = selected_int_kind(10)
   integer, parameter :: int32  = selected_int_kind(9)
   integer, parameter :: real64 = selected_real_kind(15,307)

   !.. Mnemonic constants
   integer(int32), parameter :: MAXTESTS = 1000
   real(real64),   parameter :: HUNDRED = 100.0_real64
   real(real64),   parameter :: TWO = 2.0_real64
   real(real64),   parameter :: ZERO = 0.0_real64

   real(real64), allocatable :: key_work(:)
contains
   subroutine test_select()
     real(real64)   :: timing
     integer(int32) :: keyword
     integer(int32) :: key_registers(1:20)
     integer(int64) :: profiling(1:2)
     integer(int64) :: count_rate
     integer(int32) :: i

     timing = ZERO
     key_registers = 0
     do i=1, MAXTESTS
       call get_keyword(key_registers=key_registers, keyword=keyword)
       call system_clock(profiling(1), count_rate)
       select case(keyword)
       case(1)
         call worker1(key=keyword, array=key_work)
       case(2)
         call worker2(key=keyword, array=key_work)
       case(3)
         call worker3(key=keyword, array=key_work)
       case(4)
         call worker4(key=keyword, array=key_work)
       case(5)
         call worker5(key=keyword, array=key_work)
       case(6)
         call worker6(key=keyword, array=key_work)
       case(7)
         call worker7(key=keyword, array=key_work)
       case(8)
         call worker8(key=keyword, array=key_work)
       case(9)
         call worker9(key=keyword, array=key_work)
       case(10)
         call worker10(key=keyword, array=key_work)
       case(11)
         call worker11(key=keyword, array=key_work)
       case(12)
         call worker12(key=keyword, array=key_work)
       case(13)
         call worker13(key=keyword, array=key_work)
       case(14)
         call worker14(key=keyword, array=key_work)
       case(15)
         call worker15(key=keyword, array=key_work)
       case(16)
         call worker16(key=keyword, array=key_work)
       case(17)
         call worker17(key=keyword, array=key_work)
       case(18)
         call worker18(key=keyword, array=key_work)
       case(19)
         call worker19(key=keyword, array=key_work)
       case(20)
         call worker20(key=keyword, array=key_work)
       end select
       call system_clock(profiling(2), count_rate)
       timing = timing + real(profiling(2) - profiling(1), kind=real64)/count_rate
     end do
     print '(A,20(F4.2,"%",1X))', ' keywords distribution (1--20): ', key_registers*HUNDRED/MAXTESTS
     print '(A,E23.15)', ' select case average performance: ', timing/MAXTESTS
   end subroutine test_select

   subroutine test_if()
     real(real64)   :: timing
     integer(int32) :: keyword
     integer(int32) :: key_registers(1:20)
     integer(int64) :: profiling(1:2)
     integer(int64) :: count_rate
     integer(int32) :: i

     timing = ZERO
     key_registers = 0
     do i=1, MAXTESTS
       call get_keyword(key_registers=key_registers, keyword=keyword)
       call system_clock(profiling(1), count_rate)
       if (keyword==1) then
         call worker1(key=keyword, array=key_work)
       elseif (keyword==2) then
         call worker2(key=keyword, array=key_work)
       elseif (keyword==3) then
         call worker3(key=keyword, array=key_work)
       elseif (keyword==4) then
         call worker4(key=keyword, array=key_work)
       elseif (keyword==5) then
         call worker5(key=keyword, array=key_work)
       elseif (keyword==6) then
         call worker6(key=keyword, array=key_work)
       elseif (keyword==7) then
         call worker7(key=keyword, array=key_work)
       elseif (keyword==8) then
         call worker8(key=keyword, array=key_work)
       elseif (keyword==9) then
         call worker9(key=keyword, array=key_work)
       elseif (keyword==10) then
         call worker10(key=keyword, array=key_work)
       elseif (keyword==11) then
         call worker11(key=keyword, array=key_work)
       elseif (keyword==12) then
         call worker12(key=keyword, array=key_work)
       elseif (keyword==13) then
         call worker13(key=keyword, array=key_work)
       elseif (keyword==14) then
         call worker14(key=keyword, array=key_work)
       elseif (keyword==15) then
         call worker15(key=keyword, array=key_work)
       elseif (keyword==16) then
         call worker16(key=keyword, array=key_work)
       elseif (keyword==17) then
         call worker17(key=keyword, array=key_work)
       elseif (keyword==18) then
         call worker18(key=keyword, array=key_work)
       elseif (keyword==19) then
         call worker19(key=keyword, array=key_work)
       elseif (keyword==20) then
         call worker20(key=keyword, array=key_work)
       end if
       call system_clock(profiling(2), count_rate)
       timing = timing + real(profiling(2) - profiling(1), kind=real64)/count_rate
     end do
     print '(A,20(F4.2,"%",1X))', ' keywords distribution (1--20): ', key_registers*HUNDRED/MAXTESTS
     print '(A,E23.15)', ' if elseif   average performance: ', timing/MAXTESTS
   end subroutine test_if

   subroutine test_goto()
     real(real64)   :: timing
     integer(int32) :: keyword
     integer(int32) :: key_registers(1:20)
     integer(int64) :: profiling(1:2)
     integer(int64) :: count_rate
     integer(int32) :: i

     timing = ZERO
     key_registers = 0
     do i=1, MAXTESTS
       call get_keyword(key_registers=key_registers, keyword=keyword)
       call system_clock(profiling(1), count_rate)
       goto (10, 20, 30, 40, 50, 60, 70, 80, 90, 100, 110, 120, 130, 140, 150, 160, 170, 180, 190, 200), keyword
       goto 210
       10  call worker1( key=keyword, array=key_work) ; goto 210
       20  call worker2( key=keyword, array=key_work) ; goto 210
       30  call worker3( key=keyword, array=key_work) ; goto 210
       40  call worker4( key=keyword, array=key_work) ; goto 210
       50  call worker5( key=keyword, array=key_work) ; goto 210
       60  call worker6( key=keyword, array=key_work) ; goto 210
       70  call worker7( key=keyword, array=key_work) ; goto 210
       80  call worker8( key=keyword, array=key_work) ; goto 210
       90  call worker9( key=keyword, array=key_work) ; goto 210
       100 call worker10(key=keyword, array=key_work) ; goto 210
       110 call worker11(key=keyword, array=key_work) ; goto 210
       120 call worker12(key=keyword, array=key_work) ; goto 210
       130 call worker13(key=keyword, array=key_work) ; goto 210
       140 call worker14(key=keyword, array=key_work) ; goto 210
       150 call worker15(key=keyword, array=key_work) ; goto 210
       160 call worker16(key=keyword, array=key_work) ; goto 210
       170 call worker17(key=keyword, array=key_work) ; goto 210
       180 call worker18(key=keyword, array=key_work) ; goto 210
       190 call worker19(key=keyword, array=key_work) ; goto 210
       200 call worker20(key=keyword, array=key_work) ; goto 210
       210 continue
       call system_clock(profiling(2), count_rate)
       timing = timing + real(profiling(2) - profiling(1), kind=real64)/count_rate
     end do
     print '(A,20(F4.2,"%",1X))', ' keywords distribution (1--20): ', key_registers*HUNDRED/MAXTESTS
     print '(A,E23.15)', ' goto        average performance: ', timing/MAXTESTS
   end subroutine test_goto

   subroutine get_keyword(keyword, key_registers)
     integer(int32), intent(inout) :: key_registers(1:)
     integer(int32), intent(out)   :: keyword
     real(real64)                  :: random
     integer(int32)                :: keys_number
     integer(int32)                :: k

     keys_number = size(key_registers, dim=1)
     call random_number(random)
     keyword = nint(random*keys_number, int32)
     do k=1, keys_number
       if (keyword==k) key_registers(k) = key_registers(k) + 1
     end do
   end subroutine get_keyword

   pure subroutine worker1(key, array)
     integer(int32),            intent(in)  :: key
     real(real64), allocatable, intent(out) :: array(:)
     integer(int32)                         :: j

     allocate(array(1:key*MAXTESTS))
     array = ZERO
     do j=1, key*MAXTESTS
       array(j) = key**TWO * MAXTESTS * j
     end do
   end subroutine worker1

   pure subroutine worker2(key, array)
     integer(int32),            intent(in)  :: key
     real(real64), allocatable, intent(out) :: array(:)
     integer(int32)                         :: j

     allocate(array(1:key*MAXTESTS))
     array = ZERO
     do j=1, key*MAXTESTS
       array(j) = key**TWO * MAXTESTS * j
     end do
   end subroutine worker2

   pure subroutine worker3(key, array)
     integer(int32),            intent(in)  :: key
     real(real64), allocatable, intent(out) :: array(:)
     integer(int32)                         :: j

     allocate(array(1:key*MAXTESTS))
     array = ZERO
     do j=1, key*MAXTESTS
       array(j) = key**TWO * MAXTESTS * j
     end do
   end subroutine worker3

   pure subroutine worker4(key, array)
     integer(int32),            intent(in)  :: key
     real(real64), allocatable, intent(out) :: array(:)
     integer(int32)                         :: j

     allocate(array(1:key*MAXTESTS))
     array = ZERO
     do j=1, key*MAXTESTS
       array(j) = key**TWO * MAXTESTS * j
     end do
   end subroutine worker4

   pure subroutine worker5(key, array)
     integer(int32),            intent(in)  :: key
     real(real64), allocatable, intent(out) :: array(:)
     integer(int32)                         :: j

     allocate(array(1:key*MAXTESTS))
     array = ZERO
     do j=1, key*MAXTESTS
       array(j) = key**TWO * MAXTESTS * j
     end do
   end subroutine worker5

   pure subroutine worker6(key, array)
     integer(int32),            intent(in)  :: key
     real(real64), allocatable, intent(out) :: array(:)
     integer(int32)                         :: j

     allocate(array(1:key*MAXTESTS))
     array = ZERO
     do j=1, key*MAXTESTS
       array(j) = key**TWO * MAXTESTS * j
     end do
   end subroutine worker6

   pure subroutine worker7(key, array)
     integer(int32),            intent(in)  :: key
     real(real64), allocatable, intent(out) :: array(:)
     integer(int32)                         :: j

     allocate(array(1:key*MAXTESTS))
     array = ZERO
     do j=1, key*MAXTESTS
       array(j) = key**TWO * MAXTESTS * j
     end do
   end subroutine worker7

   pure subroutine worker8(key, array)
     integer(int32),            intent(in)  :: key
     real(real64), allocatable, intent(out) :: array(:)
     integer(int32)                         :: j

     allocate(array(1:key*MAXTESTS))
     array = ZERO
     do j=1, key*MAXTESTS
       array(j) = key**TWO * MAXTESTS * j
     end do
   end subroutine worker8

   pure subroutine worker9(key, array)
     integer(int32),            intent(in)  :: key
     real(real64), allocatable, intent(out) :: array(:)
     integer(int32)                         :: j

     allocate(array(1:key*MAXTESTS))
     array = ZERO
     do j=1, key*MAXTESTS
       array(j) = key**TWO * MAXTESTS * j
     end do
   end subroutine worker9

   pure subroutine worker10(key, array)
     integer(int32),            intent(in)  :: key
     real(real64), allocatable, intent(out) :: array(:)
     integer(int32)                         :: j

     allocate(array(1:key*MAXTESTS))
     array = ZERO
     do j=1, key*MAXTESTS
       array(j) = key**TWO * MAXTESTS * j
     end do
   end subroutine worker10

   pure subroutine worker11(key, array)
     integer(int32),            intent(in)  :: key
     real(real64), allocatable, intent(out) :: array(:)
     integer(int32)                         :: j

     allocate(array(1:key*MAXTESTS))
     array = ZERO
     do j=1, key*MAXTESTS
       array(j) = key**TWO * MAXTESTS * j
     end do
   end subroutine worker11

   pure subroutine worker12(key, array)
     integer(int32),            intent(in)  :: key
     real(real64), allocatable, intent(out) :: array(:)
     integer(int32)                         :: j

     allocate(array(1:key*MAXTESTS))
     array = ZERO
     do j=1, key*MAXTESTS
       array(j) = key**TWO * MAXTESTS * j
     end do
   end subroutine worker12

   pure subroutine worker13(key, array)
     integer(int32),            intent(in)  :: key
     real(real64), allocatable, intent(out) :: array(:)
     integer(int32)                         :: j

     allocate(array(1:key*MAXTESTS))
     array = ZERO
     do j=1, key*MAXTESTS
       array(j) = key**TWO * MAXTESTS * j
     end do
   end subroutine worker13

   pure subroutine worker14(key, array)
     integer(int32),            intent(in)  :: key
     real(real64), allocatable, intent(out) :: array(:)
     integer(int32)                         :: j

     allocate(array(1:key*MAXTESTS))
     array = ZERO
     do j=1, key*MAXTESTS
       array(j) = key**TWO * MAXTESTS * j
     end do
   end subroutine worker14

   pure subroutine worker15(key, array)
     integer(int32),            intent(in)  :: key
     real(real64), allocatable, intent(out) :: array(:)
     integer(int32)                         :: j

     allocate(array(1:key*MAXTESTS))
     array = ZERO
     do j=1, key*MAXTESTS
       array(j) = key**TWO * MAXTESTS * j
     end do
   end subroutine worker15

   pure subroutine worker16(key, array)
     integer(int32),            intent(in)  :: key
     real(real64), allocatable, intent(out) :: array(:)
     integer(int32)                         :: j

     allocate(array(1:key*MAXTESTS))
     array = ZERO
     do j=1, key*MAXTESTS
       array(j) = key**TWO * MAXTESTS * j
     end do
   end subroutine worker16

   pure subroutine worker17(key, array)
     integer(int32),            intent(in)  :: key
     real(real64), allocatable, intent(out) :: array(:)
     integer(int32)                         :: j

     allocate(array(1:key*MAXTESTS))
     array = ZERO
     do j=1, key*MAXTESTS
       array(j) = key**TWO * MAXTESTS * j
     end do
   end subroutine worker17

   pure subroutine worker18(key, array)
     integer(int32),            intent(in)  :: key
     real(real64), allocatable, intent(out) :: array(:)
     integer(int32)                         :: j

     allocate(array(1:key*MAXTESTS))
     array = ZERO
     do j=1, key*MAXTESTS
       array(j) = key**TWO * MAXTESTS * j
     end do
   end subroutine worker18

   pure subroutine worker19(key, array)
     integer(int32),            intent(in)  :: key
     real(real64), allocatable, intent(out) :: array(:)
     integer(int32)                         :: j

     allocate(array(1:key*MAXTESTS))
     array = ZERO
     do j=1, key*MAXTESTS
       array(j) = key**TWO * MAXTESTS * j
     end do
   end subroutine worker19

   pure subroutine worker20(key, array)
     integer(int32),            intent(in)  :: key
     real(real64), allocatable, intent(out) :: array(:)
     integer(int32)                         :: j

     allocate(array(1:key*MAXTESTS))
     array = ZERO
     do j=1, key*MAXTESTS
       array(j) = key**TWO * MAXTESTS * j
     end do
   end subroutine worker20

end module m

program defy

   use m, only : test_select, test_if, test_goto

   implicit none

   call test_select()
   call test_if()
   call test_goto()
end program defy
