#dgesl_vector parallel in RVV
#VLEN = 4096 = 64 double, ELEN = 64 = 1 double
#the width of vector register is 4096bit(64double) so the parallel is 64.Our aim is to optimaize the linpack, which includes 2 loops. and the external loop has 1000 times.We want to tile the external loop into PARALLEL.

#void dgesl(double *a,int lda,int n,int *ipvt,double *b,int job)
# *a: a0, lda:a1, n:a2, *ipvt:a3, *b:a4, job:a5
.section .text
.global dgesl_modify

dgesl_modify:
		mv		s0, a4	#s0 = &b
		mv		s1, a0	#s1 = &A
		mv		s2, a3	#s2 = &ipvt
		mv		t1, a2	#t1 = n number of colums/rows
		li		t0, 1
		sub		t1, t1, t0		#t1 = n-1
		li		t2, 0		#t2 = k	row index

		vsetvli	t0, zero, e64, m1
.loop_1:
		bge		t2, t1, .loop_2_initial	# t2 >= t1 quit loop, jump to loop init
		
		slli	t3, t0, 2		#stride of ipvt(64*int)
		mul		t3, t3, t2	# k offset of ipvt (k*64*int)

		add		a4, s2,	t3	#address of (64*k)'th ipvt
		
		slli	t3, t3, 1		# k offset of b (k*64*double)
		add		a5, s0, t3	#address of (64*k)'th b
		
#track
		vsetvli		t0, zero, e64
		vl1re64.v				v1, (a4)		#v1 get 64 (64*k)'th ipvt #l = ipvt[k]
		vsext.vf2				v2, v1			#extend v1 to v2
		slli					t0, t0, 3	
		vmul.vx				v2, v2, t0		#v2 = v2*64 (stride of b)
		vid.v					v5						#v5 = 0,1,2...63
		vsll.vi				v5, v5, 3			#v5[i] = i*8
		vadd.vv				v2, v2, v5		#v2 = v2+v5
		vadd.vx				v2, v2, s0	
		#!!这里v2中存的数为b[2,0]~b[2,63]的地址，而不仅仅存b[2,0]的地址	
		vluxei64.v		v3, (zero), v2		#v3[i] = (s0+v2[i]) #t = b[l]
		#index * 64 *8

		vle64.v				v4, (a5)					#v4[i] = (s0+offset of b) #v4 get b[k]
		
		vsuxei64.v		v4, (zero), v2		#store b[k] into &b[l] #b[l] = b[k]

		vse64.v			v3, (a5)					#store v3 into &b[k]  #b[k] = t

#initial daxpy:
		add			t5, t1, zero	#t5 = n-1
		sub			a0, t5, t2		#a0 = n-(k+1)
		
		mul			t6, a1, t2
		add			t6, t6, t2
		addi		a2, t6, 1			#a2 = lda*k+k+1
		addi		a3, t2, 1			#a3 = k+1
		vsetvli t0, zero, e64, m1
		slli		t3, t0, 3			#vl*8 (bytes)
		mul			a2,	a2, t3		#offset of a
		mul			a3, a3, t3		#offset of b
		add			s3, s1, a2		#update address of a[]
		add			s4, s0, a3		#update address pf b[]
daxpy_1: 
#n: a0, da: v3, dx: s1, dy:s0
				blez				a0, .daxpy_1_over
				vsetvli			t0, zero, e64, m1
				mul					t6, a0, t0		#daxpy input size in actually

.daxpy_loop_1:				
				#t = v3
				vl1re64.v		v1, (s3)		#load	dx
				vl1re64.v		v2, (s4)		#load	dy
				vfmacc.vv		v2, v3, v1	#dy = da * dx + dy
				vs1r.v			v2, (s4)		#store dy
			
				slli				t5, t0, 3	
				add					s3, s3, t5
				add					s4, s4, t5
				sub					t6, t6, t0
				bnez				t6, .daxpy_loop_1

.daxpy_1_over:
		addi	t2, t2, 1		# k++
		j			.loop_1

.loop_2_initial:
		##t1 = n-1
		addi		t1, t1, 1		#t1 = n
		li			t2, 0				#t2 = kb	row index
		vsetvli	t0, zero, e64, m1

.loop_2:
		bge		t2, t1, .done	# t2 >= t1 quit loop

		addi	t3, t2, 1			
		sub		t3, t1, t3		# k: t3 = n - (kb+1)
		
		mul		t4, a1, t3
		add		t4, t4, t3		#	t4 = lda*k+k
		
		slli	t5, t0, 3			#stride of b[] (64* duoble)
		mul		t4, t4, t5		#offset of a	([lda*k+k] * 64 * double) 
		add		a5, s1, t4		#a5 get address of a[64 * lda*k+k]	

		mul		t4, t3 ,t5		#offset of b	(k * 64 *duoble)
		add		a6, s0, t4		#a6 get address of 64*b[k]

		vle64.v			v2, (a6)		#v2 get 64*b[k]
		vle64.v			v4, (a5)		#v4 get 64 a[lda*k+k]
		vfdiv.vv			v2, v2, v4			#v2 = v2/v4
		vse64.v			v2, (a6)		#store v2 into b[k]
		vfneg.v				v3, v2					#t = -b[k]
	
#initial daxpy:
		mv			a0, t3								#a0 = k
		#				t = v3
		mul			a2, a1, a0						#a2 = lda*k
		vsetvli	t0, zero, e64
		slli		a6, t0, 3
		mul			a2, a2,	a6					#offset of a (lda*k * 64double)
		add			s3, s1, a2					#update address of a[lda*k]
		mv			s4, s0							#address of b[0]
daxpy_2: 
#n: a0, da: v3, dx: s1, dy:s0
				blez				a0, .daxpy_2_over
				vsetvli			t0, zero, e64, m1
				mul					t6, a0, t0

.daxpy_loop_2:				
				#t = v3
				vl1re64.v		v1, (s3)		#load	dx
				vl1re64.v		v2, (s4)		#load	dy
				vfmacc.vv		v2, v3, v1	#dy = da * dx + dy
				vs1r.v			v2, (s4)		#store dy
			
				slli				t5, t0, 3		
				add					s4, s4, t5
				add					s3, s3, t5
				sub					t6, t6, t0
				bnez				t6, .daxpy_loop_2

.daxpy_2_over:
		addi	t2, t2, 1		# kb++
		j			.loop_2

.done:
		ret


