#define ROLL 1
#define ZERO 0.0 //define by main function

double ddot(int n,double* dx,int incx,double* dy,int incy)
/*
     forms the dot product of two vectors.
     jack dongarra, linpack, 3/11/78.
*/

{
	double dtemp;
	int i;

	dtemp = ZERO;

	/* code for both increments equal to 1 */

#ifdef ROLL
	for (i=0;i < n; i++)
		dtemp = dtemp + dx[i]*dy[i];
	return(dtemp);
#endif
}
