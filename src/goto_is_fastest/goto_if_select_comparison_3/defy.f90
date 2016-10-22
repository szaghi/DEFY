! A DEFY (DEmystyfy Fortran mYths) test.
! Author: Stefano Zaghi
! Date: 2016-10-22
!
! License: this file is licensed under the Creative Commons Attribution 4.0 license,
! see http://creativecommons.org/licenses/by/4.0/ .

program defy
  use iso_fortran_env
  implicit none
  integer(int32), parameter :: tests_number = 3000
  integer(int32)            :: keyword
  integer(int32)            :: keywords(1:4,1:2)
  real(real64), allocatable :: key_work(:)
  integer(int64)            :: profiling(1:2)
  integer(int64)            :: count_rate
  real(real64)              :: system_clocks(1:3)
  integer(int32)            :: i
  integer(int32)            :: k
  integer(int32)            :: p

  keywords = 0
  ! keys value
  keywords(1,1) = 3
  keywords(2,1) = 4
  keywords(3,1) = 1
  keywords(4,1) = 2
  ! keys probability
  keywords(1,2) = 10
  keywords(2,2) = 8
  keywords(3,2) = 6
  keywords(4,2) = 4

  system_clocks = 0._real64
  do i=1, tests_number

    do k=1, size(keywords, dim=1)

      keyword = keywords(k, 1)

      do p=1, keywords(k, 2)

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
        endif
        call system_clock(profiling(2), count_rate)
        system_clocks(2) = system_clocks(2) + real(profiling(2) - profiling(1), kind=real64)/count_rate

        call system_clock(profiling(1), count_rate)
        goto (10, 20, 30, 40), keyword
        goto 50
        10 call worker1(key=keyword, array=key_work) ; goto 50
        20 call worker2(key=keyword, array=key_work) ; goto 50
        30 call worker3(key=keyword, array=key_work) ; goto 50
        40 call worker4(key=keyword, array=key_work) ; goto 50
        50 continue
        call system_clock(profiling(2), count_rate)
        system_clocks(3) = system_clocks(3) + real(profiling(2) - profiling(1), kind=real64)/count_rate
      enddo
    enddo
  enddo
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
endprogram defy
