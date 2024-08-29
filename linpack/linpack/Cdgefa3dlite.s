.LCPI0_0:
        .quad   0x3f10000000000000
matgen(double*, int, int, double*, double*):
        blez    a2, .LBB0_18
        addi    sp, sp, -80
        sd      ra, 72(sp)
        sd      s0, 64(sp)
        sd      s1, 56(sp)
        sd      s2, 48(sp)
        sd      s3, 40(sp)
        sd      s4, 32(sp)
        sd      s5, 24(sp)
        sd      s6, 16(sp)
        sd      s7, 8(sp)
        mv      s2, a3
        mv      s5, a2
        mv      s3, a1
        mv      s7, a0
        li      a0, 0
        slli    s6, a1, 3
        slli    s4, a2, 3
        li      s0, 1325
.Lpcrel_hi0:
        auipc   a2, %pcrel_hi(.LCPI0_0)
        fld     fa5, %pcrel_lo(.Lpcrel_hi0)(a2)
        lui     a2, 1
        addi    a2, a2, -971
        lui     a3, 1048568
        mv      s1, s7
.LBB0_2:
        mul     a4, s6, a0
        add     a4, a4, s4
        add     a5, s7, a4
        mv      a4, s1
.LBB0_3:
        mul     a1, s0, a2
        slli    a1, a1, 48
        srli    s0, a1, 48
        add     a1, s0, a3
        fcvt.d.w        fa4, a1
        fmul.d  fa4, fa4, fa5
        fsd     fa4, 0(a4)
        addi    a4, a4, 8
        bne     a4, a5, .LBB0_3
        addi    a0, a0, 1
        add     s1, s1, s6
        bne     a0, s5, .LBB0_2
        blez    s5, .LBB0_17
        mv      a0, s2
        li      a1, 0
        mv      a2, s4
        call    memset
        slli    a2, s5, 3
        add     a2, a2, s2
        addi    a0, s5, -1
        mul     a0, a0, s3
        add     a0, a0, s5
        slli    a5, a0, 3
        csrr    s1, vlenb
        srli    a0, s1, 2
        li      a1, 8
        add     a5, a5, s7
        mv      a3, a0
        bltu    a1, a0, .LBB0_8
        li      a3, 8
.LBB0_8:
        li      a1, 0
        sltu    a4, s2, a5
        sltu    a2, s7, a2
        and     a2, a2, a4
        slti    a4, s3, 0
        sltu    a3, s5, a3
        or      a3, a3, a4
        slli    a4, s1, 1
        add     s4, s4, s2
        or      a3, a3, a2
        srli    s1, s1, 3
        slli    a2, s1, 1
        slli    s1, s1, 31
        sub     s1, s1, a2
        and     s1, s1, s5
        j       .LBB0_10
.LBB0_9:
        addi    a1, a1, 1
        add     s7, s7, s6
        beq     a1, s5, .LBB0_17
.LBB0_10:
        beqz    a3, .LBB0_12
        li      a2, 0
        j       .LBB0_15
.LBB0_12:
        vsetvli a2, zero, e64, m2, ta, ma
        mv      a5, s1
        mv      s0, s7
        mv      a2, s2
.LBB0_13:
        vl2re64.v       v8, (a2)
        vl2re64.v       v10, (s0)
        vfadd.vv        v8, v8, v10
        vs2r.v  v8, (a2)
        add     a2, a2, a4
        sub     a5, a5, a0
        add     s0, s0, a4
        bnez    a5, .LBB0_13
        mv      a2, s1
        beq     s1, s5, .LBB0_9
.LBB0_15:
        slli    a5, a2, 3
        add     a2, s7, a5
        add     a5, a5, s2
.LBB0_16:
        fld     fa5, 0(a5)
        fld     fa4, 0(a2)
        fadd.d  fa5, fa5, fa4
        fsd     fa5, 0(a5)
        addi    a5, a5, 8
        addi    a2, a2, 8
        bne     a5, s4, .LBB0_16
        j       .LBB0_9
.LBB0_17:
        ld      ra, 72(sp)
        ld      s0, 64(sp)
        ld      s1, 56(sp)
        ld      s2, 48(sp)
        ld      s3, 40(sp)
        ld      s4, 32(sp)
        ld      s5, 24(sp)
        ld      s6, 16(sp)
        ld      s7, 8(sp)
        addi    sp, sp, 80
.LBB0_18:
        ret

daxpy(int, double, double*, int, double*, int):
        blez    a0, .LBB1_9
        csrr    a2, vlenb
        srli    a4, a2, 2
        li      a5, 16
        bltu    a5, a4, .LBB1_3
        li      a4, 16
.LBB1_3:
        slli    a6, a0, 3
        bltu    a0, a4, .LBB1_6
        add     a4, a1, a6
        bgeu    a3, a4, .LBB1_10
        add     a4, a3, a6
        bgeu    a1, a4, .LBB1_10
.LBB1_6:
        li      a7, 0
.LBB1_7:
        slli    a7, a7, 3
        add     a0, a1, a7
        add     a3, a3, a7
        add     a1, a1, a6
.LBB1_8:
        fld     fa5, 0(a3)
        fld     fa4, 0(a0)
        fmadd.d fa5, fa0, fa4, fa5
        fsd     fa5, 0(a3)
        addi    a0, a0, 8
        addi    a3, a3, 8
        bne     a0, a1, .LBB1_8
.LBB1_9:
        ret
.LBB1_10:
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
.LBB1_11:
        vl2re64.v       v10, (a5)
        vl2re64.v       v12, (a2)
        vfmadd.vv       v12, v8, v10
        vs2r.v  v12, (a5)
        add     a5, a5, t1
        sub     a4, a4, t0
        add     a2, a2, t1
        bnez    a4, .LBB1_11
        beq     a7, a0, .LBB1_9
        j       .LBB1_7

dscal(int, double, double*, int):
        blez    a0, .LBB2_8
        csrr    a3, vlenb
        srli    a2, a3, 2
        bgeu    a0, a2, .LBB2_3
        li      a6, 0
        j       .LBB2_6
.LBB2_3:
        srli    a4, a3, 3
        slli    a5, a4, 1
        slli    a4, a4, 31
        sub     a4, a4, a5
        and     a6, a4, a0
        slli    a3, a3, 1
        vsetvli a4, zero, e64, m2, ta, ma
        mv      a5, a6
        mv      a4, a1
.LBB2_4:
        vl2re64.v       v8, (a4)
        vfmul.vf        v8, v8, fa0
        vs2r.v  v8, (a4)
        sub     a5, a5, a2
        add     a4, a4, a3
        bnez    a5, .LBB2_4
        beq     a6, a0, .LBB2_8
.LBB2_6:
        slli    a2, a6, 3
        add     a2, a2, a1
        slli    a0, a0, 3
        add     a1, a1, a0
.LBB2_7:
        fld     fa5, 0(a2)
        fmul.d  fa5, fa5, fa0
        fsd     fa5, 0(a2)
        addi    a2, a2, 8
        bne     a2, a1, .LBB2_7
.LBB2_8:
        ret

idamax(int, double*, int):
        blez    a0, .LBB3_3
        li      a2, 1
        bne     a0, a2, .LBB3_5
        li      a0, 0
        ret
.LBB3_3:
        li      a0, -1
.LBB3_4:
        ret
.LBB3_5:
        fld     fa5, 0(a1)
        li      a4, 0
        fabs.d  fa5, fa5
        slli    a0, a0, 32
        srli    a0, a0, 29
        add     a3, a1, a0
        addi    a1, a1, 8
        j       .LBB3_7
.LBB3_6:
        addi    a1, a1, 8
        addiw   a2, a2, 1
        mv      a4, a0
        fmv.d   fa5, fa4
        beq     a1, a3, .LBB3_4
.LBB3_7:
        fld     fa4, 0(a1)
        fabs.d  fa4, fa4
        flt.d   a5, fa5, fa4
        mv      a0, a2
        bnez    a5, .LBB3_6
        fmv.d   fa4, fa5
        mv      a0, a4
        j       .LBB3_6

.LCPI4_0:
        .quad   0xbff0000000000000
dgefa(double*, int, int, int*, int*):
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
        sd      a3, 48(sp)
        sd      a4, 8(sp)
        sw      zero, 0(a4)
        li      a3, 2
        addiw   s1, a2, -1
        blt     a2, a3, .LBB4_38
        li      a7, 0
        li      s8, 0
        li      t0, 0
        slli    s2, a1, 3
        addi    t2, s2, 8
        slli    a3, a2, 3
        addi    a4, a3, -8
        mul     a4, a4, a1
        add     a3, a3, a0
        sd      a3, 32(sp)
        add     a3, a3, a4
        sd      a3, 24(sp)
        addi    s5, a0, 8
        addi    t5, a2, -1
        csrr    s9, vlenb
        slli    t6, s9, 1
        srli    a5, s9, 2
        sd      t2, 56(sp)
        add     t2, t2, a0
        fmv.d.x fa5, zero
        sd      s5, 16(sp)
        li      t4, 1
        sd      s1, 40(sp)
        j       .LBB4_4
.LBB4_2:
        ld      a3, 8(sp)
        sw      s8, 0(a3)
.LBB4_3:
        addi    t0, t0, 1
        addi    t4, t4, 1
        addi    t5, t5, -1
        addi    s5, s5, 8
        addw    a7, a7, a1
        ld      a3, 56(sp)
        add     t2, t2, a3
        ld      a3, 64(sp)
        mv      s8, a3
        ld      s1, 40(sp)
        beq     a3, s1, .LBB4_38
.LBB4_4:
        slli    ra, a7, 3
        add     s7, s5, ra
        slli    s4, s8, 3
        sub     a3, a2, s8
        mulw    a4, t0, a1
        add     t3, a0, s4
        slli    a4, a4, 3
        add     t3, t3, a4
        blez    a3, .LBB4_7
        li      a4, 1
        bne     a3, a4, .LBB4_11
        li      a6, 0
        j       .LBB4_8
.LBB4_7:
        li      a6, -1
.LBB4_8:
        mul     a3, s8, a1
        addw    a4, a6, s8
        slli    a3, a3, 3
        add     a3, a3, a0
        slli    t1, a4, 3
        add     a3, a3, t1
        fld     fa4, 0(a3)
        slli    s0, s8, 2
        ld      s1, 48(sp)
        add     s0, s0, s1
        sw      a4, 0(s0)
        feq.d   a4, fa4, fa5
        addi    s3, s8, 1
        sd      s3, 64(sp)
        bnez    a4, .LBB4_2
        fld     fa3, 0(t3)
        beqz    a6, .LBB4_15
        fsd     fa3, 0(a3)
        fsd     fa4, 0(t3)
        j       .LBB4_16
.LBB4_11:
        fld     fa4, 0(t3)
        li      a4, 0
        ld      s3, 32(sp)
        add     s3, s3, ra
        fabs.d  fa4, fa4
        li      s0, 1
        mv      a3, s7
        j       .LBB4_13
.LBB4_12:
        addi    a3, a3, 8
        addiw   s0, s0, 1
        mv      a4, a6
        fmv.d   fa4, fa3
        beq     a3, s3, .LBB4_8
.LBB4_13:
        fld     fa3, 0(a3)
        fabs.d  fa3, fa3
        flt.d   s1, fa4, fa3
        mv      a6, s0
        bnez    s1, .LBB4_12
        fmv.d   fa3, fa4
        mv      a6, a4
        j       .LBB4_12
.LBB4_15:
        fmv.d   fa4, fa3
.LBB4_16:
        not     s11, s8
        sub     s10, a2, s3
        add     s11, s11, a2
        blez    s10, .LBB4_24
.Lpcrel_hi1:
        auipc   a3, %pcrel_hi(.LCPI4_0)
        fld     fa3, %pcrel_lo(.Lpcrel_hi1)(a3)
        fdiv.d  fa4, fa3, fa4
        bgeu    s11, a5, .LBB4_19
        li      a4, 0
        j       .LBB4_22
.LBB4_19:
        neg     a3, a5
        and     a4, s11, a3
        vsetvli a3, zero, e64, m2, ta, ma
        mv      a3, a4
        mv      s1, s7
.LBB4_20:
        vl2re64.v       v8, (s1)
        vfmul.vf        v8, v8, fa4
        vs2r.v  v8, (s1)
        sub     a3, a3, a5
        add     s1, s1, t6
        bnez    a3, .LBB4_20
        beq     s11, a4, .LBB4_24
.LBB4_22:
        sub     s0, t5, a4
        slli    a4, a4, 3
        add     a3, a4, ra
        add     a3, a3, s5
.LBB4_23:
        fld     fa3, 0(a3)
        fmul.d  fa3, fa4, fa3
        fsd     fa3, 0(a3)
        addi    s0, s0, -1
        addi    a3, a3, 8
        bnez    s0, .LBB4_23
.LBB4_24:
        ld      a3, 56(sp)
        mul     a3, a3, s3
        add     a3, a3, a0
        ld      a4, 16(sp)
        add     s4, s4, a4
        mulw    a4, s8, a1
        slli    s1, a4, 3
        add     t3, s4, s1
        ld      a4, 32(sp)
        add     a4, a4, s1
        slti    s0, a1, 0
        add     s4, a0, t1
        sltu    a3, a3, a4
        ld      a4, 24(sp)
        sltu    a4, t3, a4
        and     a3, a3, a4
        or      t3, a3, s0
        add     ra, ra, s5
        mv      t1, t2
        mv      s6, t4
        j       .LBB4_26
.LBB4_25:
        addi    s6, s6, 1
        add     t1, t1, s2
        beq     s6, a2, .LBB4_3
.LBB4_26:
        mul     a4, s6, a1
        slli    a3, a4, 3
        add     a3, a3, s4
        fld     fa4, 0(a3)
        beqz    a6, .LBB4_28
        add     a4, a4, s8
        slli    a4, a4, 3
        add     a4, a4, a0
        fld     fa3, 0(a4)
        fsd     fa3, 0(a3)
        fsd     fa4, 0(a4)
.LBB4_28:
        blez    s10, .LBB4_25
        li      a4, 8
        mv      a3, a5
        bltu    a4, a5, .LBB4_31
        li      a3, 8
.LBB4_31:
        sltu    a3, s11, a3
        or      a3, a3, t3
        beqz    a3, .LBB4_33
        li      a3, 0
        j       .LBB4_36
.LBB4_33:
        srli    a3, s9, 2
        neg     a3, a3
        and     a3, s11, a3
        vsetvli a4, zero, e64, m2, ta, ma
        vfmv.v.f        v8, fa4
        mv      a4, a3
        mv      s0, s7
        mv      s3, t1
.LBB4_34:
        vl2re64.v       v10, (s3)
        vl2re64.v       v12, (s0)
        vfmadd.vv       v12, v8, v10
        vs2r.v  v12, (s3)
        add     s3, s3, t6
        sub     a4, a4, a5
        add     s0, s0, t6
        bnez    a4, .LBB4_34
        beq     s11, a3, .LBB4_25
.LBB4_36:
        sub     a4, t5, a3
        slli    s0, a3, 3
        add     a3, ra, s0
        add     s0, s0, t1
.LBB4_37:
        fld     fa3, 0(s0)
        fld     fa2, 0(a3)
        fmadd.d fa3, fa4, fa2, fa3
        fsd     fa3, 0(s0)
        addi    a4, a4, -1
        addi    a3, a3, 8
        addi    s0, s0, 8
        bnez    a4, .LBB4_37
        j       .LBB4_25
.LBB4_38:
        addi    a1, a1, 1
        mulw    a1, s1, a1
        slli    a1, a1, 3
        add     a0, a0, a1
        fld     fa5, 0(a0)
        slli    a0, s1, 2
        ld      a1, 48(sp)
        add     a0, a0, a1
        fmv.d.x fa4, zero
        feq.d   a1, fa5, fa4
        sw      s1, 0(a0)
        beqz    a1, .LBB4_40
        ld      a0, 8(sp)
        sw      s1, 0(a0)
.LBB4_40:
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

ddot(int, double*, int, double*, int):
        blez    a0, .LBB5_3
        csrr    t0, vlenb
        srli    a7, t0, 2
        bgeu    a0, a7, .LBB5_4
        li      a6, 0
        fmv.d.x fa0, zero
        j       .LBB5_7
.LBB5_3:
        fmv.d.x fa0, zero
        ret
.LBB5_4:
        srli    a2, t0, 3
        slli    a4, a2, 1
        slli    a2, a2, 31
        sub     a2, a2, a4
        and     a6, a2, a0
        vsetvli a2, zero, e64, m1, ta, ma
        vmv.s.x v8, zero
        slli    t0, t0, 1
        mv      t1, a6
        mv      a5, a3
        mv      a4, a1
.LBB5_5:
        vl2re64.v       v10, (a4)
        vl2re64.v       v12, (a5)
        vsetvli a2, zero, e64, m2, ta, ma
        vfmul.vv        v10, v10, v12
        vfredosum.vs    v8, v10, v8
        add     a4, a4, t0
        sub     t1, t1, a7
        add     a5, a5, t0
        bnez    t1, .LBB5_5
        vfmv.f.s        fa0, v8
        beq     a6, a0, .LBB5_9
.LBB5_7:
        slli    a6, a6, 3
        add     a2, a3, a6
        add     a1, a1, a6
        slli    a0, a0, 3
        add     a3, a3, a0
.LBB5_8:
        fld     fa5, 0(a1)
        fld     fa4, 0(a2)
        fmadd.d fa0, fa5, fa4, fa0
        addi    a2, a2, 8
        addi    a1, a1, 8
        bne     a2, a3, .LBB5_8
.LBB5_9:
        ret

dgesl(double*, int, int, int*, double*, int):
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
        beqz    a5, .LBB6_25
        blez    a2, .LBB6_57
        li      t5, 0
        li      t1, 0
        slli    t0, a1, 3
        csrr    a5, vlenb
        slli    t6, a5, 1
        srli    a7, a5, 2
        fmv.d.x fa5, zero
        vsetvli a5, zero, e64, m1, ta, ma
        vmv.s.x v8, zero
        mv      t2, a0
        j       .LBB6_4
.LBB6_3:
        mulw    a5, t1, a1
        fld     fa3, 0(s2)
        add     t3, t3, a0
        slli    a5, a5, 3
        add     a5, a5, t3
        fld     fa2, 0(a5)
        fsub.d  fa4, fa3, fa4
        fdiv.d  fa4, fa4, fa2
        fsd     fa4, 0(s2)
        addi    t5, t5, 1
        addi    t1, t1, 1
        add     t2, t2, t0
        beq     t5, a2, .LBB6_12
.LBB6_4:
        slli    t3, t5, 3
        add     s2, a4, t3
        fmv.d   fa4, fa5
        beqz    t5, .LBB6_3
        bgeu    t5, a7, .LBB6_7
        li      t4, 0
        fmv.d   fa4, fa5
        j       .LBB6_10
.LBB6_7:
        neg     a5, a7
        and     t4, t5, a5
        vsetvli a5, zero, e64, m2, ta, ma
        mv      a5, t4
        mv      s1, a4
        mv      s0, t2
        vmv2r.v v10, v8
.LBB6_8:
        vl2re64.v       v12, (s0)
        vl2re64.v       v14, (s1)
        vfmul.vv        v12, v12, v14
        vfredosum.vs    v10, v12, v10
        add     s0, s0, t6
        sub     a5, a5, a7
        add     s1, s1, t6
        bnez    a5, .LBB6_8
        vfmv.f.s        fa4, v10
        beq     t5, t4, .LBB6_3
.LBB6_10:
        slli    t4, t4, 3
        add     a5, a4, t4
        add     s1, t2, t4
.LBB6_11:
        fld     fa3, 0(s1)
        fld     fa2, 0(a5)
        fmadd.d fa4, fa3, fa2, fa4
        addi    a5, a5, 8
        addi    s1, s1, 8
        bne     a5, s2, .LBB6_11
        j       .LBB6_3
.LBB6_12:
        li      a5, 1
        beq     a2, a5, .LBB6_57
        addiw   a5, a2, -2
        beqz    a5, .LBB6_57
        addi    s1, a1, 1
        addi    t1, a0, 8
        mulw    t5, a5, s1
        not     t0, a1
        slli    s0, a2, 3
        add     s0, s0, a4
        addi    a1, s0, -8
        li      t4, 1
        fmv.d.x fa5, zero
        j       .LBB6_16
.LBB6_15:
        addw    t5, t5, t0
        addi    a1, a1, -8
        beq     t4, a6, .LBB6_57
.LBB6_16:
        slli    t2, t5, 3
        bgeu    t4, a7, .LBB6_18
        li      t3, 0
        fmv.d   fa4, fa5
        j       .LBB6_21
.LBB6_18:
        add     a5, t1, t2
        neg     a0, a7
        and     t3, t4, a0
        vsetvli a0, zero, e64, m2, ta, ma
        mv      a0, t3
        mv      s1, a1
        vmv2r.v v10, v8
.LBB6_19:
        vl2re64.v       v12, (a5)
        vl2re64.v       v14, (s1)
        vfmul.vv        v12, v12, v14
        vfredosum.vs    v10, v12, v10
        add     a5, a5, t6
        sub     a0, a0, a7
        add     s1, s1, t6
        bnez    a0, .LBB6_19
        vfmv.f.s        fa4, v10
        beq     t4, t3, .LBB6_23
.LBB6_21:
        slli    t3, t3, 3
        add     a0, a1, t3
        add     t3, t3, t1
        add     t2, t2, t3
.LBB6_22:
        fld     fa3, 0(t2)
        fld     fa2, 0(a0)
        fmadd.d fa4, fa3, fa2, fa4
        addi    a0, a0, 8
        addi    t2, t2, 8
        bne     a0, s0, .LBB6_22
.LBB6_23:
        addi    t4, t4, 1
        sub     s1, a2, t4
        slli    a0, s1, 3
        add     a0, a0, a4
        fld     fa3, 0(a0)
        slli    a5, s1, 2
        add     a5, a5, a3
        lw      a5, 0(a5)
        sext.w  s1, s1
        fadd.d  fa4, fa3, fa4
        fsd     fa4, 0(a0)
        beq     a5, s1, .LBB6_15
        slli    a5, a5, 3
        add     a5, a5, a4
        fld     fa3, 0(a5)
        fsd     fa4, 0(a5)
        fsd     fa3, 0(a0)
        j       .LBB6_15
.LBB6_25:
        li      a5, 2
        blt     a2, a5, .LBB6_42
        li      t4, 0
        li      s4, 0
        addi    a7, a1, 1
        slli    t0, a2, 3
        add     t0, t0, a4
        addi    t1, a0, 8
        addi    t2, a4, 8
        csrr    t3, vlenb
        slli    s7, t3, 1
        srli    t5, t3, 2
        addi    t6, a2, -1
        mv      s6, t2
        j       .LBB6_28
.LBB6_27:
        addi    s6, s6, 8
        addw    t4, t4, a7
        addi    t6, t6, -1
        beq     s4, a6, .LBB6_42
.LBB6_28:
        mv      s1, s4
        slli    a5, s4, 2
        add     a5, a5, a3
        lwu     s0, 0(a5)
        sext.w  a5, s0
        slli    a5, a5, 3
        add     a5, a5, a4
        fld     fa5, 0(a5)
        slli    s5, s4, 3
        beq     s4, s0, .LBB6_30
        add     s0, a4, s5
        fld     fa4, 0(s0)
        fsd     fa4, 0(a5)
        fsd     fa5, 0(s0)
.LBB6_30:
        addi    s4, s1, 1
        sub     a5, a2, s4
        blez    a5, .LBB6_27
        li      s0, 8
        mv      a5, t5
        bltu    s0, t5, .LBB6_33
        li      a5, 8
.LBB6_33:
        not     s3, s1
        add     s3, s3, a2
        slli    s2, t4, 3
        bltu    s3, a5, .LBB6_36
        add     s5, s5, t2
        mulw    a5, a7, s1
        slli    a5, a5, 3
        sub     s0, a2, s1
        slli    s0, s0, 3
        add     s0, s0, a0
        add     s0, s0, a5
        bgeu    s5, s0, .LBB6_39
        add     a5, a5, t1
        bgeu    a5, t0, .LBB6_39
.LBB6_36:
        li      s5, 0
.LBB6_37:
        sub     a5, t6, s5
        slli    s0, s5, 3
        add     s1, s0, s2
        add     s1, s1, t1
        add     s0, s0, s6
.LBB6_38:
        fld     fa4, 0(s0)
        fld     fa3, 0(s1)
        fmadd.d fa4, fa5, fa3, fa4
        fsd     fa4, 0(s0)
        addi    a5, a5, -1
        addi    s1, s1, 8
        addi    s0, s0, 8
        bnez    a5, .LBB6_38
        j       .LBB6_27
.LBB6_39:
        add     a5, t1, s2
        srli    s0, t3, 2
        neg     s0, s0
        and     s5, s3, s0
        vsetvli s0, zero, e64, m2, ta, ma
        vfmv.v.f        v8, fa5
        mv      s1, s5
        mv      s0, s6
.LBB6_40:
        vl2re64.v       v10, (s0)
        vl2re64.v       v12, (a5)
        vfmadd.vv       v12, v8, v10
        vs2r.v  v12, (s0)
        add     s0, s0, s7
        sub     s1, s1, t5
        add     a5, a5, s7
        bnez    s1, .LBB6_40
        beq     s3, s5, .LBB6_27
        j       .LBB6_37
.LBB6_42:
        blez    a2, .LBB6_57
        li      t5, 0
        li      a6, 0
        addi    t6, a2, -1
        slli    a7, a2, 3
        addi    a7, a7, -8
        slli    a3, a1, 3
        neg     t0, a3
        not     t2, a1
        slli    t2, t2, 3
        mul     a3, t6, a1
        slli    a3, a3, 3
        add     t1, a0, a3
        add     t4, a7, t1
        csrr    t3, vlenb
        slli    s6, t3, 1
        srli    s4, t3, 2
        mv      s5, t1
        j       .LBB6_45
.LBB6_44:
        add     s5, s5, t0
        addi    t6, t6, -1
        beq     t5, a2, .LBB6_57
.LBB6_45:
        mv      s3, t5
        addi    t5, t5, 1
        addi    a6, a6, 1
        sub     s1, a2, t5
        subw    a5, a2, a6
        slli    a3, s1, 3
        add     s0, a4, a3
        fld     fa5, 0(s0)
        mulw    a5, a5, a1
        add     a3, a3, a0
        slli    a5, a5, 3
        add     a3, a3, a5
        fld     fa4, 0(a3)
        fdiv.d  fa5, fa5, fa4
        fsd     fa5, 0(s0)
        blez    s1, .LBB6_44
        li      a5, 8
        mv      a3, s4
        bltu    a5, s4, .LBB6_48
        li      a3, 8
.LBB6_48:
        not     s2, s3
        add     s2, s2, a2
        fneg.d  fa5, fa5
        bltu    s2, a3, .LBB6_51
        mul     a3, t2, s3
        add     a3, a3, t4
        bgeu    a4, a3, .LBB6_54
        slli    a3, s3, 3
        sub     a3, a7, a3
        add     a3, a3, a4
        mul     a5, t0, s3
        add     a5, a5, t1
        bgeu    a5, a3, .LBB6_54
.LBB6_51:
        li      s3, 0
.LBB6_52:
        sub     s1, t6, s3
        slli    a3, s3, 3
        add     a5, s5, a3
        add     a3, a3, a4
.LBB6_53:
        fld     fa4, 0(a3)
        fld     fa3, 0(a5)
        fmadd.d fa4, fa5, fa3, fa4
        fsd     fa4, 0(a3)
        addi    s1, s1, -1
        addi    a5, a5, 8
        addi    a3, a3, 8
        bnez    s1, .LBB6_53
        j       .LBB6_44
.LBB6_54:
        srli    a3, t3, 2
        neg     a3, a3
        and     s3, s2, a3
        vsetvli a3, zero, e64, m2, ta, ma
        vfmv.v.f        v8, fa5
        mv      s1, s3
        mv      a5, s5
        mv      a3, a4
.LBB6_55:
        vl2re64.v       v10, (a3)
        vl2re64.v       v12, (a5)
        vfmadd.vv       v12, v8, v10
        vs2r.v  v12, (a3)
        add     a3, a3, s6
        sub     s1, s1, s4
        add     a5, a5, s6
        bnez    s1, .LBB6_55
        beq     s2, s3, .LBB6_44
        j       .LBB6_52
.LBB6_57:
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
