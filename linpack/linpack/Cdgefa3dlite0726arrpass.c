
#define REAL double
#define ZERO 0.0e0
#define ONE 1.0e0
#define PREC "Double "

#define NTIMES 1000

#include <stdio.h>
#include <math.h>


void matgen(REAL *a,int lda,int n,REAL b[],REAL *norma)

{
	int init, i, j;
    init = 1325;
	for (j = 0; j < n; j++) {
		for (i = 0; i < n; i++) {
			init = 3125*init % 65536;
			a[lda*j+i] = (init - 32768.0)/16384.0;
		}
	}
	for (i = 0; i < n; i++) {
          b[i] = 0.0;
	}
	for (j = 0; j < n; j++) {
		for (i = 0; i < n; i++) {
			b[i] = b[i] + a[lda*j+i];
		}
	}
	return ;
}

void dgefa(REAL a[],int lda,int n,int ipvt[],int *info)

{

REAL t;
int j,k,kp1,l,nm1;

	*info = 0;
	nm1 = n - 1;
	if (nm1 >=  0) {
		for (k = 0; k < nm1; k++) { //为每一行找到主元；主元位置换到对角线；
			kp1 = k + 1;
			//dx[] = &a[lda*k+k]
			//l = idamax(n-k,&a[lda*k+k],1) + k;
			double *dx = &a[lda*k+k];
			int itemp = 0;
			REAL dmax = fabs((double)a[lda*k+k]);
			for (int i = 1; i < n-k; i++) {
				if(fabs((double)dx[i]) > dmax) {
					itemp = i;
					dmax = fabs((double)dx[i]);
				}
			}
			l = itemp + k;
			ipvt[k] = l;
			if (a[lda*k+l] != ZERO) {

				/* interchange if necessary */

				if (l != k) {
					t = a[lda*k+l];
					a[lda*k+l] = a[lda*k+k];
					a[lda*k+k] = t; 
				}
				t = -ONE/a[lda*k+k];
				//dscal(n-(k+1),t,&a[lda*k+k+1],1);

				dx = &a[lda*k+k+1];
				for (int i = 0; i < n-(k+1); i++){
					dx[i] = t*dx[i];
				} 

				for (j = kp1; j < n; j++) {
					t = a[lda*j+l];
					if (l != k) {
						a[lda*j+l] = a[lda*j+k];
						a[lda*j+k] = t;
					}
					/*  daxpy(n-(k+1),t,&a[lda*k+k+1],1,
					      &a[lda*j+k+1],1);  */

					double *dy = &a[lda*j+k+1];
					dx = &a[lda*k+k+1];
					for (int i = 0;i < n-(k+1); i++) {
						dy[i] = dy[i] + t*dx[i];
					}	   

  				} 		
  			}
			else { 
            			*info = k;
			}
		} 
	}
	ipvt[n-1] = n-1;
	if (a[lda*(n-1)+(n-1)] == ZERO) *info = n-1;
}

void dgesl(REAL a[],int lda,int n,int ipvt[],REAL b[],int job)

{

	REAL t;
	int k,kb,l,nm1;

	nm1 = n - 1;
	if (job == 0) {

		if (nm1 >= 1) {
			for (k = 0; k < nm1; k++) {
				l = ipvt[k];
				t = b[l];
				if (l != k){ 
					b[l] = b[k];
					b[k] = t;
				}	
				//daxpy(n-(k+1),t,&a[lda*k+k+1],1,&b[k+1],1);
				
				double *dx = &a[lda*k+k+1];
				double *dy = &b[k+1];
				for (int i = 0;i < n-(k+1); i++) {
					dy[i] = dy[i] + t*dx[i];
				}	 
			}
		} 

		for (kb = 0; kb < n; kb++) {
		    k = n - (kb + 1);
		    b[k] = b[k]/a[lda*k+k];
		    t = -b[k];
		    //daxpy(k,t,&a[lda*k+0],1,&b[0],1);
			double *dx = &a[lda*k+0];
			double *dy = &b[0];
			for (int i = 0;i < k; i++) {
				dy[i] = dy[i] + t*dx[i];
			}	 
		}
	}
	else { 

		for (k = 0; k < n; k++) {
			//t = ddot(k,&a[lda*k+0],1,&b[0],1);
			double dtemp = ZERO;
			double *dx = &a[lda*k+0];
			double *dy = &b[0];
			for (int i=0;i < k; i++)
				dtemp = dtemp + dx[i]*dy[i];
			//return(dtemp);
			t = dtemp;
			b[k] = (b[k] - t)/a[lda*k+k];
		}

		if (nm1 >= 1) {
			for (kb = 1; kb < nm1; kb++) {
				k = n - (kb+1);
				//b[k] = b[k] + ddot(n-(k+1),&a[lda*k+k+1],1,&b[k+1],1);

				double dtemp = ZERO;
				double *dx = &a[lda*k+k+1];
				double *dy = &b[k+1];
				for (int i=0;i < n-(k+1); i++)
					dtemp = dtemp + dx[i]*dy[i];
				//return(dtemp);
				t = dtemp;
				b[k] += dtemp;

				l = ipvt[k];
				if (l != k) {
					t = b[l];
					b[l] = b[k];
					b[k] = t;
				}
			}
		}
	}
	return ;
}

int main ()
{
	static REAL a[40000],b[200];
	REAL norma;
	REAL epslon(),second();
	static int ipvt[200],n,i,j,info,lda;
	int Ntimes = 1000;
	lda = 201;
	n = 100;
	

	for(int itimes = 0 ; itimes < Ntimes; itimes++){

		matgen(a,lda,n,b,&norma);
		dgefa(a,lda,n,ipvt,&info);
		dgesl(a,lda,n,ipvt,b,0);
		for(i=0;i<n;i++){
			
				printf("b[%d] = %lf ",i,b[i]);
			
			printf("\n");
		}
	}
	return 0;
		
}