#vsettstv(int n, double *a, double* b):
.section .text
.globl vsettstv
    li              t0, 32
    vsetvli         t0, zero, e32, m1, ta, ma
    li              t2, 0
rloop:
    vl2re64.v       v0, (a1) 
    li              t1, 2
    vs2r.V          v0, (a2)
    addi            t2, t2, 32
    addi            a1, a1, 32
    bne             t2, a0, rloop
    ret