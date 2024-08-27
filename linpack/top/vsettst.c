#include <stdio.h>


extern void vsettst(int n, int *a);


int main()

{

    int tstarr[200];
    int tstarr1[200];
    int n;
    n = 0;

    for (int i = 0; i < 128; i ++){
        tstarr[i] = i;
        tstarr1[i] = 2*i;
        n++;
    } 

    vsettst(n, tstarr);

    int flg = 0;
    for(int i = 0; i < 128; i ++){
        flg = (tstarr1[i]- tstarr[i])?1:0;
    }

    for (int i = 0; i < 128; i ++){
        printf("%d ",tstarr[i]);
        if((i+1) % 32 == 0)
        {
            printf("\n");
        }
    } 
    if (flg == 0) printf("\n correct\n");
    else printf("\n error\n");
    return 0;

}
