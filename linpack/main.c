#include <stdio.h>

typedef double data_t;
#include "verify.h"

//#define DAXPY_TEST
//#define DDOT_TEST
#define DDOT_TEST


#ifdef DAXPY_TEST
#include "daxpy_dataset.h"
#endif

#ifdef DDOT_TEST
#include "ddot_dataset.h"
#endif

#ifdef DGESL_TEST
#include "dgesl_dataset.h"
#endif


extern void daxpy_modify(int n, double da, double *dx, int incx, double *dy, int incy);
extern double ddot_modify(int n, double *dx, int incx, double *dy, int incy);
//extern void dgesl(double *a,int lda,int n,int *ipvt,double *b,int job);
void dgesl(double *a,int lda,int n,int *ipvt,double *b,int job)
{
/*     internal variables	*/

	double t;
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
				daxpy_modify(n-(k+1),t,&a[lda*k+k+1],1,&b[k+1],1);
			}
		} 

		for (kb = 0; kb < n; kb++) {
		    k = n - (kb + 1);
		    b[k] = b[k]/a[lda*k+k];
		    t = -b[k];
		    daxpy_modify(k,t,&a[lda*k+0],1,&b[0],1);
 		}
 	} 
	else { 

		for (k = 0; k < n; k++) {
			t = ddot_modify(k,&a[lda*k+0],1,&b[0],1);
			b[k] = (b[k] - t)/a[lda*k+k];
		}



		if (nm1 >= 1) {
			for (kb = 1; kb < nm1; kb++) {
				k = n - (kb+1);
				b[k] = b[k] + ddot_modify(n-(k+1),&a[lda*k+k+1],1,&b[k+1],1);
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

int main() {
#ifdef DAXPY_TEST
    daxpy_modify(DATA_SIZE, input0, input1_data, 1, input2_data, 1);
    for(int i =0; i < DATA_SIZE; i++){
    	printf("the result[%d] DAXPY is %.2f \n", i,  input2_data[i]);
    }
		int golden = verifyDouble(DATA_SIZE, input2_data, verify_data_daxpy);
		if (golden == 0)
			printf("the result is correct!\n");
		else 
			printf("the incorrect at number %d \n", golden);
#endif

#ifdef DDOT_TEST
   double result = 0.00;
	 result = ddot_modify(DATA_SIZE, input1_data, 1, input2_data, 1);
   printf("the result of DDOT is %.2f \n", result);
		int golden = verifyDouble(1, &result, verify_data_ddot);
		if (golden == 0)
			printf("the result is correct!\n");
		else 
			printf("Incorrect! the right result is %3.2f \n", verify_data_ddot);

#endif

#ifdef DGESL_TEST
	dgesl(a, LDA, N, ipvt, b, job);
  
	printf("Solution for A*x = b:\n");
    for (int i = 0; i < N; ++i) {
        printf("b[%d] = %.2f \n",i,  b[i]);
    }

    printf("\n");	
#endif
    return 0;
}
