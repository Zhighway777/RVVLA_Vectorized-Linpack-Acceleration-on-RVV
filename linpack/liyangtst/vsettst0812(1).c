#include <stdio.h>

extern void vsettst0812(int n, double *dx,double *dy);
int main()
{

    int n = 16;
    double dx[160], dy[160];
    for (int i = 0 ; i< n ;i++)
    {
        dy[i] = (double)i;
    }
    vsettst0812( n,  dx, dy);
    for (int i = 0 ; i< n ;i++)
    {
        printf("%f ",dx[i]);
    }
    return 0;

}