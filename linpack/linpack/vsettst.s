#vsettstv(int n, int *a):
.section .text
.globl masktstv
    li              t0, 32
    vsetvli         t0, zero, e32, m1, ta, ma
    li              t2, 0
rloop:
    vle64.v         v0, (a1) 
    li              t1, 2
    vmul.vx         v0, v0, t1
    vs1r.V          v0, (a1)
    addi            t2, t2, 32
    addi            a1, a1, 32
    bne             t2, a0, rloop
