#include<stdio.h>

extern void idamaxv_ofmine(int n, double *dx, int incx, int ntimes, int *result_ret);
/* {
    double maxtemp[512];
    
    int maxindex[512];
    double fabdxi;
    for(int i = 0 ; i < ntimes; i ++)
    {
        fabdxi = (dx[i]>0)? dx[i]:(0.00-dx[i]);
        maxtemp[i] = fabdxi;
        maxindex[i] = 0;
    }
    
    for(int j = 1; j < n ; j ++){
        for(int i = 0 ; i < ntimes; i ++){
            fabdxi = (dx[j*ntimes+i]>0)? dx[j*ntimes+i]:(0.00-dx[j*ntimes+i]);
            if(fabdxi>maxtemp[i]){
                maxtemp[i] = fabdxi;
                maxindex[i] = j;
            }
        }
    }
    for(int i = 0 ; i < ntimes; i ++){
        result_ret[i] = maxindex[i];
    }
    return ;
} */

int main()
{
    int n = 3; 
    int ntimes = 64;
    double dx[4096]={
        1.00, 2.00, 3.00, 1.00, 1.00, 2.00, 3.00, 1.00, 1.00, 2.00, 3.00, 1.00, 1.00, 2.00, 3.00, 1.00,
        1.00, 2.00, 3.00, 1.00, 1.00, 2.00, 3.00, 1.00, 1.00, 2.00, 3.00, 1.00, 1.00, 2.00, 3.00, 1.00,    
        1.00, 2.00, 3.00, 1.00, 1.00, 2.00, 3.00, 1.00, 1.00, 2.00, 3.00, 1.00, 1.00, 2.00, 3.00, 1.00,
        1.00, 2.00, 3.00, 1.00, 1.00, 2.00, 3.00, 1.00, 1.00, 2.00, 3.00, 1.00, 1.00, 2.00, 3.00, 1.00,

        2.00, 1.00, 1.00, 2.00, 2.00, 1.00, 1.00, 2.00, 2.00, 1.00, 1.00, 2.00, 2.00, 1.00, 1.00, 2.00, 
        2.00, 1.00, 1.00, 2.00, 2.00, 1.00, 1.00, 2.00, 2.00, 1.00, 1.00, 2.00, 2.00, 1.00, 1.00, 2.00, 
        2.00, 1.00, 1.00, 2.00, 2.00, 1.00, 1.00, 2.00, 2.00, 1.00, 1.00, 2.00, 2.00, 1.00, 1.00, 2.00, 
        2.00, 1.00, 1.00, 2.00, 2.00, 1.00, 1.00, 2.00, 2.00, 1.00, 1.00, 2.00, 2.00, 1.00, 1.00, 2.00, 
    
        3.00, 1.00, 1.00, 1.00, 3.00, 1.00, 1.00, 1.00, 3.00, 1.00, 1.00, 1.00, 3.00, 1.00, 1.00, 1.00, 
        3.00, 1.00, 1.00, 1.00, 3.00, 1.00, 1.00, 1.00, 3.00, 1.00, 1.00, 1.00, 3.00, 1.00, 1.00, 1.00, 
        3.00, 1.00, 1.00, 1.00, 3.00, 1.00, 1.00, 1.00, 3.00, 1.00, 1.00, 1.00, 3.00, 1.00, 1.00, 1.00, 
        3.00, 1.00, 1.00, 1.00, 3.00, 1.00, 1.00, 1.00, 3.00, 1.00, 1.00, 1.00, 3.00, 1.00, 1.00, 1.00, 
    };
    int incx = 1;
    int result_ret[512];
    int itercnter = 0;
    idamaxv_ofmine(n, dx, incx, ntimes, result_ret);
    for(int i = 0 ; i < ntimes; i ++){
        printf("%d ",result_ret[i]);
    } 
    return 0;
}