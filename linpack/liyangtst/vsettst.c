#include <stdio.h>


extern void vsettstv(int n, double *a,double *b);


int main()

{

    int tstarr[200];
    int tstarri[200];
    int n;
    n = 128;

    for (int i = 0; i < 128; i ++){
        tstarr[i] = i;
        tstarri[i] = 0;
        n++;
    } 

    vsettstv(n, tstarr, tstarri);

    for (int i = 0; i < 128; i ++){
        printf("%d ",tstarri[i]);
        if((i+1) % 32 == 0)
        {
            printf("\n");
        }
    } 

    return 0;

}