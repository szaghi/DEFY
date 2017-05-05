! A DEFY (DEmystyfy Fortran mYths) test.
! Author: Stefano Zaghi
! Date: 2017-05-05
!
! License: this file is licensed under the Creative Commons Attribution 4.0 license,
! see http://creativecommons.org/licenses/by/4.0/ .

module arrays
   use, intrinsic :: iso_fortran_env, only : real64

   implicit none

   type :: array_automatic
      integer                   :: n
      real(real64), allocatable :: x(:)
      contains
         procedure, pass(lhs) :: add_automatic
         generic :: operator(+) => add_automatic
         procedure, pass(lhs) :: assign_automatic
         generic :: assignment(=) => assign_automatic
   endtype array_automatic

   type :: array_allocatable
      integer                   :: n
      real(real64), allocatable :: x(:)
      contains
         procedure, pass(lhs) :: add_allocatable
         generic :: operator(+) => add_allocatable
         procedure, pass(lhs) :: assign_allocatable
         generic :: assignment(=) => assign_allocatable
   endtype array_allocatable

   type, abstract :: array_polymorphic_abstract
      contains
         procedure(add_interface), pass(lhs), deferred :: add_polymorphic
         generic :: operator(+) => add_polymorphic
         procedure(assign_interface),      pass(lhs), deferred :: assign_polymorphic
         procedure(assign_real_interface), pass(lhs), deferred :: assign_polymorphic_real
         generic :: assignment(=) => assign_polymorphic, assign_polymorphic_real
   endtype array_polymorphic_abstract

   type, extends(array_polymorphic_abstract) :: array_polymorphic
      integer                   :: n
      real(real64), allocatable :: x(:)
      contains
         procedure, pass(lhs) :: add_polymorphic
         procedure, pass(lhs) :: assign_polymorphic
         procedure, pass(lhs) :: assign_polymorphic_real
   endtype array_polymorphic

   abstract interface
      pure function add_interface(lhs, rhs) result(opr)
      import :: array_polymorphic_abstract
      class(array_polymorphic_abstract), intent(in)  :: lhs
      class(array_polymorphic_abstract), intent(in)  :: rhs
      class(array_polymorphic_abstract), allocatable :: opr
      endfunction add_interface

      pure subroutine assign_interface(lhs, rhs)
      import :: array_polymorphic_abstract
      class(array_polymorphic_abstract), intent(inout) :: lhs
      class(array_polymorphic_abstract), intent(in)    :: rhs
      endsubroutine assign_interface

      pure subroutine assign_real_interface(lhs, rhs)
      import :: array_polymorphic_abstract, real64
      class(array_polymorphic_abstract), intent(inout) :: lhs
      real(real64),                      intent(in)    :: rhs(1:)
      endsubroutine assign_real_interface
   endinterface

   contains
      pure function add_automatic(lhs, rhs) result(opr)
      class(array_automatic), intent(in) :: lhs
      type(array_automatic),  intent(in) :: rhs
      real(real64)                       :: opr(1:lhs%n)

      opr = lhs%x + rhs%x
      endfunction add_automatic

      pure subroutine assign_automatic(lhs, rhs)
      class(array_automatic), intent(inout) :: lhs
      real(real64),           intent(in)    :: rhs(1:)

      lhs%n = size(rhs, dim=1)
      lhs%x = rhs
      endsubroutine assign_automatic

      pure function add_allocatable(lhs, rhs) result(opr)
      class(array_allocatable), intent(in) :: lhs
      type(array_allocatable),  intent(in) :: rhs
      real(real64), allocatable            :: opr(:)

      opr = lhs%x + rhs%x
      endfunction add_allocatable

      pure subroutine assign_allocatable(lhs, rhs)
      class(array_allocatable), intent(inout) :: lhs
      real(real64),             intent(in)    :: rhs(1:)

      lhs%n = size(rhs, dim=1)
      lhs%x = rhs
      endsubroutine assign_allocatable

      pure function add_polymorphic(lhs, rhs) result(opr)
      class(array_polymorphic),          intent(in)  :: lhs
      class(array_polymorphic_abstract), intent(in)  :: rhs
      class(array_polymorphic_abstract), allocatable :: opr

      allocate(array_polymorphic :: opr)
      select type(opr)
      class is(array_polymorphic)
         select type(rhs)
         class is(array_polymorphic)
            opr%x = lhs%x + rhs%x
         endselect
      endselect
      endfunction add_polymorphic

      pure subroutine assign_polymorphic(lhs, rhs)
      class(array_polymorphic),          intent(inout) :: lhs
      class(array_polymorphic_abstract), intent(in)    :: rhs

      select type(rhs)
      class is(array_polymorphic)
         lhs%n = rhs%n
         lhs%x = rhs%x
      endselect
      endsubroutine assign_polymorphic

      pure subroutine assign_polymorphic_real(lhs, rhs)
      class(array_polymorphic), intent(inout) :: lhs
      real(real64),             intent(in)    :: rhs(1:)

      lhs%n = size(rhs, dim=1)
      lhs%x = rhs
      endsubroutine assign_polymorphic_real
endmodule arrays

program defy
   use, intrinsic :: iso_fortran_env, only : int64, real64
   use arrays, only : array_automatic, array_allocatable, array_polymorphic
   implicit none
   real(real64), allocatable :: a_intrinsic(:)
   real(real64), allocatable :: b_intrinsic(:)
   real(real64), allocatable :: c_intrinsic(:)
   type(array_automatic)     :: a_automatic
   type(array_automatic)     :: b_automatic
   type(array_automatic)     :: c_automatic
   type(array_allocatable)   :: a_allocatable
   type(array_allocatable)   :: b_allocatable
   type(array_allocatable)   :: c_allocatable
   type(array_polymorphic)   :: a_polymorphic
   type(array_polymorphic)   :: b_polymorphic
   type(array_polymorphic)   :: c_polymorphic
   integer(int64)            :: tic_toc(1:2)
   integer(int64)            :: count_rate
   real(real64)              :: intrinsic_time
   real(real64)              :: time
   integer                   :: N
   integer                   :: Nn
   integer                   :: i

   N = 100000
   Nn = N/100
   a_intrinsic   = [(real(i, kind=real64), i=1,N)]
   b_intrinsic   = [(real(i, kind=real64), i=1,N)]
   a_automatic   = [(real(i, kind=real64), i=1,N)]
   b_automatic   = [(real(i, kind=real64), i=1,N)]
   a_allocatable = [(real(i, kind=real64), i=1,N)]
   b_allocatable = [(real(i, kind=real64), i=1,N)]
   a_polymorphic = [(real(i, kind=real64), i=1,N)]
   b_polymorphic = [(real(i, kind=real64), i=1,N)]

   call system_clock(tic_toc(1), count_rate)
   do i=1, Nn
     c_intrinsic = a_intrinsic + b_intrinsic
   enddo
   call system_clock(tic_toc(2), count_rate)
   intrinsic_time = (tic_toc(2) - tic_toc(1)) / real(count_rate, kind=real64)
   print*, 'intrinsic: ', intrinsic_time

   call system_clock(tic_toc(1), count_rate)
   do i=1, Nn
     c_automatic = a_automatic + b_automatic
   enddo
   call system_clock(tic_toc(2), count_rate)
   time = (tic_toc(2) - tic_toc(1)) / real(count_rate, kind=real64)
   print*, 'automatic: ', time, ' + %(intrinsic): ', 100._real64 - intrinsic_time / time * 100

   call system_clock(tic_toc(1), count_rate)
   do i=1, Nn
     c_allocatable = a_allocatable + b_allocatable
   enddo
   call system_clock(tic_toc(2), count_rate)
   time = (tic_toc(2) - tic_toc(1)) / real(count_rate, kind=real64)
   print*, 'allocatable: ', time, ' + %(intrinsic): ', 100._real64 - intrinsic_time / time * 100

#ifndef __GFORTRAN__
   call system_clock(tic_toc(1), count_rate)
   do i=1, Nn
     c_polymorphic = a_polymorphic + b_polymorphic
   enddo
   call system_clock(tic_toc(2), count_rate)
   time = (tic_toc(2) - tic_toc(1)) / real(count_rate, kind=real64)
   print*, 'polymorphic: ', time, ' + %(intrinsic): ', 100._real64 - intrinsic_time / time * 100
#endif
end program defy
