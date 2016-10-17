! A DEFY (DEmystyfy Fortran mYths) test.
! Author: FortranFan
! Date: 2016-10-17
!
! License: this file is licensed under the Creative Commons Attribution 4.0 license,
! see http://creativecommons.org/licenses/by/4.0/ .

      !.. Argument list
      integer, intent(in)     :: n
      real(WP), intent(inout) :: r

      !.. Local variables
      integer :: v_size
      integer :: istat
      real(WP), allocatable :: v(:)

      v_size = 2**( min(n,10) )
      allocate( v(v_size), stat=istat )
      if ( istat /= 0 ) then
         print *, ": allocation of v failed: v_size, stat = ", v_size, istat
         stop
      end if

      call random_number( v )

      !dec$ if defined (IFORT)
      r = norm2( v )
      !dec$ else
      r = sqrt( dot_product(v, v)/real(v_size, kind=kind(r)) )
      !dec$ endif

      deallocate( v, stat=istat )

      return
