
#define REAL double
#define ZERO 0.0e0
#define ONE 1.0e0
#define PREC "Double "

#define NTIMES 64
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

extern void matgenv(double *a, int lda, int n ,double b[]);
extern void dgefaV(double a[],int lda,int n,int ipvt[]);
extern void dgesl_modify(double a[],int lda,int n,int ipvt[], double b[], int job);

extern void print_Vlinpack();

int main ()
{
	
	static int n,i,lda;
	n = 5120000; 
    lda = 100;
    double *a = (double*)malloc(n * sizeof(double));
    double *b = (double*)malloc(n * sizeof(double));
	int *ipvt = (int*)malloc(n* sizeof(int));
	n = 100;
	matgenv(a,lda,100,b);
	dgefaV(a,lda,100,ipvt);
	printf("The address of b: %p\n", b);
	
	dgesl_modify(a, lda, n, ipvt, b, 0);
	printf("The After address of b: %p\n", b);
	
/*	for(i=0;i<n;i ++){
		
			printf("a[%d] = %lf ",i,*(b+NTIMES*i));
		
		printf("\n");
	}*/
	print_Vlinpack();
	return 0;
		
}
