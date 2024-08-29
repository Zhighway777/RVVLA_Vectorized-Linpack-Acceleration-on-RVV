#masktstv(int a0, int *a1, int *a2,int *back1, int* back2):                    
.section .text
.globl masktstv
masktstv:
    vle64.v         v1, (a1) 
    vle64.v         v2, (a2)
    vmflt.vv        v3, v1, v2      
    vs1r.v          v0, (a3)
    vs1r.v          v3, (a4)
