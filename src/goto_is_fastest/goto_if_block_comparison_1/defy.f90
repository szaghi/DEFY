! A DEFY (DEmystyfy Fortran mYths) test.
! Author: Stefano Zaghi & Ron Shepard & FortranFan
! Date: 2016-10-19
!
! License: this file is licensed under the Creative Commons Attribution 4.0 license,
! see http://creativecommons.org/licenses/by/4.0/ .

program defy
  use iso_fortran_env
  implicit none
  integer(int32), parameter :: tests_number = 4000
  integer(int32)            :: keyword
  real(real64), allocatable :: key_work(:)
  real(real64)              :: random
  integer(int64)            :: profiling(1:2)
  integer(int64)            :: count_rate
  real(real64)              :: system_clocks(1:3)
  integer(int32)            :: key_registers(1:9)
  integer(int32)            :: i

  key_registers = 0
  system_clocks = 0._real64
  do i=1, tests_number
    call random_number(random)
    keyword = nint(random*9, int32)
    if (keyword==1) key_registers(1) = key_registers(1) + 1
    if (keyword==2) key_registers(2) = key_registers(2) + 1
    if (keyword==3) key_registers(3) = key_registers(3) + 1
    if (keyword==4) key_registers(4) = key_registers(4) + 1
    if (keyword==5) key_registers(5) = key_registers(5) + 1
    if (keyword==6) key_registers(6) = key_registers(6) + 1
    if (keyword==7) key_registers(7) = key_registers(7) + 1
    if (keyword==8) key_registers(8) = key_registers(8) + 1
    if (keyword==9) key_registers(9) = key_registers(9) + 1

    call system_clock(profiling(1), count_rate)
    selector: block
      call worker9(key=keyword, array=key_work) ; if ((keyword==9)) exit selector
      call worker8(key=keyword, array=key_work) ; if ((keyword>=8)) exit selector
      call worker7(key=keyword, array=key_work) ; if ((keyword>=7)) exit selector
      call worker6(key=keyword, array=key_work) ; if ((keyword>=6)) exit selector
      call worker5(key=keyword, array=key_work) ; if ((keyword>=5)) exit selector
      call worker4(key=keyword, array=key_work) ; if ((keyword>=4)) exit selector
      call worker3(key=keyword, array=key_work) ; if ((keyword>=3)) exit selector
      call worker2(key=keyword, array=key_work) ; if ((keyword>=2)) exit selector
      call worker1(key=keyword, array=key_work) ;                   exit selector
    end block selector
    call system_clock(profiling(2), count_rate)
    system_clocks(1) = system_clocks(1) + real(profiling(2) - profiling(1), kind=real64)/count_rate

    call system_clock(profiling(1), count_rate)
    if (keyword<2)  call worker1(key=keyword, array=key_work)
    if (keyword<3)  call worker2(key=keyword, array=key_work)
    if (keyword<4)  call worker3(key=keyword, array=key_work)
    if (keyword<5)  call worker4(key=keyword, array=key_work)
    if (keyword<6)  call worker5(key=keyword, array=key_work)
    if (keyword<7)  call worker6(key=keyword, array=key_work)
    if (keyword<8)  call worker7(key=keyword, array=key_work)
    if (keyword<9)  call worker8(key=keyword, array=key_work)
    if (keyword<10) call worker9(key=keyword, array=key_work)
    call system_clock(profiling(2), count_rate)
    system_clocks(2) = system_clocks(2) + real(profiling(2) - profiling(1), kind=real64)/count_rate

    call system_clock(profiling(1), count_rate)
    goto (10, 20, 30, 40, 50, 60, 70, 80, 90), keyword
    10 call worker1(key=keyword, array=key_work)
    20 call worker2(key=keyword, array=key_work)
    30 call worker3(key=keyword, array=key_work)
    40 call worker4(key=keyword, array=key_work)
    50 call worker5(key=keyword, array=key_work)
    60 call worker6(key=keyword, array=key_work)
    70 call worker7(key=keyword, array=key_work)
    80 call worker8(key=keyword, array=key_work)
    90 call worker9(key=keyword, array=key_work)
    call system_clock(profiling(2), count_rate)
    system_clocks(3) = system_clocks(3) + real(profiling(2) - profiling(1), kind=real64)/count_rate
  enddo
  print '(A,9F12.5)', ' keywords distribution (1,2,3): ', key_registers*1._real32/tests_number
  print '(A,E23.15)', ' block average performance:     ', system_clocks(2)/tests_number
  print '(A,E23.15)', ' if    average performance:     ', system_clocks(2)/tests_number
  print '(A,E23.15)', ' goto  average performance:     ', system_clocks(3)/tests_number

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
endprogram defy
