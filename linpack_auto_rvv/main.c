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
	unsigned int wrong_times = 0;
	for(int itimes = 0 ; itimes < Ntimes; itimes++){
	
		start = clock();
		matgen(a,lda,n,b,&norma);
		dgefa(a,lda,n,ipvt,&info);
		dgesl(a,lda,n,ipvt,b,0);
		finish = clock();
		duration = duration + (double)(finish - start)/CLOCKS_PER_SEC;
		
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
