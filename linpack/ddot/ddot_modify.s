#ddot(int, double*, int, double*, int):                         # @ddot(int, double*, int, double*, int)

.section .text
    .global ddot_modify

ddot_modify:
        blez    a0, .LBB0_3
        csrr    t0, vlenb
        srli    a7, t0, 2
        bgeu    a0, a7, .LBB0_4
        li      a6, 0
        j       .LBB0_7
.LBB0_3:
        ret
.LBB0_4:
        srli    a2, t0, 3
        slli    a4, a2, 1
        slli    a2, a2, 31
        sub     a2, a2, a4
        and     a6, a2, a0
        slli    t0, t0, 1
       # li      a2, 12
				vsetvli a2, zero, e64, m1, ta, ma
        mv      a2, a6
        mv      a5, a3
        mv      a4, a1
.LBB0_5:                                # =>This Inner Loop Header: Depth=1
        vl2re64.v       v10, (a4)
        vl2re64.v       v12, (a5)
        vfmul.vv        v10, v10, v12
        vfredosum.vs    v8, v10, v8
        add     a4, a4, t0
        sub     a2, a2, a7
        add     a5, a5, t0
        bnez    a2, .LBB0_5
        vfmv.f.s        fa0, v8
        beq     a6, a0, .LBB0_9
.LBB0_7:
        slli    a6, a6, 3
        add     a2, a3, a6
        add     a1, a1, a6
        slli    a0, a0, 3
        add     a3, a3, a0
.LBB0_8:                                # =>This Inner Loop Header: Depth=1
        fld     fa5, 0(a1)
        fld     fa4, 0(a2)
        fmadd.d fa0, fa5, fa4, fa0
        addi    a2, a2, 8
        addi    a1, a1, 8
        bne     a2, a3, .LBB0_8
.LBB0_9:
        ret
