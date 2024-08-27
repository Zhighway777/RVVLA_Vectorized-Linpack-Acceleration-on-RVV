#dgesl(double*, int, int, int*, double*, int):
.section .text
    .global dgesl

dgesl:
        addi    sp, sp, -64
        sd      s0, 56(sp)
        sd      s1, 48(sp)
        sd      s2, 40(sp)
        sd      s3, 32(sp)
        sd      s4, 24(sp)
        sd      s5, 16(sp)
        sd      s6, 8(sp)
        sd      s7, 0(sp)
        addiw   a6, a2, -1
        beqz    a5, .LBB0_25
        blez    a2, .LBB0_57
        li      t4, 0
        slli    t0, a1, 3
        csrr    a5, vlenb
        slli    t6, a5, 1
        srli    a7, a5, 2
        fmv.d.x fa5, zero
        vsetvli a5, zero, e64, m1, ta, ma
        vmv.s.x v8, zero
        mv      t1, a0
        j       .LBB0_4
.LBB0_3:
        mul     a5, t4, a1
        fld     fa3, 0(t5)
        slli    a5, a5, 3
        add     t2, t2, a0
        add     a5, a5, t2
        fld     fa2, 0(a5)
        fsub.d  fa4, fa3, fa4
        fdiv.d  fa4, fa4, fa2
        fsd     fa4, 0(t5)
        addi    t4, t4, 1
        add     t1, t1, t0
        beq     t4, a2, .LBB0_12
.LBB0_4:
        slli    t2, t4, 3
        add     t5, a4, t2
        fmv.d   fa4, fa5
        beqz    t4, .LBB0_3
        bgeu    t4, a7, .LBB0_7
        li      t3, 0
        fmv.d   fa4, fa5
        j       .LBB0_10
.LBB0_7:
        neg     a5, a7
        and     t3, t4, a5
        vsetvli a5, zero, e64, m2, ta, ma
        mv      a5, t3
        mv      s1, a4
        mv      s0, t1
        vmv2r.v v10, v8
.LBB0_8:
        vl2re64.v       v12, (s0)
        vl2re64.v       v14, (s1)
        vfmul.vv        v12, v12, v14
        vfredosum.vs    v10, v12, v10
        add     s0, s0, t6
        sub     a5, a5, a7
        add     s1, s1, t6
        bnez    a5, .LBB0_8
        vfmv.f.s        fa4, v10
        beq     t4, t3, .LBB0_3
.LBB0_10:
        slli    t3, t3, 3
        add     a5, a4, t3
        add     s1, t1, t3
.LBB0_11:
        fld     fa3, 0(s1)
        fld     fa2, 0(a5)
        fmadd.d fa4, fa3, fa2, fa4
        addi    a5, a5, 8
        addi    s1, s1, 8
        bne     a5, t5, .LBB0_11
        j       .LBB0_3
.LBB0_12:
        li      a5, 1
        beq     a2, a5, .LBB0_57
        addiw   a5, a2, -2
        beqz    a5, .LBB0_57
        addi    s1, a1, 1
        addi    t1, a0, 8
        mulw    t5, a5, s1
        not     t0, a1
        slli    a1, a2, 3
        add     a1, a1, a4
        addi    s2, a1, -8
        li      t4, 1
        fmv.d.x fa5, zero
        j       .LBB0_16
.LBB0_15:
        addw    t5, t5, t0
        addi    s2, s2, -8
        beq     t4, a6, .LBB0_57
.LBB0_16:
        slli    t2, t5, 3
        bgeu    t4, a7, .LBB0_18
        li      t3, 0
        fmv.d   fa4, fa5
        j       .LBB0_21
.LBB0_18:
        add     a5, t1, t2
        neg     s1, a7
        and     t3, t4, s1
        vsetvli s0, zero, e64, m2, ta, ma
        mv      s0, t3
        mv      s1, s2
        vmv2r.v v10, v8
.LBB0_19:
        vl2re64.v       v12, (a5)
        vl2re64.v       v14, (s1)
        vfmul.vv        v12, v12, v14
        vfredosum.vs    v10, v12, v10
        add     a5, a5, t6
        sub     s0, s0, a7
        add     s1, s1, t6
        bnez    s0, .LBB0_19
        vfmv.f.s        fa4, v10
        beq     t4, t3, .LBB0_23
.LBB0_21:
        slli    t3, t3, 3
        add     a5, s2, t3
        add     t3, t3, t1
        add     t2, t2, t3
.LBB0_22:
        fld     fa3, 0(t2)
        fld     fa2, 0(a5)
        fmadd.d fa4, fa3, fa2, fa4
        addi    a5, a5, 8
        addi    t2, t2, 8
        bne     a5, a1, .LBB0_22
.LBB0_23:
        addi    t4, t4, 1
        sub     a0, a2, t4
        slli    a5, a0, 3
        add     a5, a5, a4
        fld     fa3, 0(a5)
        slli    s0, a0, 2
        add     s0, s0, a3
        lw      s1, 0(s0)
        sext.w  a0, a0
        fadd.d  fa4, fa4, fa3
        fsd     fa4, 0(a5)
        beq     s1, a0, .LBB0_15
        slli    s1, s1, 3
        add     s1, s1, a4
        fld     fa3, 0(s1)
        fsd     fa4, 0(s1)
        fsd     fa3, 0(a5)
        j       .LBB0_15
.LBB0_25:
        li      a5, 1
        slli    a7, a5, 32
        addi    a7, a7, -2
        bge     a5, a2, .LBB0_42
        li      t4, 0
        li      s4, 0
        addi    t0, a1, 1
        addi    t1, a0, 8
        addi    t2, a4, 8
        csrr    t3, vlenb
        slli    s7, t3, 1
        srli    t5, t3, 2
        mv      t6, t2
        mv      s5, a6
        j       .LBB0_28
.LBB0_27:
        addi    s5, s5, -1
        addi    t6, t6, 8
        addw    t4, t4, t0
        beq     s4, a6, .LBB0_42
.LBB0_28:
        mv      s1, s4
        slli    a5, s4, 2
        add     a5, a5, a3
        lwu     a5, 0(a5)
        sext.w  s0, a5
        slli    s0, s0, 3
        add     s0, s0, a4
        fld     fa5, 0(s0)
        slli    s6, s4, 3
        beq     s4, a5, .LBB0_30
        add     a5, a4, s6
        fld     fa4, 0(a5)
        fsd     fa4, 0(s0)
        fsd     fa5, 0(a5)
.LBB0_30:
        addi    s4, s1, 1
        bgeu    s4, a2, .LBB0_27
        li      s0, 128
        mv      a5, t5
        bltu    s0, t5, .LBB0_33
        li      a5, 128
.LBB0_33:
        slli    s0, s5, 32
        srli    s3, s0, 32
        slli    s2, t4, 3
        bltu    s3, a5, .LBB0_36
        add     s6, s6, t2
        srli    a5, s0, 29
        mulw    s1, t0, s1
        slli    s1, s1, 3
        add     s1, s1, t1
        add     s0, s1, a5
        bgeu    s6, s0, .LBB0_39
        add     a5, a5, s6
        bgeu    s1, a5, .LBB0_39
.LBB0_36:
        li      s6, 0
.LBB0_37:
        add     s3, s3, t4
        slli    a5, s3, 3
        add     a5, a5, t1
        slli    s1, s6, 3
        add     s0, s1, s2
        add     s0, s0, t1
        add     s1, s1, t6
.LBB0_38:
        fld     fa4, 0(s1)
        fld     fa3, 0(s0)
        fmadd.d fa4, fa5, fa3, fa4
        fsd     fa4, 0(s1)
        addi    s0, s0, 8
        addi    s1, s1, 8
        bne     s0, a5, .LBB0_38
        j       .LBB0_27
.LBB0_39:
        add     a5, t1, s2
        srli    s0, t3, 3
        mul     s0, s0, a7
        and     s6, s0, s3
        vsetvli s0, zero, e64, m2, ta, ma
        vfmv.v.f        v8, fa5
        mv      s1, s6
        mv      s0, t6
.LBB0_40:
        vl2re64.v       v10, (s0)
        vl2re64.v       v12, (a5)
        vfmadd.vv       v12, v8, v10
        vs2r.v  v12, (s0)
        add     s0, s0, s7
        sub     s1, s1, t5
        add     a5, a5, s7
        bnez    s1, .LBB0_40
        beq     s6, s3, .LBB0_27
        j       .LBB0_37
.LBB0_42:
        blez    a2, .LBB0_57
        li      t4, 0
        li      t3, 0
        slli    a3, a1, 3
        neg     t2, a3
        addi    a3, a2, -1
        mul     a3, a3, a1
        slli    a3, a3, 3
        add     t0, a0, a3
        csrr    t1, vlenb
        slli    s5, t1, 1
        srli    s3, t1, 2
        mv      s4, t0
        j       .LBB0_45
.LBB0_44:
        addi    a6, a6, -1
        add     s4, s4, t2
        beq     t4, a2, .LBB0_57
.LBB0_45:
        mv      s2, t4
        addi    t4, t4, 1
        addi    t3, t3, 1
        sub     s1, a2, t4
        subw    t5, a2, t3
        slli    a3, s1, 3
        add     s0, a4, a3
        fld     fa5, 0(s0)
        mulw    a5, t5, a1
        add     a3, a3, a0
        slli    a5, a5, 3
        add     a3, a3, a5
        fld     fa4, 0(a3)
        fdiv.d  fa5, fa5, fa4
        fsd     fa5, 0(s0)
        blez    s1, .LBB0_44
        li      a5, 128
        mv      a3, s3
        bltu    a5, s3, .LBB0_48
        li      a3, 128
.LBB0_48:
        slli    a5, a6, 32
        srli    t6, a5, 32
        srli    t5, a5, 29
        fneg.d  fa5, fa5
        bltu    t6, a3, .LBB0_51
        mul     a3, t2, s2
        add     a3, a3, t0
        add     a5, a3, t5
        bgeu    a4, a5, .LBB0_54
        add     a5, a4, t5
        bgeu    a3, a5, .LBB0_54
.LBB0_51:
        li      s2, 0
.LBB0_52:
        add     t5, t5, s4
        slli    s1, s2, 3
        add     a3, s4, s1
        add     s1, s1, a4
.LBB0_53:
        fld     fa4, 0(s1)
        fld     fa3, 0(a3)
        fmadd.d fa4, fa5, fa3, fa4
        fsd     fa4, 0(s1)
        addi    a3, a3, 8
        addi    s1, s1, 8
        bne     a3, t5, .LBB0_53
        j       .LBB0_44
.LBB0_54:
        srli    a3, t1, 3
        mul     a3, a3, a7
        and     s2, a3, t6
        vsetvli a3, zero, e64, m2, ta, ma
        vfmv.v.f        v8, fa5
        mv      s1, s2
        mv      a3, s4
        mv      s0, a4
.LBB0_55:
        vl2re64.v       v10, (s0)
        vl2re64.v       v12, (a3)
        vfmadd.vv       v12, v8, v10
        vs2r.v  v12, (s0)
        add     s0, s0, s5
        sub     s1, s1, s3
        add     a3, a3, s5
        bnez    s1, .LBB0_55
        beq     s2, t6, .LBB0_44
        j       .LBB0_52
.LBB0_57:
        ld      s0, 56(sp)
        ld      s1, 48(sp)
        ld      s2, 40(sp)
        ld      s3, 32(sp)
        ld      s4, 24(sp)
        ld      s5, 16(sp)
        ld      s6, 8(sp)
        ld      s7, 0(sp)
        addi    sp, sp, 64
        ret
