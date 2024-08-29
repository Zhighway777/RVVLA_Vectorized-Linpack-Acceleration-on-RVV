.section .text
    .global dgefa
.LCPI0_0:
        .quad   0xbff0000000000000
dgefa:

#dgefa(double*, int, int, int*, int*):
        addi    sp, sp, -176
        sd      ra, 168(sp)
        sd      s0, 160(sp)
        sd      s1, 152(sp)
        sd      s2, 144(sp)
        sd      s3, 136(sp)
        sd      s4, 128(sp)
        sd      s5, 120(sp)
        sd      s6, 112(sp)
        sd      s7, 104(sp)
        sd      s8, 96(sp)
        sd      s9, 88(sp)
        sd      s10, 80(sp)
        sd      s11, 72(sp)
        sd      a3, 56(sp)
        sd      a4, 0(sp)
        sw      zero, 0(a4)
        li      a3, 2
        addiw   a4, a2, -1
        blt     a2, a3, .LBB0_36
        li      s8, 0
        li      t2, 0
        li      t5, 1
        slli    t0, t5, 32
        addi    t0, t0, -2
        sd      t0, 64(sp)
        addi    a3, a2, -1
        sd      a3, 40(sp)
        slli    t4, a1, 3
        addi    a5, t4, 8
        slli    a3, a2, 3
        addi    a3, a3, -8
        mul     a3, a3, a1
        add     t0, a0, a5
        addi    t3, a0, 8
        add     a3, a3, t3
        sd      a3, 8(sp)
        csrr    a6, vlenb
        slli    s3, a6, 1
        srli    t1, a6, 2
        fmv.d.x fa5, zero
        sd      t0, 24(sp)
        sd      t3, 16(sp)
        mv      s6, a4
        mv      s7, a2
        sd      a4, 48(sp)
        sd      a5, 32(sp)
        j       .LBB0_4
.LBB0_2:
        ld      a3, 0(sp)
        sw      s8, 0(a3)
.LBB0_3:
        addi    t2, t2, 1
        addi    s7, s7, -1
        addi    s6, s6, -1
        addi    t5, t5, 1
        ld      a5, 32(sp)
        add     t3, t3, a5
        add     t0, t0, a5
        mv      s8, s9
        ld      a4, 48(sp)
        beq     s9, a4, .LBB0_36
.LBB0_4:
        slli    ra, s8, 3
        mulw    a4, t2, a1
        add     t6, a0, ra
        slli    a4, a4, 3
        add     t6, t6, a4
        fld     fa4, 0(t6)
        mul     s2, a5, s8
        ld      a3, 40(sp)
        bge     s8, a3, .LBB0_9
        li      s0, 0
        add     a7, a0, s2
        slli    a4, s7, 32
        srli    a4, a4, 29
        add     a7, a7, a4
        fabs.d  fa3, fa4
        li      a5, 1
        mv      a4, t3
        j       .LBB0_7
.LBB0_6:
        addi    a4, a4, 8
        addiw   a5, a5, 1
        fmv.d   fa3, fa2
        mv      s0, s11
        beq     a4, a7, .LBB0_10
.LBB0_7:
        fld     fa2, 0(a4)
        fabs.d  fa2, fa2
        flt.d   s1, fa3, fa2
        mv      s11, a5
        bnez    s1, .LBB0_6
        mv      s11, s0
        fmv.d   fa2, fa3
        j       .LBB0_6
.LBB0_9:
        li      s11, 0
.LBB0_10:
        mul     a4, s8, a1
        addw    a5, s11, s8
        slli    a4, a4, 3
        add     a4, a4, a0
        slli    a7, a5, 3
        add     a4, a4, a7
        fld     fa3, 0(a4)
        slli    s0, s8, 2
        ld      a3, 56(sp)
        add     s0, s0, a3
        sw      a5, 0(s0)
        feq.d   a5, fa3, fa5
        addi    s9, s8, 1
        bnez    a5, .LBB0_2
        beqz    s11, .LBB0_13
        fsd     fa4, 0(a4)
        fsd     fa3, 0(t6)
        j       .LBB0_14
.LBB0_13:
        fmv.d   fa3, fa4
.LBB0_14:
        slli    a4, s6, 32
        srli    s10, a4, 32
        srli    a3, a4, 29
        add     a5, t3, a3
        bgeu    s9, a2, .LBB0_22
.Lpcrel_hi0:
        auipc   s1, %pcrel_hi(.LCPI0_0)
        fld     fa4, %pcrel_lo(.Lpcrel_hi0)(s1)
        srli    s1, a6, 2
        fdiv.d  fa4, fa4, fa3
        bgeu    s10, s1, .LBB0_17
        li      t6, 0
        j       .LBB0_20
.LBB0_17:
        srli    s1, a6, 3
        ld      a4, 64(sp)
        mul     s1, s1, a4
        and     t6, s1, s10
        vsetvli s0, zero, e64, m2, ta, ma
        mv      s0, t6
        mv      s1, t3
.LBB0_18:
        vl2re64.v       v8, (s1)
        vfmul.vf        v8, v8, fa4
        vs2r.v  v8, (s1)
        sub     s0, s0, t1
        add     s1, s1, s3
        bnez    s0, .LBB0_18
        beq     t6, s10, .LBB0_22
.LBB0_20:
        slli    t6, t6, 3
        add     s1, t3, t6
.LBB0_21:
        fld     fa3, 0(s1)
        fmul.d  fa3, fa4, fa3
        fsd     fa3, 0(s1)
        addi    s1, s1, 8
        bne     s1, a5, .LBB0_21
.LBB0_22:
        ld      s1, 24(sp)
        add     s1, s1, s2
        ld      a4, 8(sp)
        add     ra, ra, a4
        add     a4, ra, a3
        ld      s0, 16(sp)
        add     s2, s2, s0
        add     a3, a3, s2
        slti    s0, a1, 0
        add     ra, a0, a7
        sltu    a3, s1, a3
        sltu    a4, s2, a4
        and     a3, a3, a4
        or      s2, a3, s0
        mv      s4, t0
        mv      a7, t5
        j       .LBB0_24
.LBB0_23:
        addi    a7, a7, 1
        add     s4, s4, t4
        beq     a7, a2, .LBB0_3
.LBB0_24:
        mul     s1, a7, a1
        slli    a4, s1, 3
        add     a4, a4, ra
        fld     fa4, 0(a4)
        beqz    s11, .LBB0_26
        add     s1, s1, s8
        slli    s1, s1, 3
        add     s1, s1, a0
        fld     fa3, 0(s1)
        fsd     fa3, 0(a4)
        fsd     fa4, 0(s1)
.LBB0_26:
        bgeu    s9, a2, .LBB0_23
        li      a3, 128
        mv      a4, t1
        bltu    a3, t1, .LBB0_29
        li      a4, 128
.LBB0_29:
        sltu    a3, s10, a4
        or      a3, a3, s2
        beqz    a3, .LBB0_31
        li      t6, 0
        j       .LBB0_34
.LBB0_31:
        srli    a3, a6, 3
        ld      a4, 64(sp)
        mul     a3, a3, a4
        and     t6, a3, s10
        vsetvli a3, zero, e64, m2, ta, ma
        vfmv.v.f        v8, fa4
        mv      s0, t6
        mv      s5, t3
        mv      a4, s4
.LBB0_32:
        vl2re64.v       v10, (a4)
        vl2re64.v       v12, (s5)
        vfmadd.vv       v12, v8, v10
        vs2r.v  v12, (a4)
        add     a4, a4, s3
        sub     s0, s0, t1
        add     s5, s5, s3
        bnez    s0, .LBB0_32
        beq     t6, s10, .LBB0_23
.LBB0_34:
        slli    t6, t6, 3
        add     a4, t3, t6
        add     s0, s4, t6
.LBB0_35:
        fld     fa3, 0(s0)
        fld     fa2, 0(a4)
        fmadd.d fa3, fa4, fa2, fa3
        fsd     fa3, 0(s0)
        addi    a4, a4, 8
        addi    s0, s0, 8
        bne     a4, a5, .LBB0_35
        j       .LBB0_23
.LBB0_36:
        addi    a1, a1, 1
        mulw    a1, a4, a1
        slli    a1, a1, 3
        add     a0, a0, a1
        fld     fa5, 0(a0)
        slli    a0, a4, 2
        ld      a1, 56(sp)
        add     a0, a0, a1
        fmv.d.x fa4, zero
        feq.d   a1, fa5, fa4
        sw      a4, 0(a0)
        beqz    a1, .LBB0_38
        ld      a0, 0(sp)
        sw      a4, 0(a0)
.LBB0_38:
        ld      ra, 168(sp)
        ld      s0, 160(sp)
        ld      s1, 152(sp)
        ld      s2, 144(sp)
        ld      s3, 136(sp)
        ld      s4, 128(sp)
        ld      s5, 120(sp)
        ld      s6, 112(sp)
        ld      s7, 104(sp)
        ld      s8, 96(sp)
        ld      s9, 88(sp)
        ld      s10, 80(sp)
        ld      s11, 72(sp)
        addi    sp, sp, 176
        ret
