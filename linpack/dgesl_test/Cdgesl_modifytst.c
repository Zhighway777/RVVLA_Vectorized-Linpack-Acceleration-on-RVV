
#define REAL double
#define ZERO 0.0e0
#define ONE 1.0e0
#define PREC "Double "

#define NTIMES 64
#include <stdlib.h>
#include <stdio.h>
#include <math.h>

void matgen(REAL *a, int lda, int n, REAL b[], REAL *norma)

{
	int init, i, j;
	init = 1325;
	for (j = 0; j < n; j++)
	{
		for (i = 0; i < n; i++)
		{
			init = 3125 * init % 65536;
			a[lda * j + i] = (init - 32768.0) / 16384.0;
		}
	}
	for (i = 0; i < n; i++)
	{
		b[i] = 0.0;
	}
	for (j = 0; j < n; j++)
	{
		for (i = 0; i < n; i++)
		{
			b[i] = b[i] + a[lda * j + i];
		}
	}
	return;
}

void daxpy(int n, REAL da, REAL dx[], int incx, REAL dy[], int incy)
{
	int i, ix, iy;

	for (i = 0; i < n; i++)
	{
		dy[i] = dy[i] + da * dx[i];
	}
}

void dscal(int n, REAL da, REAL dx[], int incx)
{
	int i, nincx;

	if (n <= 0)
		return;

	for (i = 0; i < n; i++)
		dx[i] = da * dx[i];
}

int idamax(int n, REAL dx[], int incx)
{
	REAL dmax;
	int i, ix, itemp;

	if (n < 1)
		return (-1);
	if (n == 1)
		return (0);
	itemp = 0;
	dmax = fabs((double)dx[0]);
	for (i = 1; i < n; i++)
	{
		if (fabs((double)dx[i]) > dmax)
		{
			itemp = i;
			dmax = fabs((double)dx[i]);
		}
	}
	return (itemp);
}

void dgefa(REAL a[], int lda, int n, int ipvt[])

{

	/*
	a0 the pointer to &a[0] --> s9
	a1 the lda = 100 --> s6
	a2 the n = 100 --> s6
	a3 the pointer to &ipvt[0] --> s7
	s8 stands for k; s11 stands for kp1
	a[k][l] = *(a+parr*lda)  in RVV it should slli 3 for double takes 8bytes each
	*/

	REAL t;
	int j, k, kp1, l, nm1;

	nm1 = n - 1; // sub s10, a2, t0
	if (nm1 >= 0)
	{ // not necessary
		for (k = 0; k < nm1; k++)
		{ //	mv s8, s11

			kp1 = k + 1; // addi s11, s11, 1
						 // (after other works)
						 // s8 stands for k; s11 stands for kp1

			l = idamax(n - k, &a[lda * k + k], 1) + k;
			// idamax_init
			//  mv s4, s8
			// mul s4, s4, s6
			// add s4, s4, s8
			// slli s4, s4, 3
			// mul s4, s4, t0
			// mul s4, s4, s6
			// add a1, s9, s4  -->  &a[lda*k+k]
			// idamax

			ipvt[k] = l;
			// mv t1, s8
			// slli t1, t1, 2
			// mul t1, t1, t0
			// add t1, t1, s7 --> &ipvt[k]
			// vadd.vx v20, v20, s8 # l = idamax(n-k,&a[lda*k+k],1) + k
			// vs1r.v v20, (t1) # 向&ipvt[0] + k*parr 存储了64个矩阵第k行最大元素位置,也就是l

			if (a[lda * k + l] != ZERO)
			{
				// lw t2, (t1)
				// add s4, s8, t2
				// slli s4, s4, 3
				// mul s4, s4, t0
				// mul s4, s4, s6
				// add a1, s9, s4  -->  &a[lda*k+k]

				/* interchange if necessary */

				if (l != k)
				{
					t = a[lda * k + l];
					a[lda * k + l] = a[lda * k + k];
					a[lda * k + k] = t;
				}

				// mv s4, s8 --> k
				// mul s4, s4, s6 --> k*lda
				// add s4, s4, t2 --> k*lda +l
				// slli s4 ,s4, 3
				// mul s4, s4, t0 --> &a[k,l] - &a[0]
				// add t2, s9, s4 --> t2 = &a[k,l]
				// mv s4, s8 --> k
				// mul s4, s4, s6 --> k*lda
				// add s4, s4, s8 --> k*lda +k
				// slli s4 ,s4, 3
				// mul s4, s4, t0 --> &a[k,k] - &a[0]
				// add t3, s9, s4 --> t3 = &a[k,k]
				//  ...... use vl1re64 with vs1r to swap
				t = -ONE / a[lda * k + k];
				// li t2, -1
				// fcvt.d.w fa2, t2
				// vfrdiv.vf v12, v4, fa2 --> v12 holds -one/a[lda*k+k]
				dscal(n - (k + 1), t, &a[lda * k + k + 1], 1);
				// slli t4, t0, 3
				// add t3, t3, t4 --> t3 = &a[k,k+1]
				// mv a2, t3
				// dscalvtst

				for (j = kp1; j < n; j++)
				{
					// mv s5, s11 --> s5 the j = kp1
					//  after loop content done
					// addi s5, s5, 1
					// bne s5, s6, loop
					t = a[lda * j + l];

					if (l != k)
					{
						a[lda * j + l] = a[lda * j + k];
						a[lda * j + k] = t;
					}
					/*
					mv              s4, s5
					mul             s4, s4, s6
					add             s4, t2, s4          # s4 = lda*j + l
					slli            s4, s4, 3           # s4 <<3 for double takes 8 byte each
					mul             s4, s4, t0 
					add             t2, s9, s4          # t2 = &a[0] + parr*8(lda*j+l)
					mv              t3, s5
					mul             t3, t3, s6
					add             t3, s8, t3          # t3 = lda*j + k
					slli            t3, t3, 3
					mul             t3, t3, t0
					add             t3, t3, s9          # t3 = &a[0] + (lda*j+k) * 8 * parr
					vl1re64.v       v4, (t2)            # v4 = a[j,l]
					vmv.v.v         v1, v4              # t(vector) put into v1 for daxpy
					vl1re64.v       v8, (t3)            # v8 = a[j,k]
					vs1r.v          v4, (t3)
					vs1r.v          v8, (t2)            #swap
					*/
					daxpy(n-(k+1),t,&a[lda*k+k+1],1,
					      &a[lda*j+k+1],1);
						  //////check
					// sub a0, s5, s11
					// mv a1, s8 --> k
					// mul a1, a1, s6 -->lda*k
					// add a1, a1, s8
					// add a1, a1, 1 --> lda*k+k+1
					// slli a1, a1, 3
					// mul a1, a1, t0 --> 8*parr*(lda*k+k+1)
					// add a1, a1, s9 --> &a[lda*k+k+1]
					//slli a3, t0, 3
					//add a3, a3, t3 --> a3 = &a[j,k+1]
					//fld fa0, (t3) for vs1r v4, (t3); the former a[j,k] is stored into t3
				}
			}
		}
	}
	ipvt[n - 1] = n - 1; // not done
}

extern void dgesl_modify(REAL a[], int lda, int n, int ipvt[], REAL b[], int job);
extern void print_100dimtst();


int main()
{
	int n = 5120000;
	double *a = (double*)malloc(n * sizeof(double));
    double *b = (double*)malloc(n * sizeof(double));
	int *ipvt = (int*)malloc(n* sizeof(int));
	double *at = (double*)malloc(n * sizeof(double));
    double *bt = (double*)malloc(n * sizeof(double));
	int *ipvtt = (int*)malloc(n* sizeof(int));
	REAL norma;
	REAL epslon(), second();
	static int i, j, lda;
	int Ntimes = 64;
	lda = 100;
	n = 100;

	matgen(at, lda, n, bt, &norma);
	dgefa(at, lda, n, ipvtt);
	
	for(i = 0 ; i < n ; i ++)
	{
		for(j = 0 ; j < n ; j ++)
		{
			for(int k = 0; k < Ntimes; k ++)
			{
				a[Ntimes * (lda*i + j) + k] = at[lda*i+j];
				//原本存一个数的位置，现在存PARR（我称Ntimes）也就是64个double
			}
		}
	}
	for(i = 0 ; i < n ; i ++){
		for(int k = 0; k < Ntimes; k ++)
		{
			b[Ntimes * i + k] = bt [i];
			ipvt[Ntimes * i + k] = ipvtt [i];
		}
	}
	/* for(i=0;i<n;i ++){
		for(int k = 0 ; k < n ; k ++){
			printf("a[%d,%d] = %lf ",i,k,*(a+NTIMES*(lda*i+k)));
		}
		printf("\n");
	} */

	dgesl_modify(a, lda, n, ipvt, b, 0);

	for(int i=0; i<100*64; i++){
		if(i%100 == 0){
			printf("===========the %d'th group==========\n", i/100);
		}
		printf("b[%d] = %lf \n", i%100, b[i]);
	}


//	print_100dimtst();
	return 0;
}
