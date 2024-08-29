#daxpy(int, double, double*, int, double*, int):                       # @daxpy(int, double, double*, int, double*, int)
.section .text
    .global daxpy

        blez    a0, .LBB0_9
        csrr    a2, vlenb
        srli    a4, a2, 2
        li      a5, 16
        bltu    a5, a4, .LBB0_3
        li      a4, 16
.LBB0_3:
        slli    a6, a0, 3
        bltu    a0, a4, .LBB0_6
        add     a4, a1, a6
        bgeu    a3, a4, .LBB0_10
        add     a4, a3, a6
        bgeu    a1, a4, .LBB0_10
.LBB0_6:
        li      a7, 0
.LBB0_7:
        slli    a7, a7, 3
        add     a0, a1, a7
        add     a3, a3, a7
        add     a1, a1, a6
.LBB0_8:                                # =>This Inner Loop Header: Depth=1
        fld     fa5, 0(a3)
        fld     fa4, 0(a0)
        fmadd.d fa5, fa0, fa4, fa5
        fsd     fa5, 0(a3)
        addi    a0, a0, 8
        addi    a3, a3, 8
        bne     a0, a1, .LBB0_8
.LBB0_9:
        ret
.LBB0_10:
        srli    a4, a2, 3
        slli    a5, a4, 1
        slli    a4, a4, 31
        sub     a4, a4, a5
        and     a7, a4, a0
        srli    t0, a2, 2
        vsetvli a4, zero, e64, m2, ta, ma
        vfmv.v.f        v8, fa0
        slli    t1, a2, 1
        mv      a4, a7
        mv      a2, a1
        mv      a5, a3
.LBB0_11:                               # =>This Inner Loop Header: Depth=1
        vl2re64.v       v10, (a5)
        vl2re64.v       v12, (a2)
        vfmadd.vv       v12, v8, v10
        vs2r.v  v12, (a5)
        add     a5, a5, t1
        sub     a4, a4, t0
        add     a2, a2, t1
        bnez    a4, .LBB0_11
        beq     a7, a0, .LBB0_9
        j       .LBB0_7
