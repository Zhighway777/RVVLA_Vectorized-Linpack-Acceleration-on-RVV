#dgesl_vector in RVV
#VLEN = 4096 = 64 double, ELEN = 64 = 1 double
#void dgesl(double *a,int lda,int n,int *ipvt,double *b,int job)
# *a: a0, lda:a1, n:a2, *ipvt:a3, *b:a4, job:a5
.section .text
.global dgesl_modify_2

dgesl_modify_2:
	addi		sp, sp, -32
	sd			ra, 24(sp)
	sd		s0, 16(sp)
	sd		s1, 8(sp)

	mv		s0, a4
	mv		s1, a0
	mv		s2, a2
	mv		t1, a2
	addi	t1, t1, -1	#t1 = n-1
	li		t2, 0				# t2 = k

	vsetvli	t0, zero, e64, m1
.loop_1:
	bge		t2, t1, .loop_2

	slli	t3, t0, 2	
	mul		t3, t3, t2
	add		a4, s2, t3
	slli	t3, t3, 1
	add		a5,	s0,	t3 

	vsetvli	t0, zero, e32
	vl1re64.v		v1, (a4)
	vsext.vf2		v2, v1
	
	vsetvli	t0, zero, e64
	vlu


