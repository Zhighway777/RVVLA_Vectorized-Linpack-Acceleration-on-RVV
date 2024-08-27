.LCPI0_0:
        .quad   3689348814741910324             # 0x3333333333333334
ddot(int, double*, int, double*, int):                         # @ddot(int, double*, int, double*, int)
        blez    a0, .LBB0_6
        li      a5, 1
        bne     a2, a5, .LBB0_7
        bne     a4, a5, .LBB0_7
        slli    a6, a0, 32
        lui     a2, 838861
        addi    a2, a2, -819
        slli    a2, a2, 32
        mulhu   a2, a6, a2
        srli    a2, a2, 34
        slli    a4, a2, 2
        subw    a2, a0, a2
        subw    t0, a2, a4
        beqz    t0, .LBB0_20
        csrr    t2, vlenb
        srli    t1, t2, 2
        bgeu    t0, t1, .LBB0_21
        li      a7, 0
        fmv.d.x fa0, zero
        j       .LBB0_24
.LBB0_6:
        fmv.d.x fa0, zero
        ret
.LBB0_7:
        subw    a5, a5, a0
        mulw    a6, a5, a4
        srai    t0, a4, 31
        mulw    a7, a5, a2
        csrr    t2, vlenb
        srli    a5, t2, 2
        li      t1, 8
        srai    t3, a2, 31
        bltu    t1, a5, .LBB0_9
        li      a5, 8
.LBB0_9:
        and     t1, t0, a6
        and     t3, t3, a7
        fmv.d.x fa0, zero
        bgeu    a0, a5, .LBB0_15
        li      t0, 0
.LBB0_11:
        mv      a6, t3
        mv      a7, t1
.LBB0_12:
        slli    a6, a6, 3
        add     a1, a1, a6
        slli    a2, a2, 3
        slli    a7, a7, 3
        add     a3, a3, a7
        slli    a4, a4, 3
        subw    a0, a0, t0
.LBB0_13:                               # =>This Inner Loop Header: Depth=1
        fld     fa5, 0(a1)
        fld     fa4, 0(a3)
        fmadd.d fa0, fa5, fa4, fa0
        add     a1, a1, a2
        addiw   a0, a0, -1
        add     a3, a3, a4
        bnez    a0, .LBB0_13
.LBB0_14:
        ret
.LBB0_15:
        li      a5, 1
        li      t0, 0
        bne     a2, a5, .LBB0_11
        bne     a4, a5, .LBB0_11
        srli    t4, t2, 3
        slli    a6, t4, 1
        slli    a5, t4, 31
        sub     a5, a5, a6
        and     t0, a5, a0
        mul     a6, t0, a2
        add     a6, a6, t3
        mul     a7, t0, a4
        add     a7, a7, t1
        srli    t2, t2, 2
        slli    t3, t3, 3
        add     t3, t3, a1
        slli    t1, t1, 3
        add     t5, a3, t1
        mul     t1, a2, t4
        slli    t1, t1, 4
        mul     t4, a4, t4
        vsetvli a5, zero, e64, m1, ta, ma
        vmv.s.x v8, zero
        slli    t4, t4, 4
        mv      t6, t0
.LBB0_18:                               # =>This Inner Loop Header: Depth=1
        vl2re64.v       v10, (t3)
        vl2re64.v       v12, (t5)
        vsetvli a5, zero, e64, m2, ta, ma
        vfmul.vv        v10, v10, v12
        vfredosum.vs    v8, v10, v8
        sub     t6, t6, t2
        add     t3, t3, t1
        add     t5, t5, t4
        bnez    t6, .LBB0_18
        vfmv.f.s        fa0, v8
        bne     t0, a0, .LBB0_12
        j       .LBB0_14
.LBB0_20:
        fmv.d.x fa0, zero
        j       .LBB0_27
.LBB0_21:
        srli    a2, t2, 3
        li      a4, 6
        mul     a2, a2, a4
        and     a7, a2, t0
        vsetvli a2, zero, e64, m1, ta, ma
        vmv.s.x v8, zero
        slli    t2, t2, 1
        mv      t3, a7
        mv      a5, a3
        mv      a2, a1
.LBB0_22:                               # =>This Inner Loop Header: Depth=1
        vl2re64.v       v10, (a2)
        vl2re64.v       v12, (a5)
        vsetvli a4, zero, e64, m2, ta, ma
        vfmul.vv        v10, v10, v12
        vfredosum.vs    v8, v10, v8
        add     a2, a2, t2
        sub     t3, t3, t1
        add     a5, a5, t2
        bnez    t3, .LBB0_22
        vfmv.f.s        fa0, v8
        beq     a7, t0, .LBB0_26
.LBB0_24:
        slli    a4, a7, 3
.Lpcrel_hi0:
        auipc   a2, %pcrel_hi(.LCPI0_0)
        ld      a7, %pcrel_lo(.Lpcrel_hi0)(a2)
        add     a2, a3, a4
        add     a4, a4, a1
        srli    a5, a6, 32
        mulhu   t1, a5, a7
        srli    a7, a6, 29
        li      a5, 40
        mul     a5, t1, a5
        add     a7, a7, a3
        sub     a5, a7, a5
.LBB0_25:                               # =>This Inner Loop Header: Depth=1
        fld     fa5, 0(a4)
        fld     fa4, 0(a2)
        fmadd.d fa0, fa5, fa4, fa0
        addi    a2, a2, 8
        addi    a4, a4, 8
        bne     a2, a5, .LBB0_25
.LBB0_26:
        li      a2, 5
        blt     a0, a2, .LBB0_14
.LBB0_27:
        bge     t0, a0, .LBB0_14
.Lpcrel_hi1:
        auipc   a2, %pcrel_hi(.LCPI0_0)
        ld      a2, %pcrel_lo(.Lpcrel_hi1)(a2)
        srli    a4, a6, 32
        mulhu   a2, a4, a2
        slli    a4, a2, 2
        subw    a5, a0, a2
        subw    a4, a5, a4
        srli    a6, a6, 29
        li      a5, 40
        mul     a2, a2, a5
        sub     a2, a6, a2
        addi    a2, a2, 16
        add     a1, a1, a2
        add     a3, a3, a2

.LBB0_29:                               # =>This Inner Loop Header: Depth=1
        vle64.v v0, (a1)
        vle64.v v1, (a3)
        vfmul.vv v2, v0, v1
        vfmadd.vf v2, fa0, v2, v2
        
        vle64.v v3, 8(a1)
        vle64.v v4, 8(a3)
        vfmadd.vv v2, v3, v4, v2
        
        vle64.v v5, 16(a1)
        vle64.v v6, 16(a3)
        vfmadd.vv v2, v5, v6, v2

        vmv.v.x v7, a4
        addiw a4, a4, 5
        addi a1, a1, 40
        addi a3, a3, 40
        blt a4, a0, .LBB0_29
        vmv.x.v fa0, v7
        j .LBB0_14

