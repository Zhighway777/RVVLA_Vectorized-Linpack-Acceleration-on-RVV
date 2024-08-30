
#define REAL double
#define ZERO 0.0e0
#define ONE 1.0e0
#define PREC "Double "

#define NTIMES 64
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include "time.h" 
extern void matgenv(double *a, int lda, int n ,double b[]);
extern void dgefaV(double a[],int lda,int n,int ipvt[]);
extern void dgesl_modify(double a[],int lda,int n,int ipvt[], double b[], int job);

int main ()
{
	
	static int n,i,lda;
	n = 5120000; 
    lda = 100;
    double *a = (double*)malloc(n * sizeof(double));
    double *b = (double*)malloc(n * sizeof(double));
	int *ipvt = (int*)malloc(n* sizeof(int));
	n = 100;
	int Ntimes = 16;
	clock_t start, finish;
	double duration = 0.0;
	unsigned int wrong_times = 0;
	//for(int itimes =  0; itimes < Ntimes; itimes ++){
		start = clock();
		
		matgenv(a,lda,100,b);
		dgefaV(a,lda,100,ipvt);
		dgesl_modify(a, lda, n, ipvt, b, 0);
	 
		finish = clock();
		duration = duration +(double)(finish - start) / CLOCKS_PER_SEC;
		/*	for(i=0;i<n;i ++){
			
				printf("a[%d] = %lf ",i,*(b+NTIMES*i));
			
			printf("\n");
		}*/
		
		for(int i=0; i<100*64; i++){
			if(i%100 == 0){
				printf("===========the %d'th group==========\n", i/100);
			}
			if(b[i] - 1.000000  == 0.0){
				wrong_times ++;			
			}
			printf("b[%d] = %lf \n", i%100, b[i]);
		}	
	//}
	if (wrong_times == 0){
		printf("Wrong times is ZERO.\nThe Results are all correct!\n");
		printf("The Execute time for VLinpack is %f seconds \n", duration);
	}
	else 
	printf("The Wrong number is %d in araray b[] \n", wrong_times);
	return 0;
		
}
