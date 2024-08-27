// data for dgesl
#define LDA 3 
#define N 3
#define LDAmulN (LDA*N)
#define PARALLEL 64
#define SIZE_ALL (PARALLEL*LDAmulN)

#include "stdio.h"
#include "malloc.h"
extern void dgesl_modify(double *a,int lda,int n,int *ipvt,double *b,int job);
extern void print_value();

static double t[LDAmulN] = 
{ 
-1.276306, -0.357850,0.572761,
0.431458, 0.586294, -0.256444,
-0.086365, -1.773038, -1.404241
};

int ipvt_t[N] = {0, 2, 2};
double b_t[N] = { -0.931213, -2.041809 , -0.653381};


int main(){

	//double *a;
	//a = (double *)malloc(SIZE_ALL)
	static double a[SIZE_ALL];
	printf("====================================================\n");
	printf("a[N*PARA]\tHEX value:\t DEC value:\t    address:\n" );
for (int i=0; i<LDAmulN; i++){
	for(int j=0; j<PARALLEL; j++){
		a[PARALLEL*i+j] = t[i];
				printf("a[%d*%d]\tHEX value:%llx\tDEC value:%.4f\taddress:%p\n", i, j, a[PARALLEL*i+j], a[PARALLEL*i+j], &a[PARALLEL*i+j]);
	}
} 

	//int *ipvt;
	//ipvt = (int *)malloc(40000);
	int ipvt[40000];
	printf("====================================================\n");
	printf("ipvt[N*PARA]\tHEX value:\t DEC value:\t    address:\n" );
for (int i=0; i<N; i++){ 
	for(int j=0; j<PARALLEL ; j++){
		ipvt[PARALLEL*i+j] = ipvt_t[i];
		printf("ipvt[%d*%d]\tHEX value:%llx\tDEC value:%d\taddress:%p\n", i, j, ipvt[PARALLEL*i+j], ipvt[PARALLEL*i+j], &ipvt[PARALLEL*i+j]);
	}
}

	//double *b;
	//b = (double *)malloc(60000);
	double b[N*PARALLEL];
	printf("====================================================\n");
	printf("b[N*PARA]\tHEX value:\t DEC value:\t    address:\n" );
for(int i=0; i<N;  i  ++){
	for(int j=0; j<PARALLEL; j++){
		b[PARALLEL*i+j] =b_t[i];
				printf("b[%d*%d]\tHEX value:%llx\tDEC value:%.4f\taddress:%p\n", i, j, b[PARALLEL*i+j], b[PARALLEL*i+j], &b[PARALLEL*i+j]);
	}
}

int job = 0;

dgesl_modify(a, LDA, N, ipvt, b, job);
//hard bug:the value before dgesl_modify will be changed!!

printf("the result of b[]:\n");
print_value();


	return 0;
}
