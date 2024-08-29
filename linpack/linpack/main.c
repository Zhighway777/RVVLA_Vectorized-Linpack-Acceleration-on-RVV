#define REAL double
#define ZERO 0.0e0
#define ONE 1.0e0
#define PREC "Double "

#define NTIMES 1000
#include <stdio.h>
#include "time.h"
extern void matgen(REAL *a,int lda,int n,REAL b[],REAL *norma);
extern void dgefa(REAL a[],int lda,int n,int ipvt[],int *info);
extern void dgesl(REAL a[],int lda,int n,int ipvt[],REAL b[],int job);

int main ()
{
	static REAL a[40000],b[200];
	REAL norma;
	REAL epslon(),second();
	static int ipvt[200],n,i,j,info,lda;
	int Ntimes = 64;
	lda = 201;
	n = 100;
	
	clock_t start, finish;
	double duration = 0.0;
		
	for(int itimes = 0 ; itimes < Ntimes; itimes++){
	
		start = clock();
		matgen(a,lda,n,b,&norma);
		dgefa(a,lda,n,ipvt,&info);
		dgesl(a,lda,n,ipvt,b,0);
		finish = clock();
		duration = duration + (double)(finish - start)/CLOCKS_PER_SEC;
		
		for(i=0;i<n;i++){
			
				printf("b[%d] = %lf ",i,b[i]);
			
			printf("\n");
		}
	}
	
	printf("Execute time of Linpack is %f seconds\n", duration);
	return 0;
		
}
