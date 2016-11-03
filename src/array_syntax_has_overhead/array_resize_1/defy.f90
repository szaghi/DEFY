! A DEFY (DEmystyfy Fortran mYths) test.
! Author: Stefano Zaghi
! Date: 2016-11-03
!
! License: this file is licensed under the Creative Commons Attribution 4.0 license,
! see http://creativecommons.org/licenses/by/4.0/ .

program defy
  use iso_fortran_env
  implicit none
  integer(int64) :: profiling(1:2)
  integer(int64) :: count_rate
  integer(int32), parameter   :: Ni=100000
  integer(int32), parameter   :: chunk=100
  integer(int32), allocatable :: x(:)
  integer(int32)              :: i
  integer(int32)              :: n

  call system_clock(profiling(1), count_rate)
  x = [0]
  do i=1, Ni
    x = [x,i]
  enddo
  call system_clock(profiling(2), count_rate)
  print '(A,E23.15)', ' LHS-realloc with array syntax: ', real(profiling(2) - profiling(1), kind=real64)/count_rate

  if (allocated(x)) deallocate(x)
  call system_clock(profiling(1), count_rate)
  n = 0
  do i=0, Ni
      call add_to(vec=x, n=n, val=i, chunk_size=chunk, finished=(i==Ni))
  enddo
  call system_clock(profiling(2), count_rate)
  print '(A,E23.15)', ' move_alloc chunked:            ', real(profiling(2) - profiling(1), kind=real64)/count_rate

  contains
    pure subroutine add_to(vec, n, val, chunk_size, finished)
      ! Author: Jacob Williams
      integer(int32), allocatable, intent(inout) :: vec(:)     ! The vector to add to.
      integer(int32),              intent(inout) :: n          ! Counter for last element added to vec, must be initialized to
                                                               ! size(vec) (or 0 if not allocated) before first call.
      integer(int32),              intent(in)    :: val        ! The value to add.
      integer(int32),              intent(in)    :: chunk_size ! Allocate vec in blocks of this size (>0).
      logical,                     intent(in)    :: finished   ! Set to true to return vec as its correct size (n).
      integer(int32), allocatable                :: tmp(:)     ! Temporary array.

      if (allocated(vec)) then
        if (n==size(vec)) then
          ! have to add another chunk:
          allocate(tmp(size(vec)+chunk_size))
          tmp(1:size(vec)) = vec
          call move_alloc(tmp,vec)
        end if
        n = n + 1
      else
        ! the first element:
        allocate(vec(chunk_size))
        n = 1
      end if
      vec(n) = val
      if (finished) then
        ! set vec to actual size (n):
        if (allocated(tmp)) deallocate(tmp)
        allocate(tmp(n))
        tmp = vec(1:n)
        call move_alloc(tmp,vec)
      endif
    endsubroutine add_to
end program defy
