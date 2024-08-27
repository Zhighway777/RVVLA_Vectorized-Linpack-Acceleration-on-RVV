#daxpy_modify(int, double, double*, int, double*, int)

.section .text
.globl daxpy_modify

daxpy_modify:
				blez				a0, .LBB0_9
				mv					t1, a0
				vsetvli			t0, a0, e64, m1 

loop:				

				vfmv.v.f		v0,	fa0
				vl1re64.v		v1, (a1)
				vl1re64.v		v2, (a3)
				vfmacc.vv		v2, v0, v1
				vs1r.v			v2, (a3)
			
				slli				t2, t0, 3	
				add					a1, a1, t2
				add					a3, a3, t2
				sub					t1, t1, t0
				bnez				t1, loop

.LBB0_9:
				ret
 
