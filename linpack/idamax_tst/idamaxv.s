.section .text
.global idamaxv

idamaxv:

				addi    sp, sp, -496
        sd      ra, 488(sp)
        sd      s0, 480(sp)
        sd      s1, 472(sp)
        sd      s2, 464(sp)
        sd      s3, 456(sp)
        sd      s4, 448(sp)
        sd      s5, 440(sp)
        sd      s6, 432(sp)
        sd      s7, 424(sp)
        lui     a2, 1
        addiw   a2, a2, 1632
        sub     sp, sp, a2
        mv      s2, a4
        mv      s6, a3
        mv      s4, a1
        mv      s5, a0
        slli    s3, a3, 2
        csrr    s7, vlenb
        blez    a3, .LBB0_7
        addi    a0, sp, 8
        li      a1, 0
        mv      a2, s3
        call    memset
        srli    a0, s7, 2
        li      a1, 0
        bltu    s6, a0, .LBB0_5
        srli    a1, s7, 3
        slli    a2, a1, 1
        slli    a1, a1, 31
        sub     a1, a1, a2
        and     a1, a1, s6
        slli    a2, s7, 1
        addi    a3, sp, 2047
        addi    a3, a3, 9
        vsetvli a4, zero, e64, m2, ta, ma
        mv      a4, a1
        mv      a5, s4
.LBB0_3:
        vl2re64.v       v8, (a5)
        vfabs.v v8, v8
        vs2r.v  v8, (a3)
        add     a5, a5, a2
        sub     a4, a4, a0
        add     a3, a3, a2
        bnez    a4, .LBB0_3
        beq     a1, s6, .LBB0_7
.LBB0_5:
        slli    a1, a1, 3
        addi    a2, sp, 2047
        addi    a2, a2, 9
        add     a0, a2, a1
        add     a1, a1, s4
        slli    a3, s6, 3
        add     a2, a2, a3
.LBB0_6:
        fld     fa5, 0(a1)
        fabs.d  fa5, fa5
        fsd     fa5, 0(a0)
        addi    a0, a0, 8
        addi    a1, a1, 8
        bne     a0, a2, .LBB0_6
.LBB0_7:
        li      a0, 2
        blt     s5, a0, .LBB0_20
        lui     a0, 524288
        addiw   a0, a0, -2
        slli    a1, s6, 32
        srli    t0, a1, 32
        slli    s0, s7, 1
        srli    a2, s7, 2
        srli    a1, a1, 29
        addi    a7, sp, 2047
        addi    a7, a7, 9
        add     a4, a7, a1
        li      a5, 1
        addi    a6, sp, 8
        srli    a1, s7, 3
        mul     a0, a1, a0
        and     t1, a0, t0
        mv      t3, s6
        j       .LBB0_10
.LBB0_9:
        addi    a5, a5, 1
        add     t3, t3, s6
        beq     a5, s5, .LBB0_20
.LBB0_10:
        blez    s6, .LBB0_9
        slli    a0, t3, 32
        srli    t2, a0, 29
        bgeu    t0, a2, .LBB0_13
        li      a0, 0
        j       .LBB0_16
.LBB0_13:
        add     a0, s4, t2
        vsetvli a1, zero, e32, m1, ta, ma
        vmv.v.x v8, a5
        addi    a1, sp, 2047
        addi    a1, a1, 9
        addi    a3, sp, 8
        mv      s1, t1
.LBB0_14:
        vl2re64.v       v10, (a0)
        vsetvli zero, zero, e64, m2, ta, ma
        vl2re64.v       v12, (a1)
        vfabs.v v10, v10
        vmflt.vv        v0, v12, v10
        vse64.v v10, (a1), v0.t
        vse32.v v8, (a3), v0.t
        add     a0, a0, s0
        add     a1, a1, s0
        sub     s1, s1, a2
        add     a3, a3, s7
        bnez    s1, .LBB0_14
        mv      a0, t1
        beq     t1, t0, .LBB0_9
.LBB0_16:
        slli    a1, a0, 3
        add     a3, s4, a1
        add     a3, a3, t2
        slli    a0, a0, 2
        add     a0, a0, a6
        add     a1, a1, a7
        j       .LBB0_18
.LBB0_17:
        addi    a3, a3, 8
        addi    a1, a1, 8
        addi    a0, a0, 4
        beq     a1, a4, .LBB0_9
.LBB0_18:
        fld     fa5, 0(a3)
        fld     fa4, 0(a1)
        fabs.d  fa5, fa5
        flt.d   s1, fa4, fa5
        beqz    s1, .LBB0_17
        fsd     fa5, 0(a1)
        sw      a5, 0(a0)
        j       .LBB0_17
.LBB0_20:
        blez    s6, .LBB0_22
        addi    a1, sp, 8
        mv      a0, s2
        mv      a2, s3
        call    memcpy
.LBB0_22:
        lui     a0, 1
        addiw   a0, a0, 1632
        add     sp, sp, a0
        ld      ra, 488(sp)
        ld      s0, 480(sp)
        ld      s1, 472(sp)
        ld      s2, 464(sp)
        ld      s3, 456(sp)
        ld      s4, 448(sp)
        ld      s5, 440(sp)
        ld      s6, 432(sp)
        ld      s7, 424(sp)
        addi    sp, sp, 496
        ret
