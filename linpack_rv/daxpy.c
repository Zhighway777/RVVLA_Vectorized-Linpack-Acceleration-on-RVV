#define DP 1
#define ROLL 1

#ifdef SP
#define REAL float
#define ZERO 0.0
#define ONE 1.0
#define PREC "Single "
#endif

#ifdef DP
#define REAL double
#define ZERO 0.0e0
#define ONE 1.0e0
#define PREC "Double "
#endif

#define NTIMES 1000


#include <stdio.h>
#include <math.h>

void daxpy(int n,REAL da,REAL*dx,int incx,REAL *dy,int incy)
/*
     constant times a vector plus a vector.
     jack dongarra, linpack, 3/11/78.
*/
/* REAL dx[],dy[],da;
int incx,incy,n; */
{
	int i,ix,iy,m,mp1;

	if(n <= 0) return;
	if (da == ZERO) return;

	if(incx != 1 || incy != 1) {

		/* code for unequal increments or equal increments
		   not equal to 1 					*/

		ix = 0;
		iy = 0;
		if(incx < 0) ix = (-n+1)*incx;
		if(incy < 0)iy = (-n+1)*incy;
		for (i = 0;i < n; i++) {
			dy[iy] = dy[iy] + da*dx[ix];
			ix = ix + incx;
			iy = iy + incy;
		}
      		return;
	}

	/* code for both increments equal to 1 */

	for (i = 0;i < n; i++) {
		dy[i] = dy[i] + da*dx[i];
	}

	return ;
}
