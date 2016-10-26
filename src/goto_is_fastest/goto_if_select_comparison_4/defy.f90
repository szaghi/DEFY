! A DEFY (DEmystyfy Fortran mYths) test.
! Author: Stefano Zaghi
! Date: 2016-10-26
!
! License: this file is licensed under the Creative Commons Attribution 4.0 license,
! see http://creativecommons.org/licenses/by/4.0/ .

program defy
  use iso_fortran_env
  implicit none
  integer(int32), parameter :: tests_number = 10000
  integer(int32)            :: keyword
  real(real64), allocatable :: key_work(:)
  real(real64)              :: random
  integer(int64)            :: profiling(1:2)
  integer(int64)            :: count_rate
  real(real64)              :: system_clocks(1:3)
  integer(int32)            :: key_registers(1:20)
  integer(int32)            :: i

  key_registers = 0
  system_clocks = 0._real64
  do i=1, tests_number
    call random_number(random)
    keyword = nint(random*20, int32)
    if (keyword==1 ) key_registers(1 ) = key_registers(1 ) + 1
    if (keyword==2 ) key_registers(2 ) = key_registers(2 ) + 1
    if (keyword==3 ) key_registers(3 ) = key_registers(3 ) + 1
    if (keyword==4 ) key_registers(4 ) = key_registers(4 ) + 1
    if (keyword==5 ) key_registers(5 ) = key_registers(5 ) + 1
    if (keyword==6 ) key_registers(6 ) = key_registers(6 ) + 1
    if (keyword==7 ) key_registers(7 ) = key_registers(7 ) + 1
    if (keyword==8 ) key_registers(8 ) = key_registers(8 ) + 1
    if (keyword==9 ) key_registers(9 ) = key_registers(9 ) + 1
    if (keyword==10) key_registers(10) = key_registers(10) + 1
    if (keyword==11) key_registers(11) = key_registers(11) + 1
    if (keyword==12) key_registers(12) = key_registers(12) + 1
    if (keyword==13) key_registers(13) = key_registers(13) + 1
    if (keyword==14) key_registers(14) = key_registers(14) + 1
    if (keyword==15) key_registers(15) = key_registers(15) + 1
    if (keyword==16) key_registers(16) = key_registers(16) + 1
    if (keyword==17) key_registers(17) = key_registers(17) + 1
    if (keyword==18) key_registers(18) = key_registers(18) + 1
    if (keyword==19) key_registers(19) = key_registers(19) + 1
    if (keyword==20) key_registers(20) = key_registers(20) + 1

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
    endselect
    call system_clock(profiling(2), count_rate)
    system_clocks(1) = system_clocks(1) + real(profiling(2) - profiling(1), kind=real64)/count_rate

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
    endif
    call system_clock(profiling(2), count_rate)
    system_clocks(2) = system_clocks(2) + real(profiling(2) - profiling(1), kind=real64)/count_rate

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
    system_clocks(3) = system_clocks(3) + real(profiling(2) - profiling(1), kind=real64)/count_rate
  enddo
  print '(A,20(F4.2,"%",1X))', ' keywords distribution (1--20): ', key_registers*100._real32/tests_number
  print '(A,E23.15)', ' select case average performance: ', system_clocks(1)/tests_number
  print '(A,E23.15)', ' if elseif   average performance: ', system_clocks(2)/tests_number
  print '(A,E23.15)', ' goto        average performance: ', system_clocks(3)/tests_number

  contains
    pure subroutine worker1(key, array)
      integer(int32),            intent(in)  :: key
      real(real64), allocatable, intent(out) :: array(:)
      integer(int32)                         :: j

      allocate(array(1:key*tests_number))
      array = 0._real64
      do j=1, key*tests_number
        array(j) = key**2._real64 * tests_number * j
      enddo
    endsubroutine worker1

    pure subroutine worker2(key, array)
      integer(int32),            intent(in)  :: key
      real(real64), allocatable, intent(out) :: array(:)
      integer(int32)                         :: j

      allocate(array(1:key*tests_number))
      array = 0._real64
      do j=1, key*tests_number
        array(j) = key**2._real64 * tests_number * j
      enddo
    endsubroutine worker2

    pure subroutine worker3(key, array)
      integer(int32),            intent(in)  :: key
      real(real64), allocatable, intent(out) :: array(:)
      integer(int32)                         :: j

      allocate(array(1:key*tests_number))
      array = 0._real64
      do j=1, key*tests_number
        array(j) = key**2._real64 * tests_number * j
      enddo
    endsubroutine worker3

    pure subroutine worker4(key, array)
      integer(int32),            intent(in)  :: key
      real(real64), allocatable, intent(out) :: array(:)
      integer(int32)                         :: j

      allocate(array(1:key*tests_number))
      array = 0._real64
      do j=1, key*tests_number
        array(j) = key**2._real64 * tests_number * j
      enddo
    endsubroutine worker4

    pure subroutine worker5(key, array)
      integer(int32),            intent(in)  :: key
      real(real64), allocatable, intent(out) :: array(:)
      integer(int32)                         :: j

      allocate(array(1:key*tests_number))
      array = 0._real64
      do j=1, key*tests_number
        array(j) = key**2._real64 * tests_number * j
      enddo
    endsubroutine worker5

    pure subroutine worker6(key, array)
      integer(int32),            intent(in)  :: key
      real(real64), allocatable, intent(out) :: array(:)
      integer(int32)                         :: j

      allocate(array(1:key*tests_number))
      array = 0._real64
      do j=1, key*tests_number
        array(j) = key**2._real64 * tests_number * j
      enddo
    endsubroutine worker6

    pure subroutine worker7(key, array)
      integer(int32),            intent(in)  :: key
      real(real64), allocatable, intent(out) :: array(:)
      integer(int32)                         :: j

      allocate(array(1:key*tests_number))
      array = 0._real64
      do j=1, key*tests_number
        array(j) = key**2._real64 * tests_number * j
      enddo
    endsubroutine worker7

    pure subroutine worker8(key, array)
      integer(int32),            intent(in)  :: key
      real(real64), allocatable, intent(out) :: array(:)
      integer(int32)                         :: j

      allocate(array(1:key*tests_number))
      array = 0._real64
      do j=1, key*tests_number
        array(j) = key**2._real64 * tests_number * j
      enddo
    endsubroutine worker8

    pure subroutine worker9(key, array)
      integer(int32),            intent(in)  :: key
      real(real64), allocatable, intent(out) :: array(:)
      integer(int32)                         :: j

      allocate(array(1:key*tests_number))
      array = 0._real64
      do j=1, key*tests_number
        array(j) = key**2._real64 * tests_number * j
      enddo
    endsubroutine worker9

    pure subroutine worker10(key, array)
      integer(int32),            intent(in)  :: key
      real(real64), allocatable, intent(out) :: array(:)
      integer(int32)                         :: j

      allocate(array(1:key*tests_number))
      array = 0._real64
      do j=1, key*tests_number
        array(j) = key**2._real64 * tests_number * j
      enddo
    endsubroutine worker10

    pure subroutine worker11(key, array)
      integer(int32),            intent(in)  :: key
      real(real64), allocatable, intent(out) :: array(:)
      integer(int32)                         :: j

      allocate(array(1:key*tests_number))
      array = 0._real64
      do j=1, key*tests_number
        array(j) = key**2._real64 * tests_number * j
      enddo
    endsubroutine worker11

    pure subroutine worker12(key, array)
      integer(int32),            intent(in)  :: key
      real(real64), allocatable, intent(out) :: array(:)
      integer(int32)                         :: j

      allocate(array(1:key*tests_number))
      array = 0._real64
      do j=1, key*tests_number
        array(j) = key**2._real64 * tests_number * j
      enddo
    endsubroutine worker12

    pure subroutine worker13(key, array)
      integer(int32),            intent(in)  :: key
      real(real64), allocatable, intent(out) :: array(:)
      integer(int32)                         :: j

      allocate(array(1:key*tests_number))
      array = 0._real64
      do j=1, key*tests_number
        array(j) = key**2._real64 * tests_number * j
      enddo
    endsubroutine worker13

    pure subroutine worker14(key, array)
      integer(int32),            intent(in)  :: key
      real(real64), allocatable, intent(out) :: array(:)
      integer(int32)                         :: j

      allocate(array(1:key*tests_number))
      array = 0._real64
      do j=1, key*tests_number
        array(j) = key**2._real64 * tests_number * j
      enddo
    endsubroutine worker14

    pure subroutine worker15(key, array)
      integer(int32),            intent(in)  :: key
      real(real64), allocatable, intent(out) :: array(:)
      integer(int32)                         :: j

      allocate(array(1:key*tests_number))
      array = 0._real64
      do j=1, key*tests_number
        array(j) = key**2._real64 * tests_number * j
      enddo
    endsubroutine worker15

    pure subroutine worker16(key, array)
      integer(int32),            intent(in)  :: key
      real(real64), allocatable, intent(out) :: array(:)
      integer(int32)                         :: j

      allocate(array(1:key*tests_number))
      array = 0._real64
      do j=1, key*tests_number
        array(j) = key**2._real64 * tests_number * j
      enddo
    endsubroutine worker16

    pure subroutine worker17(key, array)
      integer(int32),            intent(in)  :: key
      real(real64), allocatable, intent(out) :: array(:)
      integer(int32)                         :: j

      allocate(array(1:key*tests_number))
      array = 0._real64
      do j=1, key*tests_number
        array(j) = key**2._real64 * tests_number * j
      enddo
    endsubroutine worker17

    pure subroutine worker18(key, array)
      integer(int32),            intent(in)  :: key
      real(real64), allocatable, intent(out) :: array(:)
      integer(int32)                         :: j

      allocate(array(1:key*tests_number))
      array = 0._real64
      do j=1, key*tests_number
        array(j) = key**2._real64 * tests_number * j
      enddo
    endsubroutine worker18

    pure subroutine worker19(key, array)
      integer(int32),            intent(in)  :: key
      real(real64), allocatable, intent(out) :: array(:)
      integer(int32)                         :: j

      allocate(array(1:key*tests_number))
      array = 0._real64
      do j=1, key*tests_number
        array(j) = key**2._real64 * tests_number * j
      enddo
    endsubroutine worker19

    pure subroutine worker20(key, array)
      integer(int32),            intent(in)  :: key
      real(real64), allocatable, intent(out) :: array(:)
      integer(int32)                         :: j

      allocate(array(1:key*tests_number))
      array = 0._real64
      do j=1, key*tests_number
        array(j) = key**2._real64 * tests_number * j
      enddo
    endsubroutine worker20
endprogram defy
