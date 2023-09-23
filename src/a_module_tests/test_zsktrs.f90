! Copyright (C) 2022 TurboRVB group
!
! This program is free software: you can redistribute it and/or modify
! it under the terms of the GNU General Public License as published by
! the Free Software Foundation, either version 3 of the License, or
! (at your option) any later version.
!
! This program is distributed in the hope that it will be useful,
! but WITHOUT ANY WARRANTY; without even the implied warranty of
! MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
! GNU General Public License for more details.
!
! You should have received a copy of the GNU General Public License
! along with this program. If not, see <http://www.gnu.org/licenses/>.

program test_zsktrs
    implicit none

    complex*16, allocatable, dimension(:, :) :: B, B_orig, X
    complex*16, allocatable, dimension(:) :: A
    real*8, allocatable, dimension(:) :: helper_r, helper_c
    complex*16 :: one = 1.d0, zero = 0.d0
    integer :: s, gen, ii, jj, info
    character(len=1) :: uplo

    ! s dimension of the test matrix, s x s.
    ! uplo: U->upper triangular, L->lower triangular
    ! gen = 0 : Compare matrices, gen = 1 : Generate matrices
    write (*, *) 's, uplo, gen'
    read (*, *) s, uplo, gen

    allocate (A(s - 1))
    allocate (B(s, s))
    allocate (B_orig(s, s))
    allocate (X(s, s))
    allocate (helper_r(s - 1))
    allocate (helper_c(s - 1))

    if (gen .eq. 1) then

        ! generate tridiagonal skewsymmetric matrix A
        call random_number(helper_r)
        call random_number(helper_c)
        A = cmplx(helper_r, helper_c)

    else
        open (unit=10, form="unformatted", file="A", action="read")
        read (10) A
        close (10)
        open (unit=10, form="unformatted", file="B_orig", action="read")
        read (10) B_orig
        close (10)
    end if

    X = 0

    call zsktrs(uplo, s, s, A, B, s, X, info)

    if (gen .eq. 1) then
        open (unit=10, form="unformatted", file="A", action="write")
        write (10) A
        close (10)
        open (unit=10, form="unformatted", file="B_orig", action="write")
        write (10) B_orig
        close (10)
    else
        B = B - B_orig
        if (maxval(abs(B)) > 1.0d-10) then
            print *, "ERROR"
        else
            print *, "OK"
        end if
    end if

    deallocate (A, B, B_orig, X, helper_r, helper_c)

end program test_zsktrs
