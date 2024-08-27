#define SP

#ifdef SP
#define REAL float
#define ZERO 0.0
#define ONE 1.0
#define PREC "Single "
#endif

#ifdef DP
#define REAL double
#define ZERO 0.0e0
#define ONE 1.0e0
#define PREC "Double "
#endif

#define NTIMES 1000

/*#ifdef ROLL
#define ROLLING "Rolled "
#endif
#ifdef UNROLL
#define ROLLING "Unrolled "
#endif*/

#include <stdio.h>
#include <math.h>


#include <sys/time.h>

void matgen(REAL *a,int lda,int n,REAL b[],REAL *norma)

/* We would like to declare a[][lda], but c does not allow it.  In this
function, references to a[i][j] are written a[lda*j+i].  */

{
	int init, i, j;

	init = 1325;
	*norma = 0.0;
	for (j = 0; j < n; j++) {
		for (i = 0; i < n; i++) {
			init = 3125*init % 65536;
			a[lda*j+i] = (init - 32768.0)/16384.0;
			*norma = (a[lda*j+i] > *norma) ? a[lda*j+i] : *norma;
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

/* int main()
{
    static REAL aa[200][201],a[200][201],b[200],x[200];
	REAL cray,ops,total,norma,normx;
	REAL resid,residn,eps,t1,tm,tm2;
	REAL epslon(),second(),kf;
	static int ipvt[200],n,i,ntimes,info,lda,ldaa,kflops;

	lda = 201;
	ldaa = 200;
	cray = .056; 
	n = 100;
    
    matgen(a,lda,n,b,&norma);
	matgen(aa,lda,n,b,&norma);
    
	for(i=0; i<n; i++)
	{
		for(int j=0;j<n;j++){
			printf("%f ",a[i*lda+j]-aa[i*lda+j]);
		}
		printf("\n");
	}

    return 0;
} */