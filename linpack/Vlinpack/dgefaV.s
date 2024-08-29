#REAL a[],int lda,int n, int ipvt[]
# pointer, 100, 100, pointer
.section .text                       
.global dgefaV
dgefaV:

#				addi	sp, sp,-40
#				sd		s0, 0(sp)
#				sd		s1, 8(sp)
#				sd		s3, 16(sp)
#				sd		s4, 24(sp)
#				sd		s5, 32(sp)
#				sd		s6, 40(sp)
#				sd		s7, 48(sp)
#				sd		s8, 56(sp)
#				sd		s9, 64(sp)
#				sd		s10, 72(sp)
#				sd		s11, 80(sp)
#				sd		ra, 88(sp)
				
				li              t0, 1
        sub             s10, a2, t0                 # s10 = nm1 = n-1
loopdgefa_init:
        li              s11, 0   
        mv              s9, a0                      # s9 the pointer to a[0]
        mv              s7, a3                      # s7 the pointer to ipvt
        mv              s6, a2                      # s6 the dimension n                         
loopdgefa_start:
        mv              s8, s11                     # s8 = k 
        addi            s11, s11, 1                 # s11 = kp1 = k+1
idamax_init:
        mv              s4, s8
        mul             s4, s4, s6
        add             s4, s4, s8                  # s4 = lda*k+k
        slli            s4, s4, 3                   # <<3 for double takes 8 bytes
        mul             s4, s4, t0                  # s4 = &a[k,k] - &a[0,0] = t0 * (k*lda+k) *8(byte)
        add             a1, s9, s4                  # a1 = &a[k,k]
        sub             a0, s6, s8                  # a0 = dimension = n - k
idamax:
#########################################################
#int n, double *dx, int incx, int ntimes, int *result_ret
#########################################################
        vsetvli         t0, zero, e64, m1, ta, ma
loop_init:
        vl1re64.v       v4, (a1)
        vsetvli         t0, zero, e64, m1, ta, ma
        vfabs.v         v4, v4
        slli            t1, t0, 3          
        vsetvli         t0, zero, e32, mf2, ta, ma 
        vmv.v.i         v20, 1              # 初始化索引向量，用于存储最大值位置
        vmv.v.i         v24, 1              
        vmv.v.i         v28, 1 
        li              a7, 1        
max_loop_idamax:
        add             a1, a1, t1
        vsetvli         t0, zero, e64, m1, ta, ma
        vl1re64.v       v16, (a1)
        vfabs.v         v16, v16
        vmflt.vv        v0, v16, v4
        vmerge.vvm      v4, v16, v4, v0
        vsetvli         t0, zero, e32, mf2, ta, ma
        vadd.vv         v24, v28, v24
        vmerge.vvm      v20, v24, v20, v0
        addi            a7, a7, 1
        bne             a7, a0, max_loop_idamax
loop_breaker:
        vsetvli         t0, zero, e32, mf2, ta, ma
        vsub.vv         v20, v20, v28
#向a4 存储了parr*n个最大元素位置（从对角线开始数）（min为1）   
#########################################################    
#########################################################
after_idamax:       # l = idamax(n-k,&a[lda*k+k],1) + k;    ipvt[k] = l;
#ipvt原本存储了一个矩阵的各行idamax位置
#现在ipvt1-64应当存储1-64号矩阵各行idamax位置,第一行存每一个ipvt的1号元素，以此类推
        vsetvli         t0, zero, e32, mf2, ta, ma
        mv              t1, s8              # offset = 4 * k * parr (byte)
        slli            t1, t1, 2           # t1 >> 2 for int(in ipvt) takes 4 byte
        mul             t1, t1, t0          # t1 the offset = k * parr (byte) = &ipvt[0][k] - &ipvt[0][0]
        add             t1, t1, s7          # t1 = &ipvt [0][k]
        vadd.vx         v20, v20, s8        # l = idamax(n-k,&a[lda*k+k],1) + k
        vs1r.v          v20, (t1)           # 向&ipvt[0] + k*parr 存储了64个矩阵第k行最大元素位置,也就是l
if_swap_dgefa:          #not an actually working if     #swap a[lda*k+l] and a[lda*k+k];
        vsetvli         t0, zero, e64, m1, ta, ma
        # t1 the pointer to ipvt(0)[k] = l
        lw              t2, (t1)            # t1 the pointer to ipvt[k]
        #vmv.x.s        t2, (v20)             
                                            ###trick         
        mv              s4, s8              
        mul             s4, s4, s6          
        add             s4, s4, t2          # s4 = l+k*lda
        slli            s4, s4, 3           
        mul             s4, s4, t0          # s4 = parr * (lda * k + l) * 8
        add             t2, s9, s4          # t2 = &a[0] + s4 
        mv              t3, s8
        mul             t3, t3, s6
        add             t3, t3, s8          # t3 = lda*k + k
        slli            t3, t3, 3           # t3 = lda*k+k << 3 for double takes 8 byte
        mul             t3, t3, t0
        add             t3, t3, s9          # t3 = &a[0] + parr * 8 * (lda*k+k)
        vl1re64.v       v4, (t2)            # v4 = a[k,l]
        vl1re64.v       v8, (t3)            # v8 = a[k,k]
        vs1r.v          v4, (t3)
        vs1r.v          v8, (t2)            # swap
dscal_init:
        li              t2, -1
        fcvt.d.w        fa2, t2
        vfrdiv.vf       v12, v4, fa2   
                        ######## mv    a1, v12  # t = -one / a[k,k]
                        ######## v12在dscalv原本命名为v8
        slli            t4, t0, 3
        add             t3, t3, t4
        mv              a2, t3              ###check
        sub             s3, s6, s11         # s3 = n - kp1
        mul             a0, s3, t0          # data_size = (n-k-1) * parr (double)
#########################################################   
#dscalvtst(int, double*, double*, int): #a0 = data_size (how many doubles)
#########################################################
dscalvtst:                         
        vsetvli         t0, zero, e64, m1, ta, ma
        slli            a7, a0, 3
        add             a4, a2, a7
        slli            a5, t0, 3     
                        #vl1re64.v       v8, (a1) 替换为前面残留的v12
.LBB0_6:                                                     
        vl1re64.v       v4, (a2)               
        vfmul.vv        v4, v12, v4         #   v8 替换为 v12                                         
        vs1r.v          v4, (a2)
        add             a2, a2, a5
        blt             a2, a4, .LBB0_6  
#########################################################    
#########################################################
innerloop_init:
        mv              s5, s11         #s5 the j; set init j = kp1
inner_ifswapdgefa:
#########################################################    
#########################################################
        vsetvli         t0, zero, e64, m1, ta, ma
        # t1 the pointer to ipvt(0)[k] = l
        mv              t1, s8              # offset = 4 * k * parr (byte)
        slli            t1, t1, 2           # t1 >> 2 for int(in ipvt) takes 4 byte
        mul             t1, t1, t0          # t1 the offset = k * parr (byte) = &ipvt[0][k] - &ipvt[0][0]
        add             t1, t1, s7          # t1 = &ipvt [0][k]
        lw              t2, (t1)            # t2 = l
        #vmv.x.s         t2, v20            # t1 the pointer to ipvt(0)[k] = l
        # v20 is stored by the pointer t1, so v20[0] = *(t1)
                                            # t2 = l
                                            ###trick
        mv              s4, s5
        mul             s4, s4, s6
        add             s4, t2, s4          # s4 = lda*j + l
        slli            s4, s4, 3           # s4 <<3 for double takes 8 byte each
        mul             s4, s4, t0 
        add             t2, s9, s4          # t2 = &a[0] + parr*8(lda*j+l)
        mv              t3, s5
        mul             t3, t3, s6
        add             t3, s8, t3          # t3 = lda*j + k
        slli            t3, t3, 3
        mul             t3, t3, t0
        add             t3, s9, t3          # t3 = &a[0] + (lda*j+k) * 8 * parr
        vl1re64.v       v4, (t2)            # v4 = a[j,l]
        vmv.v.v         v1, v4              # t(vector) put into v1 for daxpy
        vl1re64.v       v8, (t3)            # v8 = a[j,k]
        vs1r.v          v4, (t3)            # t3 the pointer to a[j,k]
        vs1r.v          v8, (t2)            #swap
#########################################################    
#########################################################
daxpy_init:
        vsetvli         t0, zero, e64, m1, ta, ma
        sub             a0, s6, s11             # PS: s6 = n; s11 = kp1
        mv              a1, s8                  # PS: s8 = k
        mul             a1, a1, s6              # a1 = lda*k
        add             a1, a1, s8              # a1 = lda*k+k
        addi            a1, a1, 1
        slli            a1, a1, 3               
        mul             a1, a1, t0
        add             a1, a1, s9              # a1 = &a[0] + parr * 8 *((lda*k+k) +1 )                
        slli            a3, t0, 3               
        add             a3, a3, t3              # a3 <- &a[j,k+1] = t3 + parr *8
        fld             fa0, (t3)
#########################################################
#daxpy_modify(int, double, double*, int, double*, int)    
#########################################################
daxpy:
        blez				a0, innerloop_breaker
        vsetvli			    t0, zero, e64, m1
        mul                         a0, a0, t0
        mv		            t1, a0
        vsetvli			    t0, zero, e64, m1 
loop_daxpy:				
        vfmv.v.f		    v3,	fa0             #   check
        vl1re64.v		    v1, (a1)
        vl1re64.v		    v2, (a3)
        vfmacc.vv		    v2, v3, v1
        vs1r.v			    v2, (a3)
        slli				t2, t0, 3	
        add					a1, a1, t2
        add					a3, a3, t2
        sub					t1, t1, t0
        bnez				t1, loop_daxpy
#########################################################    
#########################################################
innerloop_breaker:
        add             s5, s5, 1                       # j ++, break if j = n
        bne             s5, s6, inner_ifswapdgefa       # s6 = n
loopdgefa_breaker:
        bne             s11, s10, loopdgefa_start       # break if (k + 1 == nm1)
#				sd		ra, 88(sp)
#				sd		s11, 80(sp)
#				sd		s10, 72(sp)
#				sd		s9, 64(sp)
#				sd		s8, 56(sp)
#				sd		s7, 48(sp)
#				sd		s6, 40(sp)
#				sd		s5, 32(sp)
#				sd		s4, 24(sp)
#				sd		s3, 16(sp)
#				sd		s1, 8(sp)
#
 #     	addi	sp, sp,88
				ret
