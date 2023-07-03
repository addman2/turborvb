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

subroutine bconstrbr(iesfreer, n3body, jbraj, derjas              &
        &, ddw)
    implicit none
    integer iesfreer, jbraj(*), i, j, n3body
    real*8 ddw(*), derjas(*)
    if (iesfreer .eq. 0) return
    do i = 1, n3body
        j = jbraj(i)
        if (j .gt. 0) then
            derjas(i) = ddw(j)
        elseif (j .lt. 0) then
            derjas(i) = -ddw(-j)
        end if
    end do
    return
end
