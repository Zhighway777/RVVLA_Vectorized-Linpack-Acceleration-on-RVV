extern void daxpy_modify(int n, double da, double *dx, int incx, double *dy, int incy);

void dgesl(double *a,int lda,int n,int *ipvt,double *b,int job)
{
/*     internal variables	*/

	double t;
	int k,kb,l,nm1;

	nm1 = n - 1;

		if (nm1 >= 1) {
			for (k = 0; k < nm1; k++) {
				l = ipvt[k];
				/*
				 * put b[l] as b[k] into the argument of daxpy(..,&b[k+1],..)
				 */
				t = b[l];
				if (l != k){ 
					b[l] = b[k];
					b[k] = t;
				}	
				daxpy_modify(n-(k+1),t,&a[lda*k+k+1],1,&b[k+1],1);
			}
		} 

		for (kb = 0; kb < n; kb++) {
		    k = n - (kb + 1);
		    b[k] = b[k]/a[lda*k+k];
		    t = -b[k];
		    daxpy_modify(k,t,&a[lda*k+0],1,&b[0],1);
 		}	
	return ;
}
