! A DEFY (DEmystyfy Fortran mYths) test.
! Author: Stefano Zaghi
! Date: 2016-01-26
!
! License: this file is licensed under the Creative Commons Attribution 4.0 license,
! see http://creativecommons.org/licenses/by/4.0/ .

module constants
  use iso_fortran_env
  implicit none
  private
  integer(int32), parameter, public :: n = 1e9
  integer(int32), parameter, public :: m = 1e3
end module constants

module base_t
  use iso_fortran_env
  use constants, only : m
  implicit none
  private

  type, abstract, public :: base
    real(real64) :: x(m)
    contains
      procedure(base_add), deferred, pass(self) :: add
  end type

  abstract interface
    subroutine base_add(self, ndx, val)
      import :: base, int32, real64
      class(base),    intent(inout) :: self
      integer(int32), intent(in)    :: ndx
      real(real64),   intent(in)    :: val
    end subroutine
  end interface
end module base_t

module derived_t
  use iso_fortran_env
  use base_t, only : base
  implicit none
  private

  type, extends(base), public :: derived
    contains
      procedure, pass(self) :: add => derived_add
  end type

  contains
    subroutine derived_add(self, ndx, val)
      class(derived), intent(inout) :: self
      integer(int32), intent(in)    :: ndx
      real(real64),   intent(in)    :: val

      self%x(ndx) = val
    end subroutine
end module derived_t

module solid_t
  use iso_fortran_env
  use constants, only : m
  implicit none

  type :: solid
    real(real64) :: x(m)
    contains
      procedure, pass(self) :: add => solid_add
  end type

contains

  subroutine solid_add(self, ndx, val)
    class(solid),   intent(inout) :: self
    integer(int32), intent(in)    :: ndx
    real(real64),   intent(in)    :: val

    self%x(ndx) = val
  end subroutine

end module solid_t

program defy
  use iso_fortran_env
  use base_t, only : base
  use constants, only : m, n
  use derived_t, only : derived
  use solid_t, only : solid
  implicit none
  integer(int64) :: profiling(1:2)
  integer(int64) :: count_rate

  call system_clock(profiling(1), count_rate)
  call test_solid
  call system_clock(profiling(2), count_rate)
  print "(A)", "solid, non abstract add"
  print*, real(profiling(2) - profiling(1), kind=real64)/count_rate

  call system_clock(profiling(1), count_rate)
  call test_derived
  call system_clock(profiling(2), count_rate)
  print "(A)", "derived, abstract add"
  print*, real(profiling(2) - profiling(1), kind=real64)/count_rate
  stop

  contains
    subroutine test_solid()
      integer(int32) :: i
      integer(int32) :: ndx
      real(real64)   :: val
      type(solid)    :: s

      do i=1, n
        call random_number(val)
        ndx = m * val
        ndx = max(ndx, 1)
        call s%add(ndx, val)
      end do
    end subroutine

    subroutine test_derived()
      integer(int32)           :: i
      integer(int32)           :: ndx
      real(real64)             :: val
      class(base), allocatable :: d

      allocate(derived :: d)
      do i = 1, n
        call random_number(val)
        ndx = m * val
        ndx = max(ndx, 1)
        call d%add(ndx, val)
      end do
    end subroutine
end program defy
