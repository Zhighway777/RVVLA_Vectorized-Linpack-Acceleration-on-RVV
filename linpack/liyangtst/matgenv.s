#REAL *a,int lda,int n,REAL b[]
.section .text                       
.global matgenv
matgenv:
    vsetvli         t0, zero, e32, m1, ta, ma
    li              a4, 1325
    vmv.v.x         v4, a4
    slli            t2, t0, 2   # <<2 not <<3 for e32 is half of e64
    li              s2, 1024
    slli            s2, s2, 6   # s2 = 64* 1024 = 65536
    li              t1, 3125
    li              t3, 0
    srli            t4, s2, 1   # t4 = 0.5*s2 = 32768
    fcvt.d.w        fa4, t4
    li              t5, 1024
    slli            t5, t5, 4   # t5 = 16k
    fcvt.d.w        fa5, t5
    li              t6, 100
    slli            t6, t6, 3
    mul             a5, t6, t0
    srli            a5, a5, 1   # >>1 for e32 if half of e64
    mul             a7, a2, a2
    li              a6, 0

loop_matrixgen:
    vsetvli         t0, zero, e32, m1, ta, ma
    vmul.vx         v4, v4, t1                      #init_int *= 3125
    vdiv.vx         v8, v4, s2                      #temp_int = init/65536   
    vmul.vx         v8, v8, s2                      #temp_int = init/65536 * 65536
    vsub.vv         v4, v4, v8                      #init = init - temp_int = init%65536
    vfwcvt.f.x.v    v20, v4
    vsetvli         t0, zero, e64, m1, ta, ma
    vfsub.vf        v20, v20, fa4                    #temp_double = init - 32768.0
    vfdiv.vf        v20, v20, fa5                    #temp_double /= 16384.0                        
    vs1r.v          v20, (a0) 
    add             a0, a0, t2
    
loop_bgen:
    vsetvli         t0, zero, e64, m1, ta, ma 
    vl1re64.v       v24, (a3)
    vfadd.vv        v24, v20, v24
    vs1r.v          v24, (a3)
    blt             a6, a5, loop_breaker
    li              a6, 0 
    add             a3, a3, t2                      # a5 = t6 * t0 = 800 * t0

loop_breaker:
    add             a6, a6, t2                      # t2 = 8 * t0 
    add             t3, t3, 1
    bne             t3, a7, loop_matrixgen          # a7 = a2 * a2 = 10 ^ 4
    ret
