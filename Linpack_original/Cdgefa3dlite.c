
#define REAL double
#define ZERO 0.0e0
#define ONE 1.0e0
#define PREC "Double "

#define NTIMES 1000

#include <stdio.h>
#include <math.h>
#include "time.h" 

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

void daxpy(int n,REAL da,REAL dx[],int incx,REAL dy[],int incy)
{
	int i,ix,iy;
	
	for (i = 0;i < n; i++) {
		dy[i] = dy[i] + da*dx[i];
	}
}

void dscal(int n,REAL da,REAL dx[],int incx)
{
	int i,nincx;

	if(n <= 0)return;

	for (i = 0; i < n; i++)
		dx[i] = da*dx[i];

}

int idamax(int n,REAL dx[],int incx)
{
	REAL dmax;
	int i, ix, itemp;

	if( n < 1 ) return(-1);
	if(n ==1 ) return(0);
		itemp = 0;
		dmax = fabs((double)dx[0]);
		for (i = 1; i < n; i++) {
			if(fabs((double)dx[i]) > dmax) {
				itemp = i;
				dmax = fabs((double)dx[i]);
			}
		}
	return (itemp);
}

void dgefa(REAL a[],int lda,int n,int ipvt[])

{

REAL t;
int j,k,kp1,l,nm1;

	nm1 = n - 1;
	if (nm1 >=  0) {
		for (k = 0; k < nm1; k++) { //为每一行找到主元；主元位置换到对角线；
			kp1 = k + 1;
			l = idamax(n-k,&a[lda*k+k],1) + k;
			//void idamaxv(int n, double *dx, int incx, int ntimes, int *result_ret)
			//idamaxv(n-k, arrangedarray, incx = 1, ntimes = 256, result_ret)
			//重構規則：原本處理的是第k行的k到n，合計n-k個元素；將256組n-k個元素按列排好，來自同一個矩陣的在同一列

			ipvt[k] = l;

			/* interchange if necessary */

			if (l != k) {
				t = a[lda*k+l];
				a[lda*k+l] = a[lda*k+k];
				a[lda*k+k] = t; 
			}
			t = -ONE/a[lda*k+k];
			dscal(n-(k+1),t,&a[lda*k+k+1],1);
			//dscalv (ntimes*(n-k-1), t_array, arrangedarray, incx = 1)
			//重構規則：與idamax類似
			for (j = kp1; j < n; j++) {
				t = a[lda*j+l];
				if (l != k) {
					a[lda*j+l] = a[lda*j+k];
					a[lda*j+k] = t;
				}
				daxpy(n-(k+1),t,&a[lda*k+k+1],1,
						&a[lda*j+k+1],1);
				//ask		
			} 		
		
		} 
	}
}

REAL ddot(int n,REAL dx[],int incx,REAL dy[],int incy)
{
	REAL dtemp;
	int i,ix,iy,m,mp1;

	dtemp = ZERO;

	for (i=0;i < n; i++)
		dtemp = dtemp + dx[i]*dy[i];
	return(dtemp);
}


void dgesl(REAL a[],int lda,int n,int ipvt[],REAL b[],int job)

{

	REAL t;
	int k,kb,l,nm1;

	nm1 = n - 1;

	if (nm1 >= 1) {
		for (k = 0; k < nm1; k++) {
			l = ipvt[k];
			t = b[l];
			if (l != k){ 
				b[l] = b[k];
				b[k] = t;
			}	
			daxpy(n-(k+1),t,&a[lda*k+k+1],1,&b[k+1],1);
		}
	} 

	for (kb = 0; kb < n; kb++) {
		k = n - (kb + 1);
		b[k] = b[k]/a[lda*k+k];
		t = -b[k];
		daxpy(k,t,&a[lda*k+0],1,&b[0],1);
	}
	
	return ;
}

int main ()
{
	static REAL a[40000],b[200];
	REAL norma;
	REAL epslon(),second();
	static int ipvt[200],n,i,j,info,lda;
	int Ntimes = 64;
	lda = 100;
	n = 100;
	clock_t start, finish;
	double duration = 0.0;
	unsigned int wrong_times = 0;
	for(int itimes = 0 ; itimes < Ntimes; itimes++){

		matgen(a,lda,n,b,&norma);
		dgefa(a,lda,n,ipvt);
		dgesl(a,lda,n,ipvt,b,0);
		finish = clock();
		duration = duration +(double)(finish - start) / CLOCKS_PER_SEC;
		for(i=0;i<n;i++){
			if(i%100 == 0){
				printf("===========the %d'th group==========\n", itimes);
			}
			if(b[i] - 1.000000  == 0.0){
				wrong_times ++;			
			}
				printf("b[%d] = %lf ",i,b[i]);
			
			printf("\n");
		}
	}
	if (wrong_times == 0){
		printf("Wrong times is ZERO.\nThe Results are all correct!\n");
		printf("The Execute time for VLinpack is %f seconds \n", duration);
	}
	else 
	printf("The Wrong number is %d in araray b[] \n", wrong_times);
	
	return 0;
		
}
