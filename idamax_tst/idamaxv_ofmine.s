#int n, double *dx, int incx, int ntimes, int *result_ret
.section .text                       
.global idamaxv_ofmine
#n = dimension
#ntimes = parrellel
idamaxv_ofmine: 
    vsetvli         t0, zero, e64, m1, ta, ma
loop_init:
    vl1re64.v       v4, (a1)
    vsetvli         t0, zero, e64, m1, ta, ma
    vfabs.v         v4, v4
    slli            t1, t0, 3          
    vsetvli         t0, zero, e32, m1, ta, ma 
    vmv.v.i         v20, 1              # 初始化索引向量，用于存储最大值位置
    vmv.v.i         v24, 1              
    vmv.v.i         v28, 1 
    li              a7, 1        
max_loop_idamax:
    add             a1, a1, t1
    vsetvli         t0, zero, e64, m1, ta, ma
    vl1re64.v       v16, (a1)
    vmflt.vv        v0, v16, v4
    vmerge.vvm      v4, v16, v4, v0
    vsetvli         t0, zero, e32, m1, ta, ma
    vadd.vv         v24, v28, v24
    vmerge.vvm      v20, v24, v20, v0
    addi            a7, a7, 1
    bne             a7, a0, max_loop_idamax
loop_breaker:
    vsetvli         t0, zero, e32, m1, ta, ma
    vse32.v         v20, (a4)
    ret