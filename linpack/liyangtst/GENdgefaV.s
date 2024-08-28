#REAL *a,int lda,int n,REAL b[]
.section .text                       
.global dgefaV
dgefaV:
        .quad   0xbff0000000000000
dgefa:
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
        sd      s8, 416(sp)
        sd      s9, 408(sp)
        sd      s10, 400(sp)
        sd      s11, 392(sp)
        lui     a4, 3
        addiw   a4, a4, -160
        sub     sp, sp, a4
        li      a4, 2
        sd      a3, 80(sp)
        sd      a1, 200(sp)
        blt     a2, a4, .LBB0_75
        mv      t6, a2
        li      t0, 0
        li      t4, 0
        li      s0, 0
        li      s5, 0
        addiw   a3, a2, -1
        ld      a2, 200(sp)
        slliw   a5, a2, 6
        addiw   s1, a5, 64
        slli    a1, a2, 32
        srli    a1, a1, 32
        sd      a1, 160(sp)
        addi    a1, t6, -1
        sd      a1, 56(sp)
        slli    a1, s1, 32
        srli    a1, a1, 32
        sd      a1, 48(sp)
        slli    a1, a5, 32
        srli    a1, a1, 32
        sd      a1, 176(sp)
        addi    s2, a0, 512
        csrr    s3, vlenb
        srli    s6, s3, 3
        slli    t1, s3, 1
        li      a1, 126
        mul     a1, s6, a1
        sd      a1, 216(sp)
        andi    a1, a1, 64
        sd      a1, 208(sp)
        srli    a4, s3, 2
        li      a1, 124
        mul     a1, s6, a1
        sd      a1, 24(sp)
        andi    a1, a1, 64
        sd      a1, 16(sp)
        srli    s4, s3, 1
        ld      a1, 80(sp)
        addi    a1, a1, 256
        sd      a1, 32(sp)
        li      ra, 1
        li      a1, 32
        vsetvli zero, a1, e64, m8, ta, ma
        vmv.v.i v8, 0
        addi    s8, sp, 224
        addi    s9, sp, 2047
        addi    s9, s9, 233
        fmv.d.x fa5, zero
        vsetvli a1, zero, e32, m1, ta, ma
        vid.v   v16
        sd      s1, 64(sp)
        sd      s1, 152(sp)
        sd      a5, 184(sp)
        sd      a5, 144(sp)
        sd      a2, 136(sp)
        li      a1, 64
        sd      a1, 168(sp)
        sd      a3, 72(sp)
        sd      a3, 128(sp)
        sd      t6, 120(sp)
        sd      s4, 40(sp)
        j       .LBB0_3
.LBB0_2:
        ld      a1, 120(sp)
        addi    a1, a1, -1
        sd      a1, 120(sp)
        ld      a1, 128(sp)
        addi    a1, a1, -1
        sd      a1, 128(sp)
        ld      ra, 88(sp)
        addi    ra, ra, 1
        ld      s0, 96(sp)
        ld      a2, 64(sp)
        addw    s0, s0, a2
        ld      a1, 168(sp)
        addw    a1, a1, a2
        sd      a1, 168(sp)
        ld      t4, 104(sp)
        addi    t4, t4, 1
        ld      a1, 200(sp)
        ld      t0, 112(sp)
        add     t0, t0, a1
        ld      a3, 136(sp)
        add     a3, a3, a1
        sd      a3, 136(sp)
        ld      a1, 144(sp)
        addw    a1, a1, a2
        sd      a1, 144(sp)
        ld      a1, 152(sp)
        addw    a1, a1, a2
        sd      a1, 152(sp)
        ld      a1, 72(sp)
        ld      s4, 40(sp)
        addi    s8, sp, 224
        addi    s9, sp, 2047
        addi    s9, s9, 233
        beq     s5, a1, .LBB0_75
.LBB0_3:
        slli    a7, s0, 3
        add     s11, s2, a7
        add     t2, a0, a7
        li      a1, 32
        vsetvli zero, a1, e64, m8, ta, ma
        vse64.v v8, (s8)
        li      s7, 32
        bgeu    a1, s6, .LBB0_5
        li      a1, 0
        j       .LBB0_8
.LBB0_5:
        ld      a1, 216(sp)
        andi    a1, a1, 64
        addi    a2, sp, 2047
        addi    a2, a2, 233
        ld      a3, 208(sp)
        mv      a5, t2
.LBB0_6:
        vl2re64.v       v18, (a5)
        vsetvli s1, zero, e64, m2, ta, ma
        vmfgt.vf        v0, v18, fa5
        vfneg.v v20, v18
        vmerge.vvm      v18, v20, v18, v0
        vs2r.v  v18, (a2)
        add     a5, a5, t1
        sub     a3, a3, a4
        add     a2, a2, t1
        bnez    a3, .LBB0_6
        bnez    a1, .LBB0_12
.LBB0_8:
        slli    a2, a1, 3
        add     a1, a0, a2
        add     a1, a1, a7
        add     a2, a2, s9
        j       .LBB0_10
.LBB0_9:
        fsd     fa4, 0(a2)
        addi    a1, a1, 8
        addi    a2, a2, 8
        beq     a1, s11, .LBB0_12
.LBB0_10:
        fld     fa4, 0(a1)
        flt.d   a3, fa5, fa4
        bnez    a3, .LBB0_9
        fneg.d  fa4, fa4
        j       .LBB0_9
.LBB0_12:
        sd      s0, 96(sp)
        ld      a1, 56(sp)
        bge     s5, a1, .LBB0_26
        ld      a1, 120(sp)
        slli    a1, a1, 32
        srli    t5, a1, 32
        li      a3, 1
        ld      a1, 168(sp)
        j       .LBB0_15
.LBB0_14:
        addi    a3, a3, 1
        addiw   a1, a1, 64
        beq     a3, t5, .LBB0_26
.LBB0_15:
        slli    a6, a1, 3
        bgeu    s7, s6, .LBB0_17
        li      t3, 0
        j       .LBB0_20
.LBB0_17:
        add     s1, a0, a6
        ld      a2, 216(sp)
        andi    t3, a2, 64
        vsetvli a2, zero, e32, m1, ta, ma
        vmv.v.x v17, a3
        addi    s0, sp, 2047
        addi    s0, s0, 233
        addi    a2, sp, 224
        ld      a5, 208(sp)
.LBB0_18:
        vl2re64.v       v18, (s1)
        vsetvli zero, zero, e64, m2, ta, ma
        vl2re64.v       v20, (s0)
        vmfgt.vf        v0, v18, fa5
        vfneg.v v22, v18
        vmerge.vvm      v18, v22, v18, v0
        vmflt.vv        v0, v20, v18
        vse32.v v17, (a2), v0.t
        vse64.v v18, (s0), v0.t
        add     s1, s1, t1
        add     s0, s0, t1
        sub     a5, a5, a4
        add     a2, a2, s3
        bnez    a5, .LBB0_18
        bnez    t3, .LBB0_14
.LBB0_20:
        add     s0, s2, a6
        slli    a5, t3, 3
        add     a2, a0, a5
        add     a6, a6, a2
        slli    a2, t3, 2
        add     a2, a2, s8
        add     a5, a5, s9
        j       .LBB0_22
.LBB0_21:
        addi    a6, a6, 8
        addi    a2, a2, 4
        addi    a5, a5, 8
        beq     a6, s0, .LBB0_14
.LBB0_22:
        fld     fa4, 0(a6)
        flt.d   s1, fa5, fa4
        bnez    s1, .LBB0_24
        fneg.d  fa4, fa4
.LBB0_24:
        fld     fa3, 0(a5)
        flt.d   s1, fa3, fa4
        beqz    s1, .LBB0_21
        sw      a3, 0(a2)
        fsd     fa4, 0(a5)
        j       .LBB0_21
.LBB0_26:
        slli    a1, t4, 38
        srli    a1, a1, 30
        li      a2, 16
        bgeu    a2, s6, .LBB0_28
        li      a3, 0
        li      s0, 32
        j       .LBB0_31
.LBB0_28:
        ld      a2, 80(sp)
        add     a2, a2, a1
        ld      a3, 24(sp)
        andi    a3, a3, 64
        addi    a5, sp, 224
        lui     a6, 2
        addiw   a6, a6, -1816
        add     s1, sp, a6
        vsetvli s0, zero, e32, m2, ta, ma
        ld      s0, 16(sp)
.LBB0_29:
        vl2re32.v       v18, (a5)
        vadd.vx v18, v18, s5
        vs2r.v  v18, (s1)
        vs2r.v  v18, (a2)
        add     a5, a5, t1
        add     s1, s1, t1
        sub     s0, s0, s4
        add     a2, a2, t1
        bnez    s0, .LBB0_29
        li      s0, 32
        bnez    a3, .LBB0_33
.LBB0_31:
        ld      a2, 32(sp)
        add     a2, a2, a1
        slli    a5, a3, 2
        add     a1, a1, a5
        ld      a3, 80(sp)
        add     a1, a1, a3
        lui     a3, 2
        addiw   a3, a3, -1816
        add     a3, a3, sp
        add     a3, a3, a5
        add     a5, a5, s8
.LBB0_32:
        lw      s1, 0(a5)
        add     s1, s1, s5
        sw      s1, 0(a3)
        sw      s1, 0(a1)
        addi    a1, a1, 4
        addi    a3, a3, 4
        addi    a5, a5, 4
        bne     a1, a2, .LBB0_32
.LBB0_33:
        ld      a2, 48(sp)
        mul     a1, s5, a2
        add     a2, a2, a1
        sd      a2, 192(sp)
        addi    s7, a1, 64
        addi    s5, s5, 1
        lui     a1, 2
        addiw   a1, a1, 232
        add     a1, a1, sp
        lui     a2, 2
        addiw   a2, a2, -1816
        add     a2, a2, sp
        mv      a3, a0
.LBB0_34:
        lw      a5, 0(a2)
        add     a5, a5, t0
        slliw   a5, a5, 6
        slli    a5, a5, 3
        add     a5, a5, a3
        fld     fa4, 0(a5)
        add     s1, a3, a7
        fld     fa3, 0(s1)
        fsd     fa4, 0(a1)
        fsd     fa3, 0(a5)
        fsd     fa4, 0(s1)
        addi    a3, a3, 8
        addi    a1, a1, 8
        addi    a2, a2, 4
        bne     a3, s2, .LBB0_34
.Lpcrel_hi0:
        auipc   a1, %pcrel_hi(.LCPI0_0)
        bgeu    s0, s6, .LBB0_37
        li      a2, 0
        lui     a3, 2
        addiw   a3, a3, 232
        add     s1, sp, a3
        j       .LBB0_40
.LBB0_37:
        ld      a2, 216(sp)
        andi    a2, a2, 64
        lui     a3, 2
        addiw   a3, a3, 232
        add     a3, a3, sp
        vsetvli a5, zero, e64, m2, ta, ma
        ld      a5, 208(sp)
        lui     a6, 2
        addiw   a6, a6, 232
        add     s1, sp, a6
.LBB0_38:
        vl2re64.v       v18, (t2)
        fld     fa4, %pcrel_lo(.Lpcrel_hi0)(a1)
        vfrdiv.vf       v18, v18, fa4
        vs2r.v  v18, (a3)
        add     t2, t2, t1
        sub     a5, a5, a4
        add     a3, a3, t1
        bnez    a5, .LBB0_38
        bnez    a2, .LBB0_42
.LBB0_40:
        slli    a3, a2, 3
        add     a2, a3, a7
        add     a2, a2, a0
        add     a3, a3, s1
.LBB0_41:
        fld     fa4, 0(a2)
        fld     fa3, %pcrel_lo(.Lpcrel_hi0)(a1)
        fdiv.d  fa4, fa3, fa4
        fsd     fa4, 0(a3)
        addi    a2, a2, 8
        addi    a3, a3, 8
        bne     a2, s11, .LBB0_41
.LBB0_42:
        lui     a1, 2
        addiw   a1, a1, 232
        add     t3, sp, a1
        sd      t4, 104(sp)
        sd      t0, 112(sp)
        ld      a7, 128(sp)
        slli    a7, a7, 32
        bgeu    s5, t6, .LBB0_52
        li      a1, 0
        srli    t2, a7, 32
        ld      a3, 168(sp)
        j       .LBB0_45
.LBB0_44:
        addi    a1, a1, 1
        addiw   a3, a3, 64
        beq     a1, t2, .LBB0_52
.LBB0_45:
        slli    s1, a3, 3
        bgeu    s0, s6, .LBB0_47
        li      a6, 0
        j       .LBB0_50
.LBB0_47:
        add     a5, a0, s1
        ld      a2, 216(sp)
        andi    a6, a2, 64
        lui     a2, 2
        addiw   a2, a2, 232
        add     s0, sp, a2
        vsetvli a2, zero, e64, m2, ta, ma
        ld      a2, 208(sp)
.LBB0_48:
        vl2re64.v       v18, (s0)
        vl2re64.v       v20, (a5)
        vfmul.vv        v18, v18, v20
        vs2r.v  v18, (a5)
        add     s0, s0, t1
        sub     a2, a2, a4
        add     a5, a5, t1
        bnez    a2, .LBB0_48
        li      s0, 32
        bnez    a6, .LBB0_44
.LBB0_50:
        add     a5, s2, s1
        slli    a6, a6, 3
        add     a2, a0, a6
        add     s1, s1, a2
        add     a2, t3, a6
.LBB0_51:
        fld     fa4, 0(a2)
        fld     fa3, 0(s1)
        fmul.d  fa4, fa4, fa3
        fsd     fa4, 0(s1)
        addi    s1, s1, 8
        addi    a2, a2, 8
        bne     s1, a5, .LBB0_51
        j       .LBB0_44
.LBB0_52:
        li      t2, 0
        srli    s4, a7, 32
        ld      s9, 152(sp)
        ld      t5, 144(sp)
        ld      t4, 136(sp)
        sd      ra, 88(sp)
        j       .LBB0_54
.LBB0_53:
        addi    ra, ra, 1
        addi    t2, t2, 1
        ld      a1, 200(sp)
        add     t4, t4, a1
        ld      a1, 184(sp)
        addw    t5, t5, a1
        addw    s9, s9, a1
        mv      t6, t0
        mv      s5, s8
        beq     ra, t0, .LBB0_2
.LBB0_54:
        lui     a1, 2
        addiw   a1, a1, 232
        add     a3, sp, a1
        bgeu    s0, s6, .LBB0_56
        li      a6, 0
        j       .LBB0_59
.LBB0_56:
        ld      a1, 160(sp)
        mul     a2, ra, a1
        ld      a1, 216(sp)
        andi    a6, a1, 64
        lui     a1, 2
        addiw   a1, a1, -1816
        add     s1, sp, a1
        lui     a1, 2
        addiw   a1, a1, 232
        add     s0, sp, a1
        vsetvli a5, zero, e32, m1, ta, ma
        ld      a5, 208(sp)
        vmv1r.v v17, v16
.LBB0_57:
        vl1re32.v       v18, (s1)
        vadd.vx v18, v18, a2
        vsll.vi v18, v18, 6
        vadd.vv v18, v18, v17
        vsetvli zero, zero, e64, m2, ta, ma
        vsext.vf2       v20, v18
        vsll.vi v18, v20, 3
        vluxei64.v      v18, (a0), v18
        vs2r.v  v18, (s0)
        vsetvli zero, zero, e32, m1, ta, ma
        vadd.vx v17, v17, a4
        add     s1, s1, s3
        sub     a5, a5, a4
        add     s0, s0, t1
        bnez    a5, .LBB0_57
        bnez    a6, .LBB0_61
.LBB0_59:
        li      a2, 0
        slli    a5, a6, 3
        add     a5, a5, a3
        slli    s1, a6, 2
        lui     a1, 2
        addiw   a1, a1, -1816
        add     a1, a1, sp
        add     s1, s1, a1
        li      a1, 64
        sub     s0, a1, a6
.LBB0_60:
        lw      a3, 0(s1)
        add     a3, a3, t4
        slliw   a3, a3, 6
        add     a3, a3, a2
        slli    a3, a3, 3
        add     a3, a3, a0
        fld     fa4, 0(a3)
        fsd     fa4, 0(a5)
        addi    a5, a5, 8
        addi    a2, a2, 1
        addi    s1, s1, 4
        bne     s0, a2, .LBB0_60
.LBB0_61:
        slli    a1, t5, 3
        ld      a2, 176(sp)
        mul     a7, t2, a2
        ld      a2, 192(sp)
        add     a7, a7, a2
        lui     a2, 2
        addiw   a2, a2, 232
        add     a5, sp, a2
        lui     a2, 2
        addiw   a2, a2, -1816
        add     s1, sp, a2
        mv      s0, a0
.LBB0_62:
        lw      a3, 0(s1)
        add     a2, s0, a1
        fld     fa4, 0(a2)
        add     a3, a3, t4
        slliw   a3, a3, 6
        fld     fa3, 0(a5)
        slli    a3, a3, 3
        add     a3, a3, s0
        fsd     fa4, 0(a3)
        fsd     fa3, 0(a2)
        addi    s0, s0, 8
        addi    a5, a5, 8
        addi    s1, s1, 4
        bne     s0, s2, .LBB0_62
        mv      t0, t6
        mv      s8, s5
        li      s0, 32
        lui     a1, 2
        addiw   a1, a1, 232
        add     s1, sp, a1
        bgeu    s5, t6, .LBB0_53
        li      t3, 0
        ld      s10, 168(sp)
        mv      s11, s9
        j       .LBB0_66
.LBB0_65:
        addi    t3, t3, 1
        addiw   s11, s11, 64
        addiw   s10, s10, 64
        beq     t3, s4, .LBB0_53
.LBB0_66:
        slli    t6, s10, 3
        slli    a6, s11, 3
        bltu    s0, s6, .LBB0_69
        slli    a1, t3, 6
        addw    a2, s7, a1
        slli    a2, a2, 3
        add     a3, s2, a2
        addw    a5, a7, a1
        slli    a5, a5, 3
        add     a1, a0, a5
        bgeu    a1, a3, .LBB0_72
        add     a2, a2, a0
        add     a5, a5, s2
        bgeu    a2, a5, .LBB0_72
.LBB0_69:
        li      a5, 0
.LBB0_70:
        add     a2, s2, t6
        slli    a5, a5, 3
        add     a1, a0, a5
        add     t6, t6, a1
        add     a1, a0, a5
        add     a6, a6, a1
        add     a5, a5, s1
.LBB0_71:
        fld     fa4, 0(a6)
        fld     fa3, 0(a5)
        fld     fa2, 0(t6)
        fmadd.d fa4, fa3, fa2, fa4
        fsd     fa4, 0(a6)
        addi    t6, t6, 8
        addi    a6, a6, 8
        addi    a5, a5, 8
        bne     t6, a2, .LBB0_71
        j       .LBB0_65
.LBB0_72:
        add     a2, a0, a6
        add     s0, a0, t6
        ld      a1, 216(sp)
        andi    a5, a1, 64
        lui     a1, 2
        addiw   a1, a1, 232
        add     s1, sp, a1
        vsetvli a1, zero, e64, m2, ta, ma
        ld      s5, 208(sp)
.LBB0_73:
        vl2re64.v       v18, (a2)
        vl2re64.v       v20, (s1)
        vl2re64.v       v22, (s0)
        vfmadd.vv       v22, v20, v18
        vs2r.v  v22, (a2)
        add     a2, a2, t1
        add     s1, s1, t1
        sub     s5, s5, a4
        add     s0, s0, t1
        bnez    s5, .LBB0_73
        li      s0, 32
        lui     a1, 2
        addiw   a1, a1, 232
        add     s1, sp, a1
        bnez    a5, .LBB0_65
        j       .LBB0_70
.LBB0_75:
        lui     a0, 3
        addiw   a0, a0, -160
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
        ld      s8, 416(sp)
        ld      s9, 408(sp)
        ld      s10, 400(sp)
        ld      s11, 392(sp)
        addi    sp, sp, 496
        ret