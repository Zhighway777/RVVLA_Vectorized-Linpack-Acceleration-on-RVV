#include <stdio.h>

extern void masktstv(int a0, int *a1, int *a2,int *back1, int* back2);
static int tst1[3]={1,2,3};
static int tst2[3]={4,1,6};
int main()
{
    int v0rec[5] = {0,0,0,0,0};
    int v3rec[5] = {0,0,0,0,0};

    masktstv(3, tst1, tst2, v0rec, v3rec);
    
    int flg = 1;
    for(int i = 0 ; i < 3 ; i++)
    {
        if(v0rec[i] == (tst1>=tst2))
        {
            flg = 0;
        }
    }
    if (!flg) {
        printf("v0 works as mask vector\n");
    }else{
        printf("v0 does not work as mask vector\n");
    }

    flg = 1;
    for(int i = 0 ; i < 3 ; i++)
    {
        if(v3rec[i] == (tst1>=tst2))
        {
            flg = 0;
        }
    }

    if (!flg) {
        printf("v3 works as mask vector");
    }else{
        printf("v3 does not work as mask vector");
    }
    return 0;
}
