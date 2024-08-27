#include <stdio.h>
extern void vlenbprint(int *p);
int main()
{
    int p;
    vlenbprint(&p);
    printf("%d",p);
    return 0;
}