#include <stdio.h>
#include <stdlib.h>

extern void matgenv(double *a,int lda,int n,double b[]);
/* {
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
		for (i = 0; i < n; i++) {0
			b[i] = b[i] + a[lda*j+i];
		}
	}
	return ;
} */

int main()
{
    int n = 5120000; 
    int lda = 100;
    double *a = (double*)malloc(n * sizeof(double));
    double *b = (double*)malloc(n * sizeof(double));
    matgenv(a, lda, 100, b);
    

    int init, i, j;
    init = 1325;
    double *atst = (double*)malloc(n * sizeof(double));
    double *btst = (double*)malloc(n * sizeof(double));
	int cnt_roll=64;
	int cnt_column=64*100;
    n = 100;
	for (j = 0; j < n; j++) {
		for (i = 0; i < n; i++) {
			init = 3125*init % 65536;
			double temp = ((double)init - 32768.0)/16384.0;
			for(int p = 0; p < 64; p ++){
				atst[cnt_column*j+cnt_roll*i+p] = temp;
			}
		}
	}
	for (i = 0; i < 25600; i++) {
          btst[i] = 0.0;
	}
	for (j = 0; j < n; j++) {
		for (i = 0; i < n; i++) {
			for(int p = 0; p < 64; p ++){
				btst[cnt_roll*i+p] = btst[cnt_roll*i+p] 
									 + atst[cnt_column*j+cnt_roll*i+p];
			}
		}
	}

	for (j = 0; j < n; j++) {
		for (i = 0; i < n; i++) {
			printf("\n");
			for(int p = 0; p < 64; p ++){
				printf("%f ",a[cnt_column*j+cnt_roll*i+p]);
 			}
		}
  	}

    return 0;
}
