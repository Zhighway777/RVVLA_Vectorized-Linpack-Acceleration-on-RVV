#REAL *a,int lda,int n,REAL b[]
.section .text                       
.global matgenv
matgenv:
		addi	sp, sp,-16
		sd		s0, 0(sp)
		sd		s1, 8(sp)
		sd		ra, 16(sp)



		vsetvli         t0, zero, e32, m1, ta, ma
    li              a4, 1325
    vmv.v.x         v4, a4
    slli            t2, t0, 2   # <<2 not <<3 for e32 is half of e64
    li              s0, 1024
		slli            s0, s0, 6   # s2 = 64* 1024 = 65536
    li              t1, 3125
    li              t3, 0
    srli            t4, s0, 1   # t4 = 0.5*s2 = 32768
    fcvt.d.w        fa4, t4
    li              t5, 1024
    slli            t5, t5, 4   # t5 = 16k
    fcvt.d.w        fa5, t5
    mv              t6, a2
    slli            t6, t6, 2		# <<2 for e32
		mul             a5, t6, t0 
		add							a5, a5, a3
		mul             a7, a2, a2
    mv              s1, a3

loop_matrixgen:
    vsetvli         t0, zero, e32, m1, ta, ma
    vmul.vx         v4, v4, t1                      #init_int *= 3125
    vdiv.vx         v8, v4, s0                      #temp_int = init/65536   
    vmul.vx         v8, v8, s0                      #temp_int = init/65536 * 65536
    vsub.vv         v4, v4, v8                      #init = init - temp_int = init%65536
    vfwcvt.f.x.v    v20, v4
    vsetvli         t0, zero, e64, m1, ta, ma
    vfsub.vf        v20, v20, fa4                    #temp_double = init - 32768.0
    vfdiv.vf        v20, v20, fa5                    #temp_double /= 16384.0                        
    vs1r.v          v20, (a0) 
    add             a0, a0, t2
    
loop_bgen:
    vsetvli         t0, zero, e64, m1, ta, ma 
    vl1re64.v       v24, (s1)
    vfadd.vv        v24, v20, v24
    vs1r.v          v24, (s1)
    add             s1, s1, t2
    bne             s1, a5, loop_breaker
    mv              s1, a3                           # a5 = t6 * t0 = 800 * t0

loop_breaker:
    add             t3, t3, 1
    bne             t3, a7, loop_matrixgen          # a7 = a2 * a2 = 10 ^ 4
    
		ld		ra, 16(sp)
		ld		s1, 8(sp)
		ld		s0, 0(sp)
		addi	sp, sp,16

		ret
