
#define REAL double
#define ZERO 0.0e0
#define ONE 1.0e0
#define PREC "Double "
#define PARR 64
#define NTIMES 1000

#include <stdio.h>
#include <math.h>
#include <stdlib.h>

extern void matgenv(REAL *a, int lda, int n ,REAL b[]);
extern void dgefaV(REAL a[],int lda,int n,int ipvt[]);


int main ()
{
	
	static int n,i,lda;
	n = 5120000; 
    lda = 100;
    double *a = (double*)malloc(n * sizeof(double));
    double *b = (double*)malloc(n * sizeof(double));
	int *ipvt = (int*)malloc(n* sizeof(int));

	matgenv(a,lda,100,b);
	dgefaV(a,lda,100,ipvt);
	for( i = 0 ; i < 600 ; i ++){
		
		printf("a[%d] = %lf ",i,*(a+i));
		printf("b[%d] = %lf ",i,*(b+i));
		printf("\n");
		printf("ipvt[%d] = %lf ",i,*(ipvt+i));
		printf("\n");
	}
	return 0;
		
}